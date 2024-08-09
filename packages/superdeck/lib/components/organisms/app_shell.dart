import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/routes.dart';
import '../../helpers/utils.dart';
import '../../superdeck.dart';
import '../molecules/split_view.dart';

final kScaffoldKey = GlobalKey<ScaffoldState>();

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class AppShell extends HookWidget {
  const AppShell({
    required this.navigationShell,
    super.key = const ValueKey<String>('app_shell'),
  });

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isSmall = context.isSmall;

    final slides = useSlides();

    final invalidSlides = slides.whereType<InvalidSlide>().toList();

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
      ): handleNext,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
      ): handleNext,
      const SingleActivator(
        LogicalKeyboardKey.space,
      ): handleNext,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
      ): handlePrevious,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
      ): handlePrevious,
    };

    return CallbackShortcuts(
      bindings: bindings,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 9, 9, 9),
        bottomNavigationBar: null,
        extendBodyBehindAppBar: true,
        extendBody: true,
        key: kScaffoldKey,
        floatingActionButtonLocation: isSmall
            ? FloatingActionButtonLocation.miniEndFloat
            : FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton.small(
          onPressed: context.toggleDrawer,
          child: Badge(
            label: Text(invalidSlides.length.toString()),
            isLabelVisible: invalidSlides.isNotEmpty,
            child: const Icon(Icons.menu),
          ),
        ),
        body: SplitView(
          navigationShell: navigationShell,
        ),
      ),
    );
  }
}
