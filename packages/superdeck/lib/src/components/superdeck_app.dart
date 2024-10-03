import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../../superdeck.dart';
import '../modules/common/helpers/constants.dart';
import '../modules/common/helpers/routes.dart';
import '../modules/common/helpers/syntax_highlighter.dart';
import '../modules/common/helpers/theme.dart';
import '../modules/navigation/navigation_controller.dart';
import 'atoms/conditional_widget.dart';
import 'atoms/loading_indicator.dart';

var _initialized = false;

class SuperDeckApp extends StatelessWidget {
  const SuperDeckApp({
    super.key,
    this.baseStyle,
    this.styles = const <String, DeckStyle>{},
    this.widgets = const <String, WidgetBuilderWithOptions>{},
    this.header,
    this.footer,
    this.background,
  });

  final DeckStyle? baseStyle;
  final Map<String, WidgetBuilderWithOptions> widgets;
  final Map<String, DeckStyle> styles;
  final FixedSlidePart? header;
  final FixedSlidePart? footer;
  final SlidePart? background;

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
      widgets: widgets,
      styles: styles,
      background: background,
      header: header,
      footer: footer,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Superdeck',
        routerConfig: goRouterConfig,
        theme: theme,
      ),
    );
  }
}

class SuperDeckProvider extends StatefulWidget {
  const SuperDeckProvider({
    super.key,
    required this.child,
    this.baseStyle,
    this.styles = const <String, DeckStyle>{},
    this.widgets = const <String, WidgetBuilderWithOptions>{},
    this.header,
    this.footer,
    this.background,
  });

  final Widget child;
  final DeckStyle? baseStyle;
  final Map<String, WidgetBuilderWithOptions> widgets;
  final Map<String, DeckStyle> styles;
  final FixedSlidePart? header;
  final FixedSlidePart? footer;
  final SlidePart? background;

  @override
  State<SuperDeckProvider> createState() => _SuperDeckProviderState();
}

class _SuperDeckProviderState extends State<SuperDeckProvider> {
  late final DeckController _controller;
  late final NavigationController _navigation;

  @override
  void initState() {
    super.initState();
    _controller = DeckController(
      baseStyle: widget.baseStyle ?? DeckStyle(),
      widgets: widget.widgets,
      background: widget.background,
      styles: widget.styles,
      header: widget.header,
      footer: widget.footer,
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
        widget.widgets != oldWidget.widgets ||
        widget.styles != oldWidget.styles ||
        widget.header != oldWidget.header ||
        widget.footer != oldWidget.footer) {
      _controller.update(
        baseStyle: widget.baseStyle,
        examples: widget.widgets,
        styles: widget.styles,
        header: widget.header,
        footer: widget.footer,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ControllerProvider(
      controller: _navigation,
      child: ControllerProvider(
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

Future<void> _initializeWindowManager() async {
  if (kIsWeb) return;

  // Must add this line.
  await windowManager.ensureInitialized();

  final titleBarHeight = await windowManager.getTitleBarHeight();

  final newSize = Size(kResolution.width, kResolution.height + titleBarHeight);

  final windowOptions = WindowOptions(
    size: newSize,
    backgroundColor: Colors.black,
    skipTaskbar: false,
    minimumSize: newSize,
    windowButtonVisibility: true,
    title: 'Superdeck',
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await windowManager.setAspectRatio(kAspectRatio);
}
