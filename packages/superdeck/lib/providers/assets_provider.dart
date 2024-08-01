import 'package:flutter/widgets.dart';

import '../superdeck.dart';

class AssetsProvider extends InheritedWidget {
  const AssetsProvider({
    super.key,
    required this.assets,
    required super.child,
  });

  final List<SlideAsset> assets;

  static AssetsProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AssetsProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant AssetsProvider oldWidget) {
    return assets != oldWidget.assets;
  }
}
