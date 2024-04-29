import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';
import 'package:signals/signals_flutter.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/syntax_highlighter.dart';
import '../../superdeck.dart';
import '../helpers/constants.dart';
import '../helpers/theme.dart';
import '../screens/export_screen.dart';
import '../screens/home_screen.dart';
import 'molecules/exception_widget.dart';

final kAppKey = GlobalKey();

class SuperDeckApp extends StatefulWidget {
  const SuperDeckApp({
    super.key,
    this.style,
    this.examples = const [],
  });

  final Style? style;
  final List<Example> examples;

  static bool isInitialized = false;

  static Future<void> initialize() async {
    // Return if its initialized
    if (SuperDeckApp.isInitialized) return;

    WidgetsFlutterBinding.ensureInitialized();

    SignalsObserver.instance = null;

    await Future.wait([
      initLocalStorage(),
      SyntaxHighlight.initialize(),
      _initializeWindowManager(),
    ]);

    SuperDeckApp.isInitialized = true;
  }

  @override
  // ignore: library_private_types_in_public_api
  _SuperDeckAppState createState() => _SuperDeckAppState();
}

class _SuperDeckAppState extends State<SuperDeckApp> {
  final _controller = SuperDeckController.instance;
  late final _isReady = createSignal(context, false);

  @override
  void initState() {
    super.initState();
    _initializeDependencies();
  }

  @override
  void didUpdateWidget(SuperDeckApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.style != oldWidget.style ||
        widget.examples != oldWidget.examples) {
      _controller.update(
        style: widget.style,
        examples: widget.examples,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initializeDependencies() async {
    await SuperDeckApp.initialize();
    await _controller.initialize(
      style: widget.style,
      examples: widget.examples,
    );

    _isReady.value = true;
  }

  void onRetry() {
    _controller.initialize(
      style: widget.style,
      examples: widget.examples,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget renderLoading() {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return MediaQuery(
      data: const MediaQueryData(
        size: kResolution,
      ),
      child: Theme(
        data: theme,
        child: Builder(builder: (context) {
          return MixTheme(
            data: MixThemeData.withMaterial(),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Superdeck',
              routerConfig: _router,
              theme: Theme.of(context),
              key: kAppKey,
              builder: (context, child) {
                final isLoading = _controller.loading.watch(context) ||
                    !_isReady.watch(context);
                if (isLoading) {
                  return renderLoading();
                }

                if (_controller.error.watch(context) != null) {
                  return ExceptionWidget(
                    _controller.error.watch(context)!,
                    onRetry: onRetry,
                  );
                }

                return child!;
              },
            ),
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

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        // Return the widget that implements the custom shell (in this case
        // using a BottomNavigationBar). The StatefulNavigationShell is passed
        // to be able access the state of the shell and to navigate to other
        // branches in a stateful way.
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // The route branch for the first tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: _sectionANavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/export',
              builder: (BuildContext context, GoRouterState state) {
                return const ExportScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
