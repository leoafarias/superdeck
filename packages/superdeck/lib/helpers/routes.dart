import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_paths/go_router_paths.dart';

import '../../superdeck.dart';
import '../screens/export_screen.dart';
import '../screens/presentation_screen.dart';
import 'dialog_page.dart';

class SDPaths {
  static Path get root => Path('/');
  static ExportPath get export => ExportPath();
  static ChatPath get chat => ChatPath();
}

class ExportPath extends Path<ExportPath> {
  ExportPath() : super('export');
}

class ChatPath extends Path<ChatPath> {
  ChatPath() : super('chat');
}

class QueryParams {
  static const drawer = 'drawer';
  static const slide = 'slide';
  static const presenterMenu = 'isPresenter';
}

final kRootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

Map<String, String> _previousQueryParams = {};

final goRouterConfig = GoRouter(
  navigatorKey: kRootNavigatorKey,
  initialLocation: SDPaths.root.goRoute,
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
              path: SDPaths.root.goRoute,
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
              path: SDPaths.chat.goRoute,
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
  return MaterialPage(key: state.pageKey, child: child, maintainState: false);
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

  bool get isPresenterMenuOpen => _presenterMenuParam == '1';

  void openPresenterMenu() =>
      go(_replaceQueryParam(QueryParams.presenterMenu, '1'));

  void closePresenterMenu() =>
      go(_replaceQueryParam(QueryParams.presenterMenu, '0'));

  void togglePresenterMenu() {
    if (isPresenterMenuOpen) {
      closePresenterMenu();
    } else {
      openPresenterMenu();
    }
  }

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

  // listen to the drawer query parameter

  String? get _drawerParam => _queryParams[QueryParams.drawer];

  String? get _presenterMenuParam => _queryParams[QueryParams.presenterMenu];

  String? get _slidePage => _queryParams[QueryParams.slide];

  bool get isDrawerOpen => _drawerParam == '1';

  void goPath(Path path) {
    go(path.path);
  }

  void pushPath(Path path) {
    push(path.path);
  }
}
