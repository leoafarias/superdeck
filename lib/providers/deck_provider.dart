import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:signals/signals_flutter.dart';
import 'package:watcher/watcher.dart';

import '../helpers/constants.dart';
import '../helpers/loader.dart';
import '../helpers/utils.dart';
import '../models/options_model.dart';
import '../superdeck.dart';

class SuperDeckProvider {
  SuperDeckProvider._();

  static SuperDeckProvider get instance => _instance;

  static final _instance = SuperDeckProvider._();

  final data = futureSignal(() async {
    if (kCanRunProcess) {
      await SlidesLoader.generate();
    }
    return SlidesLoader.loadFromStorage();
  });

  List<StreamSubscription<WatchEvent>> _subscriptions = [];

  late final listenToSlideChanges = effect(() {
    slides.value;
    final previousValue = slides.previousValue ?? [];

    if (listEquals(slides.value, previousValue)) {
      return;
    }

    final changes = compareListChanges(previousValue, slides.value);

    for (var added in changes.added) {
      print('Added: $added');
    }

    for (var removed in changes.removed) {
      print('Removed: $removed');
    }
  });

  final style = signal(const Style.empty());

  late final loading = computed(() {
    return data.value is AsyncLoading;
  });

  late final slides = computed(() => data.value.value?.slides ?? []);

  late final config =
      computed(() => data.value.value?.config ?? const ProjectConfig.empty());

  final examples = mapSignal<String, Example>({});

  late final error = computed(
    () {
      final data = this.data.value;
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
    _unsubscribe();
    batch(() {
      this.style.value = defaultStyle.merge(style);
      this.examples.assign(_examplesToMap(examples));
    });

    if (kCanRunProcess) {
      _subscriptions = SlidesLoader.listen(
        onChange: () async {
          data.refresh();
        },
      );
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
