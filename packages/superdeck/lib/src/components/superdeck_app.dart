import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:window_manager/window_manager.dart';

import '../../../superdeck.dart';
import '../modules/common/helpers/constants.dart';
import '../modules/common/helpers/routes.dart';
import '../modules/common/helpers/syntax_highlighter.dart';
import '../modules/common/helpers/theme.dart';
import '../modules/deck_reference/deck_reference_provider.dart';

var _initialized = false;

class SuperDeckApp extends StatelessWidget {
  const SuperDeckApp({
    super.key,
    this.baseStyle = const Style.empty(),
    this.styles = const <String, Style>{},
    this.examples = const <String, ExampleBuilder>{},
  });

  final Style baseStyle;
  final Map<String, ExampleBuilder> examples;
  final Map<String, Style> styles;

  static Future<void> initialize() async {
    // Return if its initialized
    if (_initialized) return;

    _initialized = true;

    WidgetsFlutterBinding.ensureInitialized();

    await Future.wait([
      SyntaxHighlight.initialize(),
      _initializeWindowManager(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SuperDeckApp.initialize(),
      builder: (context, snapshot) {
        return DecKReferenceProvider(
          styles: styles,
          baseStyle: baseStyle,
          examples: examples,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: true,
            title: 'Superdeck',
            routerConfig: goRouterConfig,
            theme: theme,
          ),
        );
      },
    );
  }
}

Future<void> _initializeWindowManager() async {
  if (kIsWeb) return;

  // Must add this line.
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: kResolution,
    backgroundColor: Colors.black,
    skipTaskbar: false,
    minimumSize: kResolution,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await windowManager.setAspectRatio(kAspectRatio);
}
