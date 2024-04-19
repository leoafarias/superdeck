import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:signals/signals_flutter.dart';
import 'package:watcher/watcher.dart';

import '../helpers/loader.dart';
import '../models/asset_model.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../superdeck.dart';

final superdeck = SuperDeckProvider.instance;

class SuperDeckProvider {
  SuperDeckProvider._();

  static SuperDeckProvider get instance => _instance;

  static final _instance = SuperDeckProvider._();

  List<StreamSubscription<WatchEvent>> _subscriptions = [];

  final style = signal(const Style.empty());

  final config = signal(const Config.empty());

  final loading = signal(true);
  final list = listSignal<int>([]);

  final slides = listSignal<Slide>([]);

  final assets = listSignal<SlideAsset>([]);

  final examples = mapSignal<String, Example>({});

  late final totalInvalid = computed(() {
    return slides.value.whereType<InvalidSlide>().length;
  });

  final error = signal<Exception?>(null);

  Map<String, Example> _examplesToMap(List<Example> examples) {
    return {for (var e in examples) e.name: e};
  }

  void update({
    List<Example> examples = const [],
    Style? style,
  }) {
    batch(() {
      this.style.value = defaultStyle.merge(style);
      this.examples.assign(_examplesToMap(examples));
    });
  }

  Future<void> _loadData() async {
    final (:slides, :assets, :config) = await SlidesLoader.loadFromStorage();

    batch(() {
      this.slides.assign(slides);
      this.assets.assign(assets);
      this.config.value = config;
    });
  }

  Future<void> initialize({
    List<Example> examples = const [],
    Style? style,
  }) async {
    try {
      batch(() {
        loading.value = true;
        error.value = null;
      });
      // Unsubscribe to listeners in case its a retry
      _unsubscribe();
      batch(() {
        this.style.value = defaultStyle.merge(style);
        this.examples.assign(_examplesToMap(examples));
      });
      await SlidesLoader.generate();
      await _loadData();

      if (kDebugMode && !kIsWeb) {
        _subscriptions = SlidesLoader.listen(
          onChange: _loadData,
          onError: (e) => error.value = e,
        );
      }
    } on Exception catch (e) {
      error.value = e;
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  void _unsubscribe() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
  }

  void dispose() {
    style.dispose();

    slides.dispose();
    assets.dispose();
    examples.dispose();
    _unsubscribe();
  }
}

class NavigationProvider {
  List<EffectCleanup>? _cleanup;
  NavigationProvider._() {
    initialize();
  }

  static NavigationProvider get instance => _instance;

  static final _instance = NavigationProvider._();

  late final currentSlide = signal(0);
  late final sideIsOpen = signal(false);
  late final currentScreen = signal(0);

  void initialize() {
    currentSlide.value = _getItem<int>('current-slide') ?? 0;
    sideIsOpen.value = _getItem<bool>('side-is-open') ?? false;
    currentScreen.value = _getItem<int>('current-screen') ?? 0;

    _cleanup = [
      effect(() {
        _setItem('side-is-open', sideIsOpen.value);
        _setItem('current-slide', currentSlide.value);
        _setItem('current-screen', currentScreen.value);
      })
    ];
  }

  void toggleSide() {
    batch(() {
      if (sideIsOpen.value) {
        currentScreen.value = 0;
      }
      sideIsOpen.value = !sideIsOpen.peek();
    });
  }

  void goToSlide(int slide) {
    currentSlide.value = slide;
  }

  void nextSlide() {
    goToSlide(currentSlide.peek() + 1);
  }

  void previousSlide() {
    goToSlide(currentSlide.peek() - 1);
  }

  void goToScreen(int screen) {
    currentScreen.value = screen;
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
    sideIsOpen.dispose();
    _cleanup?.forEach((e) => e.call());
  }
}

extension ListSignalExtension<T> on ListSignal<T> {
  void assign(List<T> value) {
    if (listEquals(peek(), value)) return;
    this.value = value;
  }
}

extension MapSignalExtension<K, V> on MapSignal<K, V> {
  void assign(Map<K, V> value) {
    if (mapEquals(peek(), value)) return;
    this.value = value;
  }
}
