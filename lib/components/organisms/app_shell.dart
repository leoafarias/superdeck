import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/utils.dart';
import '../../models/slide_model.dart';
import '../../providers/deck_provider.dart';
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
      duration: Durations.medium4,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );

    if (navigation.sideIsOpen.value) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final navigation = NavigationProvider.instance;

  final superdeck = SuperDeckProvider.instance;

  void _onTap(BuildContext context, int index) {
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
    final slides = superdeck.slides.watch(context);

    navigation.sideIsOpen.listen(context, () {
      if (navigation.sideIsOpen.value) {
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

    final navigationRail = NavigationRail(
      extended: false,
      selectedIndex: widget.navigationShell.currentIndex,
      onDestinationSelected: onTap,
      minWidth: 80,
      leading: const SizedBox(height: 20),
      labelType: NavigationRailLabelType.none,
      destinations: SideMenu.values.map(
        (e) {
          return NavigationRailDestination(
            icon: Icon(e.icon, size: 20),
            label: Text(e.label),
          );
        },
      ).toList(),
    );

    //  if screen small return a bottom bar navigation simila to the navigationRail
    final smallNavigation = BottomNavigationBar(
      currentIndex: widget.navigationShell.currentIndex,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      onTap: onTap,
      items: SideMenu.values.map(
        (e) {
          return BottomNavigationBarItem(
            icon: Icon(e.icon),
            label: e.label,
          );
        },
      ).toList(),
    );

    // Add bottom bar later
    final bottomNavBar = isSmall
        ? AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return SizeTransition(
                sizeFactor: _animation,
                axis: Axis.vertical,
                child: smallNavigation,
              );
            },
          )
        : null;

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
          onPressed: navigation.toggleSide,
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
