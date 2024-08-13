import 'package:flutter/widgets.dart';

class SnapshotRef {
  BuildContext? _context;

  SnapshotRef._();

  static final SnapshotRef instance = SnapshotRef._();

  void setContext(BuildContext context) {
    Scrollable.ensureVisible(context);
    _context = context;
  }

  BuildContext get context {
    assert(_context != null, '$runtimeType has not updated its context');
    return _context!;
  }
}

class SnapshotProvider extends InheritedWidget {
  final bool isCapturing;

  const SnapshotProvider({
    required this.isCapturing,
    required super.child,
    super.key,
  });

  static SnapshotProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SnapshotProvider>();
  }

  @override
  bool updateShouldNotify(covariant SnapshotProvider oldWidget) {
    return oldWidget.isCapturing != isCapturing;
  }

  static bool isCapturingOf(BuildContext context) {
    return of(context)?.isCapturing ?? false;
  }
}
