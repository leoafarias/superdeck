import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../common/helpers/extensions.dart';
import '../deck_reference/deck_reference_hooks.dart';
import 'navigation_controller.dart';
import 'navigation_provider.dart';

NavigationController _useController() {
  final context = useContext();

  return useListenable(context.watch<NavigationProvider>().controller);
}

T _useSelectController<T>(T Function(NavigationController) selector) {
  final controller = _useController();
  return selector(controller);
}

typedef NavigationControllerState = ({
  int currentSlideIndex,
  bool isPresenterMenuOpen,
});

NavigationControllerState useNavigationState() {
  return _useSelectController((c) => (
        currentSlideIndex: c.currentSlideIndex,
        isPresenterMenuOpen: c.isPresenterMenuOpen,
      ));
}

typedef NavigationActions = ({
  VoidCallback nextSlide,
  VoidCallback previousSlide,
  VoidCallback closePresenterMenu,
  VoidCallback openPresenterMenu,
  VoidCallback togglePresenterMenu,
  void Function(int index) goToSlide,
});

NavigationActions useNavigationActions() {
  final context = useContext();
  final controller = _useController();
  final slides = useDeckSlides();
  final currentIndex = useCurrentSlideIndex();

  final goToSlide = useCallback((int index) {
    if (index < 0 || index >= slides.length) return;
    if (currentIndex == index) return;

    controller.goToSlide(index);
  }, [context, slides, currentIndex]);

  final goToNextSlide = useCallback(
    () => goToSlide(controller.currentSlideIndex + 1),
    [goToSlide],
  );

  final goToPreviousSlide = useCallback(
    () => goToSlide(controller.currentSlideIndex - 1),
    [goToSlide],
  );

  return (
    nextSlide: goToNextSlide,
    previousSlide: goToPreviousSlide,
    closePresenterMenu: controller.closePresenterMenu,
    openPresenterMenu: controller.openPresenterMenu,
    togglePresenterMenu: controller.togglePresenterMenu,
    goToSlide: goToSlide,
  );
}

bool useIsPresenterMenuOpen() {
  return _useSelectController((c) => c.isPresenterMenuOpen);
}

int useCurrentSlideIndex() {
  return _useSelectController((c) => c.currentSlideIndex);
}
