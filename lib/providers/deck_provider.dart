import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:signals/signals_flutter.dart';

import '../helpers/constants.dart';
import '../helpers/loader.dart';
import '../superdeck.dart';

class SuperDeckProvider {
  SuperDeckProvider._();

  static final instance = SuperDeckProvider._();

  final _data = futureSignal(() => SlidesLoader.instance.loadFromStorage());

  final style = signal(const Style.empty(), debugLabel: 'Style');

  late final loading = computed(() => _data.value is AsyncLoading);

  late final slides = computed(() => _data.value.value?.slides ?? []);
  late final assets = computed(() => _data.value.value?.assets ?? []);
  late final config =
      computed(() => _data.value.value?.config ?? const ProjectConfig.empty());

  final examples = mapSignal<String, Example>({});

  late final error = computed(
    () {
      final data = _data.value;
      return data is AsyncError ? data.error : null;
    },
  );

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

  Future<void> initialize({
    List<Example> examples = const [],
    Style? style,
  }) async {
    // Unsubscribe to listeners in case its a retry
    await _data.future;
    update(examples: examples, style: style);

    if (kCanRunProcess) {
      SlidesLoader.instance.listen(
        onChange: () => _data.refresh(),
      );
    }
  }

  void dispose() {
    style.dispose();
    _data.dispose();
    examples.dispose();
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
