import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';

import '../helpers/value_notifiers.dart';
import '../models/asset_model.dart';
import '../models/slide_model.dart';
import '../services/reference_service.dart';

final superdeckController = SuperDeckController();

class SuperDeckController {
  SuperDeckController._() {
    _loadData();
  }

  final loading = ValueNotifier(false);
  final error = ValueNotifier<Object?>(null);
  final slides = ListNotifier<Slide>([]);
  final assets = ListNotifier<SlideAsset>([]);
  final completed = ValueNotifier(false);
  final isRefreshing = ValueNotifier(false);

  /// Navigation
  final currentSlide = StoredValueNotifier('current-slide', 0);
  final sideIsOpen = StoredValueNotifier('side-is-open', false);
  final currentScreen = StoredValueNotifier('current-screen', 0);

  static final _instance = SuperDeckController._();

  factory SuperDeckController() => _instance;

  Future<void> _loadData() async {
    loading.value = true;
    error.value = null;
    completed.value = false;

    try {
      final data = await ReferenceService.instance.loadReference();

      slides.value = data.slides;
      assets.value = data.assets;
    } catch (e) {
      error.value = e;
    } finally {
      completed.value = true;
      loading.value = false;
      isRefreshing.value = false;
    }
  }

  Future<void> refresh() async {
    isRefreshing.value = true;
    await _loadData();
  }

  void toggleSide() {
    batch(() {
      if (sideIsOpen.value) {
        currentScreen.value = 0;
      }
      sideIsOpen.value = !sideIsOpen.value;
    });
  }

  void goToSlide(int slide) {
    if (slide < 0 || slide >= superdeckController.slides.length) return;
    currentSlide.value = slide;
  }

  void nextSlide() {
    goToSlide(currentSlide.value + 1);
  }

  void previousSlide() {
    goToSlide(currentSlide.value - 1);
  }

  void goToScreen(int screen) {
    currentScreen.value = screen;
  }

  void dispose() {
    loading.dispose();
    error.dispose();
    slides.dispose();
    assets.dispose();
    completed.dispose();
    isRefreshing.dispose();
    currentSlide.dispose();
    sideIsOpen.dispose();
    currentScreen.dispose();
  }
}

List<Slide> useSlides() {
  return useListenable(superdeckController.slides).value;
}

List<InvalidSlide> useInvalidSlides() {
  return useSlides().whereType<InvalidSlide>().toList();
}

int useCurrentSlide() {
  return useListenable(superdeckController.currentSlide).value;
}

bool useSideIsOpen() {
  return useListenable(superdeckController.sideIsOpen).value;
}

void useOnSideIsOpenChanged(void Function(bool) callback) {
  _useOnValueChanged(superdeckController.sideIsOpen, (_) {
    callback(superdeckController.sideIsOpen.value);
  });
}

void useOnSlideChange(void Function(int) callback) {
  _useOnValueChanged(superdeckController.currentSlide, (_) {
    callback(superdeckController.currentSlide.value);
  });
}

void _useOnValueChanged<T>(
  ValueListenable<T> listenable,
  void Function(T) callback,
) {
  useEffect(() {
    listener() {
      callback(listenable.value);
    }

    listenable.addListener(listener);

    return () {
      listenable.removeListener(listener);
    };
  }, [listenable, callback]);
}
