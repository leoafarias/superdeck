import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../models/slide_model.dart';
import '../../providers/sd_provider.dart';
import '../../superdeck.dart';
import '../molecules/split_view.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;
  final navigation = NavigationProvider.instance;
  final superdeck = SuperDeckProvider.instance;

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
    final slides = superdeck.slides.watch(context);

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

    return CallbackShortcuts(
      bindings: bindings,
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: navigation.toggleSide,
          child: Badge(
            label: Text(totalInvalid.toString()),
            isLabelVisible: totalInvalid != 0,
            child: const Icon(Icons.menu),
          ),
        ),
        body: SplitView(
          currentIndex: navigationShell.currentIndex,
          onIndexChange: (int index) => _onTap(context, index),
          child: navigationShell,
        ),
      ),
    );
  }
}
