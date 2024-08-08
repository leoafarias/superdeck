import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/utils.dart';
import '../../superdeck.dart';
import '../molecules/split_view.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class AppShell extends HookWidget {
  const AppShell({
    required this.navigationShell,
    super.key = const ValueKey<String>('ScaffoldWithNavBar'),
  });

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isSmall = context.isSmall;
    final navigation = useNavigation();
    final slides = useSlides();
    final invalidSlides = slides.whereType<InvalidSlide>().toList();

    final handlePrevious = useCallback(() {
      if (navigation.page == 0) return;
      navigation.goToPage(navigation.page - 1);
    }, [navigation]);

    final handleNext = useCallback(() {
      if (navigation.page == slides.length - 1) return;
      navigation.goToPage(navigation.page + 1);
    }, [navigation, slides.length]);

    final handleToggleSide = useCallback(() {
      if (navigation.sideIsOpen) {
        navigation.closeSide();
      } else {
        navigation.openSide();
      }
    }, [navigation.sideIsOpen]);

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
        key: scaffoldKey,
        floatingActionButtonLocation: isSmall
            ? FloatingActionButtonLocation.miniEndFloat
            : FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton.small(
          onPressed: handleToggleSide,
          child: Badge(
            label: Text(invalidSlides.length.toString()),
            isLabelVisible: invalidSlides.isNotEmpty,
            child: const Icon(Icons.menu),
          ),
        ),
        body: SplitView(child: navigationShell),
      ),
    );
  }
}
