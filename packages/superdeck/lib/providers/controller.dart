import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:signals/signals_flutter.dart';

import '../services/project_service.dart';
import '../styles/style_util.dart';
import '../superdeck.dart';

final superdeckController = SuperDeckController();
final navigationController = NavigationController();

class SuperDeckController {
  SuperDeckController._();

  static final _instance = SuperDeckController._();

  factory SuperDeckController() => _instance;

  final _data = futureSignal(ProjectService.instance.loadDeck);

  final style = signal(const Style.empty(), debugLabel: 'Style');

  late final loading = computed(() => _data.value is AsyncLoading);

  late final slides = computed(() => _data.value.value?.slides ?? []);
  late final assets = computed(() => _data.value.value?.assets ?? []);

  final examples = mapSignal<String, ExampleBuilder>({});

  late final error = computed(
    () {
      final data = _data.value;
      return data is AsyncError ? data.error : null;
    },
  );

  Future<void> initialize({
    Map<String, ExampleBuilder> examples = const {},
    Style? style,
  }) async {
    // Unsubscribe to listeners in case its a retry
    batch(() {
      this.style.value = defaultStyle.merge(style);
      this.examples.assign(examples);
    });

    if (_data.isDone) {
      await _data.reload();
    } else {
      await _data.future;
    }
  }

  void dispose() {
    style.dispose();
    error.dispose();
    assets.dispose();
    slides.dispose();
    _data.dispose();
    examples.dispose();
  }
}

class NavigationController {
  List<EffectCleanup>? _cleanup;
  NavigationController._() {
    initialize();
  }

  static final _instance = NavigationController._();

  factory NavigationController() => _instance;

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
    if (slide < 0 || slide >= superdeckController.slides.value.length) return;
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
