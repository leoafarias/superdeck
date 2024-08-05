import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';
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

final kAppKey = GlobalKey();
final _uniqueKey = UniqueKey();

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

  static bool _isInitialized = false;

  static Future<void> initialize() async {
    // Return if its initialized
    if (SuperDeckApp._isInitialized) return;

    WidgetsFlutterBinding.ensureInitialized();

    await Future.wait([
      initLocalStorage(),
      SyntaxHighlight.initialize(),
      _initializeWindowManager(),
    ]);

    SuperDeckApp._isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme,
      child: FutureBuilder(
          future: SuperDeckApp.initialize(),
          builder: (context, snapshot) {
            return StyleProvider(
              baseStyle: baseStyle,
              styles: styles,
              child: ExamplesProvider(
                examples: examples,
                child: ListenableBuilder(
                    listenable: SuperDeckController.instance,
                    builder: (context, snapshot) {
                      return MixTheme(
                        data: MixThemeData.withMaterial(),
                        child: MaterialApp.router(
                          debugShowCheckedModeBanner: false,
                          title: 'Superdeck',
                          routerConfig: _router,
                          theme: Theme.of(context),
                          key: kAppKey,
                          builder: (context, child) {
                            return LoadingOverlay(
                              isLoading: SuperDeckController.instance.loading,
                              key: _uniqueKey,
                              child: child!,
                            );
                          },
                        ),
                      );
                    }),
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
