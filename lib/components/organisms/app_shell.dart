import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../helpers/utils.dart';
import '../../superdeck.dart';
import 'drawer.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatefulWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Durations.short3,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );

    if (navigationController.sideIsOpen.value) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap(BuildContext context, int index) {
    if (index == SideMenu.clearCache.index) {
      superdeckController.clearGenerated();
      return;
    }
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    widget.navigationShell.goBranch(
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
    final slides = superdeckController.slides.watch(context);

    navigationController.sideIsOpen.listen(context, () {
      if (navigationController.sideIsOpen.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    final isSmall = context.isSmall;

    final totalInvalid = slides.whereType<InvalidSlide>().length;

    final bindings = {
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
      ): navigationController.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
      ): navigationController.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.space,
      ): navigationController.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
      ): navigationController.previousSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
      ): navigationController.previousSlide,
    };

    void onTap(int index) {
      _onTap(context, index);
    }

    final menuItems = kCanRunProcess ? SideMenu.devMenu : SideMenu.prodMenu;

    final navigationRail = NavigationRail(
      extended: false,
      selectedIndex: widget.navigationShell.currentIndex,
      onDestinationSelected: onTap,
      minWidth: 80,
      leading: const SizedBox(height: 20),
      labelType: NavigationRailLabelType.none,
      destinations: menuItems.map(
        (e) {
          return NavigationRailDestination(
            icon: Icon(e.icon, size: 20),
            label: Text(e.label),
          );
        },
      ).toList(),
    );

    final sideNavBar = !isSmall
        ? AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return SizeTransition(
                sizeFactor: _animation,
                axis: Axis.horizontal,
                child: navigationRail,
              );
            })
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
          onPressed: navigationController.toggleSide,
          child: Badge(
            label: Text(totalInvalid.toString()),
            isLabelVisible: totalInvalid != 0,
            child: const Icon(Icons.menu),
          ),
        ),
        body: isSmall
            ? widget.navigationShell
            : Row(
                children: [
                  sideNavBar ?? Container(),
                  Expanded(child: widget.navigationShell),
                ],
              ),
      ),
    );
  }
}
