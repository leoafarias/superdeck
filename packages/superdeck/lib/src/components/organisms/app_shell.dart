import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../modules/common/helpers/routes.dart';
import '../../modules/deck_reference/deck_reference_hooks.dart';
import '../molecules/split_view.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class AppShell extends HookWidget {
  const AppShell({
    required this.child,
    super.key = const ValueKey<String>('app_shell'),
  });

  /// The navigation shell and container for the branch Navigators.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final slides = useDeckSlides();

    final handleNext = useCallback(() {
      if (context.currentSlidePage < slides.length) {
        context.nextSlide();
      }
    }, [slides]);

    final handlePrevious = useCallback(() {
      if (context.currentSlidePage > 1) {
        context.previousSlide();
      }
    }, [slides]);

    final bindings = {
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
        meta: true,
      ): handleNext,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
        meta: true,
      ): handleNext,
      const SingleActivator(
        LogicalKeyboardKey.space,
        meta: true,
      ): handleNext,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
        meta: true,
      ): handlePrevious,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
        meta: true,
      ): handlePrevious,
    };

    return CallbackShortcuts(
      bindings: bindings,
      child: SplitView(child: child),
    );
  }
}
