import 'dart:async';
import 'dart:developer';

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
import '../services/assets_service.dart';
import 'molecules/exception_widget.dart';

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
      AssetService.initialize(),
      _initializeWindowManager(),
    ]);

    SuperDeckApp.isInitialized = true;
  }

  @override
  // ignore: library_private_types_in_public_api
  _SuperDeckAppState createState() => _SuperDeckAppState();
}

class _SuperDeckAppState extends State<SuperDeckApp> {
  final _provider = SuperDeckProvider.instance;
  late final _initializing = futureSignal(_initializeDependencies);

  @override
  void didUpdateWidget(SuperDeckApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.style != oldWidget.style ||
        widget.examples != oldWidget.examples) {
      _provider.update(
        style: widget.style,
        examples: widget.examples,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _initializing.dispose();
  }

  Future<void> _initializeDependencies() async {
    await SuperDeckApp.initialize();
    await _provider.initialize(
      style: widget.style,
      examples: widget.examples,
    );
  }

  void onRetry() {
    _provider.initialize(
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

    return MixTheme(
      data: MixThemeData.withMaterial(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Superdeck',
        theme: theme,
        routerConfig: _router,
        builder: (context, child) {
          final initializing = _initializing.watch(context);

          return initializing.map(
            data: (data) => child!,
            loading: () => Scaffold(
              body: renderLoading(),
            ),
            error: (error) {
              log(error.toString());

              return ExceptionWidget(
                error,
                onRetry: onRetry,
              );
            },
          );
        },
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
