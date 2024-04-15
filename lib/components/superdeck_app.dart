import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:signals/signals_flutter.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/constants.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../models/options_model.dart';
import '../../superdeck.dart';
import '../helpers/theme.dart';

class SuperDeckApp extends StatefulWidget {
  const SuperDeckApp({
    super.key,
    this.style,
    this.examples = const [],
  });

  final Style? style;
  final List<Example> examples;

  @override
  // ignore: library_private_types_in_public_api
  _SuperDeckAppState createState() => _SuperDeckAppState();
}

class _SuperDeckAppState extends State<SuperDeckApp> {
  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void dispose() {
    super.dispose();
    superDeck.dispose();
    deckState.dispose();
  }

  Future<void> _initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    SignalsObserver.instance = null;

    await initLocalStorage();
    await SyntaxHighlight.initialize();

    await deckState.initialize();
    await superDeck.initialize(
      style: widget.style,
      examples: widget.examples,
    );

    // Return if its web
    if (kIsWeb) return;
    // Must add this line.
    await _initializeWindowManager();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: MixTheme(
        data: MixThemeData.withMaterial(),
        child: Scaffold(
          body: superDeck.loading.watch(context)
              ? const Center(child: CircularProgressIndicator())
              : AppShell(),
        ),
      ),
    );
  }
}

Future<void> _initializeWindowManager() async {
  // Must add this line.
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: kResolution,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    minimumSize: Size(640, 360),
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await windowManager.setAspectRatio(kAspectRatio);
}
