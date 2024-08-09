import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remix/remix.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/syntax_highlighter.dart';
import '../../superdeck.dart';
import '../helpers/constants.dart';
import '../helpers/routes.dart';
import '../helpers/theme.dart';
import '../providers/examples_provider.dart';
import '../providers/snapshot_provider.dart';
import '../providers/style_provider.dart';
import 'atoms/loading_indicator.dart';

final _uniqueKey = UniqueKey();
var _initialized = false;

class SuperDeckApp extends HookWidget {
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

    WidgetsFlutterBinding.ensureInitialized();

    await Future.wait([
      SuperDeckController.initialize(),
      SyntaxHighlight.initialize(),
      _initializeWindowManager(),
    ]);

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SuperDeckApp.initialize(),
      builder: (context, snapshot) {
        return StyleProvider(
          baseStyle: baseStyle,
          styles: styles,
          child: ExamplesProvider(
            examples: examples,
            child: ListenableBuilder(
                listenable: $superdeck,
                builder: (context, snapshot) {
                  return RemixTokens(
                    data: RemixTokens.dark,
                    child: MaterialApp.router(
                      debugShowCheckedModeBanner: true,
                      title: 'Superdeck',
                      routerConfig: goRouterConfig,
                      theme: theme,
                      builder: (context, child) {
                        return SnapshotProvider(
                          child: LoadingOverlay(
                            isLoading: $superdeck.loading,
                            key: _uniqueKey,
                            child: $superdeck.completed
                                ? child!
                                : const SizedBox(),
                          ),
                        );
                      },
                    ),
                  );
                }),
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
