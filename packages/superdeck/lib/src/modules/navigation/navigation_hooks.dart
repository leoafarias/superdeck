import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../common/helpers/routes.dart';
import '../deck/deck_hooks.dart';
import 'navigation_controller.dart';

NavigationController _useController() {
  final context = useContext();

  return useListenable(
    NavigationController.of(context),
  );
}

T _useSelectController<T>(T Function(NavigationController) selector) {
  final controller = _useController();
  return selector(controller);
}

typedef NavigationControllerState = ({
  bool isPresenterMenuOpen,
  bool showNotes,
});

NavigationControllerState useNavigationState() {
  return _useSelectController(
    (c) => (
      isPresenterMenuOpen: c.isPresenterMenuOpen,
      showNotes: c.showNotes,
    ),
  );
}

typedef NavigationActions = ({
  VoidCallback nextSlide,
  VoidCallback previousSlide,
  VoidCallback closePresenterMenu,
  VoidCallback openPresenterMenu,
  VoidCallback togglePresenterMenu,
  VoidCallback toggleShowNotes,
  void Function(int index) goToSlide,
});

GoRouterState _useGoRouterState() {
  final context = useContext();
  final routerState = GoRouterState.of(context);
  final state = useState(routerState);

  useEffect(() {
    state.value = routerState;
  }, [routerState]);

  return state.value;
}

// Get the currentSlide index from the current path
int useCurrentSlideIndex() {
  final router = _useGoRouterState();
  final param = router.pathParameters[SDPaths.slides.slide.id] ?? '0';

  return int.tryParse(param) ?? 0;
}

NavigationActions useNavigationActions() {
  final context = useContext();
  final controller = _useController();
  final slides = useSlides();
  final currentIndex = useCurrentSlideIndex();

  final goToSlide = useCallback((int index) {
    if (index < 0 || index >= slides.length) return;
    if (currentIndex == index) return;

    final isForward = index > currentIndex;
    final slidePath = SDPaths.slides.slide.define(index.toString()).path;

    context.pushReplacement(slidePath, extra: {'replace': !isForward});
  }, [context, slides, currentIndex]);

  final goToNextSlide = useCallback(
    () => goToSlide(currentIndex + 1),
    [goToSlide, currentIndex],
  );

  final goToPreviousSlide = useCallback(
    () => goToSlide(currentIndex - 1),
    [
      goToSlide,
    ],
  );

  return (
    nextSlide: goToNextSlide,
    previousSlide: goToPreviousSlide,
    closePresenterMenu: controller.closePresenterMenu,
    openPresenterMenu: controller.openPresenterMenu,
    togglePresenterMenu: controller.togglePresenterMenu,
    goToSlide: goToSlide,
    toggleShowNotes: controller.toggleShowNotes,
  );
}

bool useIsPresenterMenuOpen() {
  return _useSelectController((c) => c.isPresenterMenuOpen);
}
