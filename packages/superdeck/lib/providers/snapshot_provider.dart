import 'package:flutter/widgets.dart';

class SnapshotProvider extends InheritedWidget {
  const SnapshotProvider({
    super.key,
    required this.isSnapshot,
    required super.child,
  });

  final bool isSnapshot;

  static bool of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<SnapshotProvider>()
            ?.isSnapshot ??
        false;
  }

  @override
  bool updateShouldNotify(covariant SnapshotProvider oldWidget) {
    return isSnapshot != oldWidget.isSnapshot;
  }
}
