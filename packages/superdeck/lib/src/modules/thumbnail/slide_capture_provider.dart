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
