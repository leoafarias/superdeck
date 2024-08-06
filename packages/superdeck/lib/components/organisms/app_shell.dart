import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/constants.dart';
import '../../helpers/hooks.dart';
import '../../helpers/utils.dart';
import '../../superdeck.dart';
import 'drawer.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends HookWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key = const ValueKey<String>('ScaffoldWithNavBar'),
  });

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      // initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = context.isSmall;
    final navigation = useNavigation();
    final slides = useSlides();
    final invalidSlides = slides.whereType<InvalidSlide>().toList();
    final animationController = useAnimationController(
      duration: Durations.short3,
    );

    final animation = useAnimation(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));

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

    usePostFrameEffect(() {
      if (navigation.sideIsOpen) {
        animationController.forward();
      } else {
        animationController.reverse();
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

    void onTap(int index) {
      _onTap(context, index);
    }

    final menuItems = kCanRunProcess ? SideMenu.devMenu : SideMenu.prodMenu;

    final navigationRail = NavigationRail(
      extended: false,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: onTap,
      minWidth: 80,
      leading: const SizedBox(height: 20),
      labelType: NavigationRailLabelType.none,
      destinations: menuItems
          .map((e) => NavigationRailDestination(
                icon: Icon(e.icon, size: 20),
                label: Text(e.label),
              ))
          .toList(),
    );

    return CallbackShortcuts(
      bindings: bindings,
      child: Scaffold(
        bottomNavigationBar: null,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          toolbarOpacity: animation,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.picture_as_pdf,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: handlePrevious,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: handleNext,
            ),
          ],
        ),
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
        body: Row(
          children: [
            _SizeTransition(
              sizeFactor: animation,
              direction: Axis.horizontal,
              child: navigationRail,
            ),
            Expanded(child: navigationShell),
          ],
        ),
      ),
    );
  }
}

class _SizeTransition extends StatelessWidget {
  const _SizeTransition({
    required this.sizeFactor,
    this.child,
    this.direction = Axis.horizontal,
  });

  final double sizeFactor;
  final Axis direction;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    AlignmentDirectional alignment;
    if (direction == Axis.horizontal) {
      alignment = const AlignmentDirectional(0.0, -1.0);
    } else {
      alignment = const AlignmentDirectional(-1.0, 0.0);
    }
    return ClipRect(
      child: Align(
        alignment: alignment,
        heightFactor:
            direction == Axis.vertical ? math.max(sizeFactor, 0.0) : 1.0,
        widthFactor:
            direction == Axis.horizontal ? math.max(sizeFactor, 0.0) : 1.0,
        child: child,
      ),
    );
  }
}
