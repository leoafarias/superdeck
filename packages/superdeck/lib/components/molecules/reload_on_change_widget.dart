import 'dart:async';

import 'package:flutter/material.dart';
import 'package:watcher/watcher.dart';

class ReloadOnChange extends StatefulWidget {
  final Widget child;
  final String directoryPath;

  const ReloadOnChange({
    super.key,
    required this.child,
    required this.directoryPath,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ReloadOnChangeState createState() => _ReloadOnChangeState();
}

class _ReloadOnChangeState extends State<ReloadOnChange> {
  late final DirectoryWatcher _directoryWatcher;
  late Key key;
  StreamSubscription<WatchEvent>? _watcherSubscription;

  @override
  void initState() {
    super.initState();
    key = UniqueKey();
    _initializeWatcher();
  }

  _initializeWatcher() {
    const directoryPath = 'lib/dash_deck/generated'; // Your specific path here
    _directoryWatcher = DirectoryWatcher(directoryPath);
    _watcherSubscription = _directoryWatcher.events.listen((event) {
      print(event.path);
      setState(() {
        key = UniqueKey();
      });
    });
  }

  @override
  void dispose() {
    _watcherSubscription
        ?.cancel(); // Cancel the subscription when disposing of the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}
