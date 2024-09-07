import 'package:flutter/widgets.dart';

import 'navigation_controller.dart';

class NavigationProvider extends InheritedNotifier<NavigationController> {
  const NavigationProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  final NavigationController controller;
}
