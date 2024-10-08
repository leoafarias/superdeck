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

class CapturingData {
  final bool isCapturing;

  CapturingData(this.isCapturing);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CapturingData && other.isCapturing == isCapturing;
  }

  @override
  int get hashCode => isCapturing.hashCode;
}
