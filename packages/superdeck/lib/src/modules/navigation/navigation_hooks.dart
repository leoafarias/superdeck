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

NavigationController useNavigation() {
  return _useController();
}

typedef NavigationActions = ({
  VoidCallback nextSlide,
  VoidCallback previousSlide,
  VoidCallback closePresenterMenu,
  VoidCallback openPresenterMenu,
  VoidCallback togglePresenterMenu,
});

NavigationActions useNavigationActions() {
  final controller = _useController();
  final slides = useDeckSlides();
  final goToSlide = useCallback((index) {
    if (index < 0 || index >= slides.length) return;
    controller.goToSlide(index);
  });

  final goToNextSlide = useCallback(
    () => goToSlide(controller.currentSlideIndex + 1),
  );

  final goToPreviousSlide = useCallback(
    () => goToSlide(controller.currentSlideIndex - 1),
  );

  return (
    nextSlide: goToNextSlide,
    previousSlide: goToPreviousSlide,
    closePresenterMenu: controller.closePresenterMenu,
    openPresenterMenu: controller.openPresenterMenu,
    togglePresenterMenu: controller.togglePresenterMenu,
  );
}

bool useIsPresenterMenuOpen() {
  return _useSelectController((c) => c.isPresenterMenuOpen);
}

int useCurrentSlideIndex() {
  return _useSelectController((c) => c.currentSlideIndex);
}
