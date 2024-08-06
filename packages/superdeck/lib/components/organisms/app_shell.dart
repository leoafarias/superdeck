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
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

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
    final animationController = useAnimationController(
      duration: Durations.short3,
    );

    final animation = useAnimation(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));

    usePostFrameEffect(() {
      if (navigation.sideIsOpen) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      return;
    }, [navigation.sideIsOpen]);

    final invalidSlides = useInvalidSlides();

    final bindings = {
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
      ): navigation.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
      ): navigation.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.space,
      ): navigation.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
      ): navigation.previousSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
      ): navigation.previousSlide,
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

    final sideNavBar = !isSmall
        ? _SizeTransition(
            sizeFactor: animation,
            child: navigationRail,
          )
        : null;

    return CallbackShortcuts(
      bindings: bindings,
      child: Scaffold(
        bottomNavigationBar: null,
        key: scaffoldKey,
        floatingActionButtonLocation: isSmall
            ? FloatingActionButtonLocation.miniEndFloat
            : FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton.small(
          onPressed: navigation.toggleSide,
          child: Badge(
            label: Text(invalidSlides.length.toString()),
            isLabelVisible: invalidSlides.isNotEmpty,
            child: const Icon(Icons.menu),
          ),
        ),
        body: isSmall
            ? navigationShell
            : Row(
                children: [
                  sideNavBar ?? Container(),
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
  });

  final double sizeFactor;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: const AlignmentDirectional(0.0, -1.0),
        heightFactor: null,
        widthFactor: math.max(sizeFactor, 0.0),
        child: child,
      ),
    );
  }
}
