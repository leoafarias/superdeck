import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_paths/go_router_paths.dart';

import '../../superdeck.dart';
import '../screens/export_screen.dart';
import '../screens/presentation_screen.dart';
import 'dialog_page.dart';

class SDPaths {
  static Path get home => Path('/');
  static ExportPath get export => ExportPath();
}

class ExportPath extends Path<ExportPath> {
  ExportPath() : super('export');

  Path get low => Path('low', parent: this);
  Path get good => Path('good', parent: this);
  Path get better => Path('better', parent: this);
  Path get best => Path('best', parent: this);
}

class QueryParams {
  static const drawer = 'drawer';
  static const slide = 'slide';
}

final kRootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

Map<String, String> _previousQueryParams = {};

final goRouterConfig = GoRouter(
  navigatorKey: kRootNavigatorKey,
  initialLocation: SDPaths.home.goRoute,
  restorationScopeId: 'root',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      redirect: (context, state) {
        // Get the previous route's state from the navigation history

        // Extract current query parameters
        final currentQueryParams = state.uri.queryParameters;

        final openDrawerParam = _previousQueryParams[QueryParams.drawer];
        final slideParam = _previousQueryParams[QueryParams.slide];

        // Add any additional query parameters if needed
        final allQueryParams = {
          if (openDrawerParam != null) QueryParams.drawer: openDrawerParam,
          if (slideParam != null) QueryParams.slide: slideParam,
          ...currentQueryParams,
        };

        _previousQueryParams = allQueryParams;

        // Construct the target URI with query parameters
        final uri = state.uri.replace(
          queryParameters: allQueryParams.isEmpty ? null : allQueryParams,
        );

        return uri.toString();
      },
      restorationScopeId: 'shell1',
      parentNavigatorKey: kRootNavigatorKey,
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: SDPaths.home.goRoute,
              pageBuilder: (context, state) => _getPage(
                PresentationScreen(),
                state,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: SDPaths.export.goRoute,
              pageBuilder: (context, state) {
                return _getPage(ExportScreen(), state);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

MaterialPage _getPage(Widget child, GoRouterState state) {
  return MaterialPage(key: state.pageKey, child: child);
}

DialogPage _getDialogPage(Widget child, GoRouterState state) {
  return DialogPage(key: state.pageKey, builder: (_) => Dialog(child: child));
}

extension BuildContextRoutesX on BuildContext {
  int get currentSlidePage => int.parse(_slidePage ?? '1');
  int get currentSlideIndex => currentSlidePage - 1;

  void goToSlide(int page) => go(_replaceQueryParam('slide', '$page'));

  String get currentPath {
    return GoRouterState.of(this).uri.toString();
  }

  void nextSlide() => goToSlide(currentSlidePage + 1);

  void previousSlide() => goToSlide(currentSlidePage - 1);

  String _replaceQueryParam(String key, String value) {
    final uri = GoRouterState.of(this).uri;
    final queryParameters = Map<String, String>.from(uri.queryParameters);
    queryParameters[key] = value;
    return uri.replace(queryParameters: queryParameters).toString();
  }

  void openDrawer() => go(_replaceQueryParam(QueryParams.drawer, '1'));

  void closeDrawer() => go(_replaceQueryParam(QueryParams.drawer, '0'));

  void toggleDrawer() {
    if (isDrawerOpen) {
      closeDrawer();
    } else {
      openDrawer();
    }
  }

  Map<String, String> get _queryParams {
    return GoRouterState.of(this).uri.queryParameters;
  }

  String? get _drawerParam => _queryParams[QueryParams.drawer];

  String? get _slidePage => _queryParams[QueryParams.slide];

  bool get isDrawerOpen => _drawerParam == '1';

  void goPath(Path path) {
    go(path.path);
  }

  void pushPath(Path path) {
    push(path.path);
  }
}
