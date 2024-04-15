import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:signals/signals_flutter.dart';
import 'package:watcher/watcher.dart';

import '../helpers/loader.dart';
import '../helpers/markdown_processor.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../superdeck.dart';

final superDeck = SuperDeckProvider.instance;
final deckState = DeckState.instance;

class SuperDeckProvider {
  SuperDeckProvider._();

  static SuperDeckProvider get instance => _instance;

  static final _instance = SuperDeckProvider._();

  List<StreamSubscription<WatchEvent>> _subscriptions = [];

  final style = signal(const Style.empty());
  final data = signal(emptyDeckData);

  final loading = signal(true);

  late final slides = computed(() => data.value.slides);

  late final assets = computed(() => data.value.assets);

  final examples = mapSignal<String, Example>({});

  late final totalInvalid =
      computed(() => slides.value.whereType<InvalidSlide>().length);

  Future<void> initialize({
    List<Example> examples = const [],
    Style? style,
  }) async {
    try {
      this.style.value = defaultStyle.merge(style);

      this.examples.value =
          examples.fold({}.cast<String, Example>(), (acc, builder) {
        acc[builder.name] = builder;
        return acc;
      });
      data.value = await SlidesLoader.loadFromStorage();

      if (kDebugMode && !kIsWeb) {
        _subscriptions = SlidesLoader.listen((payload) => data.value = payload);
      }
    } catch (e) {
      print('Error loading slides: $e');
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  void dispose() {
    style.dispose();
    data.dispose();
    slides.dispose();
    assets.dispose();
    examples.dispose();
    for (var sub in _subscriptions) {
      sub.cancel();
    }

    _subscriptions.clear();
  }
}

class DeckState {
  List<EffectCleanup>? _cleanup;
  DeckState._();

  ({
    Signal<int> currentSlide,
    Signal<bool> menuIsOpen,
    Signal<int> menuSelection
  }) call() {
    return (
      currentSlide: currentSlide,
      menuIsOpen: menuIsOpen,
      menuSelection: menuSelection
    );
  }

  static DeckState get instance => _instance;
  static final _instance = DeckState._();
  late final currentSlide = signal(0);
  late final menuIsOpen = signal(false);
  late final menuSelection = signal(0);

  Future<void> initialize() async {
    currentSlide.value = _getItem<int>('current-slide') ?? 0;
    menuIsOpen.value = _getItem<bool>('menu-is-open') ?? false;
    menuSelection.value = _getItem<int>('menu-option') ?? 0;

    _cleanup = [
      effect(() {
        _setItem('menu-is-open', menuIsOpen.value);
        _setItem('current-slide', currentSlide.value);
        _setItem('menu-option', menuSelection.value);
      })
    ];
  }

  void _setItem<T>(String key, T value) {
    localStorage.setItem(key, jsonEncode(value));
  }

  T? _getItem<T>(String key) {
    final stringValue = localStorage.getItem(key);
    return stringValue == null ? null : jsonDecode(stringValue) as T;
  }

  void dispose() {
    currentSlide.dispose();
    menuIsOpen.dispose();
    _cleanup?.forEach((e) => e.call());
  }
}
