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
import '../providers/examples_provider.dart';
import '../providers/style_provider.dart';
import '../screens/export_screen.dart';
import '../screens/home_screen.dart';
import 'atoms/loading_indicator.dart';
import 'molecules/exception_widget.dart';

final kAppKey = GlobalKey();
final _uniqueKey = UniqueKey();

class SuperDeckApp extends StatefulWidget {
  const SuperDeckApp({
    super.key,
    this.style = const Style.empty(),
    this.examples = const <String, ExampleBuilder>{},
  });

  final Style style;
  final Map<String, ExampleBuilder> examples;

  static bool _isInitialized = false;

  static Future<void> initialize() async {
    // Return if its initialized
    if (SuperDeckApp._isInitialized) return;

    WidgetsFlutterBinding.ensureInitialized();

    SignalsObserver.instance = null;

    await Future.wait([
      initLocalStorage(),
      SyntaxHighlight.initialize(),
      _initializeWindowManager(),
    ]);

    SuperDeckApp._isInitialized = true;
  }

  @override
  // ignore: library_private_types_in_public_api
  _SuperDeckAppState createState() => _SuperDeckAppState();
}

class _SuperDeckAppState extends State<SuperDeckApp> {
  late final _initialize = futureSignal(() async {
    await SuperDeckApp.initialize();
  });

  @override
  void didUpdateWidget(SuperDeckApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.style != oldWidget.style ||
        !mapEquals(
          widget.examples,
          oldWidget.examples,
        )) {
      _initialize.refresh();
    }
  }

  @override
  void dispose() {
    _initialize.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme,
      child: Builder(builder: (context) {
        return StyleProvider(
          style: widget.style,
          child: ExamplesProvider(
            examples: widget.examples,
            child: MixTheme(
              data: MixThemeData.withMaterial(),
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Superdeck',
                routerConfig: _router,
                theme: Theme.of(context),
                key: kAppKey,
                builder: (context, child) {
                  final result = _initialize.watch(context);

                  return LoadingOverlay(
                    isLoading: result.isLoading,
                    key: _uniqueKey,
                    child: result.map(
                      data: (_) => child!,
                      loading: () => const SizedBox(),
                      error: (error, _) {
                        return ExceptionWidget(
                          error,
                          onRetry: _initialize.reload,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
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
