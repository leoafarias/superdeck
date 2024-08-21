import 'package:flutter/widgets.dart';
import 'package:superdeck_core/superdeck_core.dart';

class AssetsProvider extends InheritedWidget {
  const AssetsProvider({
    super.key,
    required this.assets,
    required super.child,
  });

  final List<SlideAsset> assets;

  static List<SlideAsset> of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<AssetsProvider>()
            ?.assets ??
        [];
  }

  static AssetsProvider inherit({
    required BuildContext context,
    required Widget child,
  }) {
    return AssetsProvider(assets: of(context), child: child);
  }

  @override
  bool updateShouldNotify(covariant AssetsProvider oldWidget) {
    return assets != oldWidget.assets;
  }
}
