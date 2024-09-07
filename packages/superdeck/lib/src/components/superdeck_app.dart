import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../../superdeck.dart';
import '../modules/common/helpers/constants.dart';
import '../modules/common/helpers/routes.dart';
import '../modules/common/helpers/syntax_highlighter.dart';
import '../modules/common/helpers/theme.dart';
import '../modules/deck_reference/deck_reference_provider.dart';
import '../modules/navigation/navigation_controller.dart';
import '../modules/navigation/navigation_provider.dart';
import 'atoms/conditional_widget.dart';
import 'atoms/loading_indicator.dart';

var _initialized = false;

class SuperDeckApp extends StatelessWidget {
  const SuperDeckApp({
    super.key,
    this.baseStyle,
    this.styles = const <String, DeckStyle>{},
    this.examples = const <String, ExampleBuilder>{},
  });

  final DeckStyle? baseStyle;
  final Map<String, ExampleBuilder> examples;
  final Map<String, DeckStyle> styles;

  static Future<void> initialize() async {
    // Return if its initialized
    if (_initialized) return;

    _initialized = true;

    WidgetsFlutterBinding.ensureInitialized();

    await Future.wait([
      NavigationController.initialize(),
      SyntaxHighlight.initialize(),
      _initializeWindowManager(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SuperDeckProvider(
      baseStyle: baseStyle,
      examples: examples,
      styles: styles,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Superdeck',
        routerConfig: goRouterConfig,
        theme: theme,
      ),
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

class SuperDeckProvider extends StatefulWidget {
  const SuperDeckProvider({
    super.key,
    required this.child,
    this.baseStyle,
    this.styles = const <String, DeckStyle>{},
    this.examples = const <String, ExampleBuilder>{},
  });

  final Widget child;
  final DeckStyle? baseStyle;
  final Map<String, ExampleBuilder> examples;
  final Map<String, DeckStyle> styles;

  @override
  State<SuperDeckProvider> createState() => _SuperDeckProviderState();
}

class _SuperDeckProviderState extends State<SuperDeckProvider> {
  late final DeckReferenceController _controller;
  late final NavigationController _navigation;

  @override
  void initState() {
    super.initState();
    _controller = DeckReferenceController(
      baseStyle: widget.baseStyle ?? DeckStyle(),
      examples: widget.examples,
      styles: widget.styles,
    );
    _navigation = NavigationController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _navigation.dispose();
  }

  @override
  void didUpdateWidget(covariant SuperDeckProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.baseStyle != oldWidget.baseStyle ||
        widget.examples != oldWidget.examples ||
        widget.styles != oldWidget.styles) {
      _controller.update(
        baseStyle: widget.baseStyle,
        examples: widget.examples,
        styles: widget.styles,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationProvider(
      controller: _navigation,
      child: DeckReferenceProvider(
        controller: _controller,
        child: ListenableBuilder(
            listenable: Listenable.merge([_controller, _navigation]),
            builder: (context, _) {
              return Stack(
                children: [
                  ConditionalWidget(
                    condition: _controller.hasData,
                    fallback: const SizedBox(),
                    child: widget.child,
                  ),
                  LoadingOverlay(
                    isLoading:
                        _controller.isLoading || _controller.isRefreshing,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
