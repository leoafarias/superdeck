import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_paths/go_router_paths.dart';

import '../../../../../superdeck.dart';
import '../../../screens/export_screen.dart';
import '../../../screens/presentation_screen.dart';

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
        return AppShell(child: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: SDPaths.root.goRoute,
              pageBuilder: (context, state) => _getPage(
                PresentationScreen(key: state.pageKey),
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
                const PresentationScreen(),
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
                return _getPage(const ExportScreen(), state);
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
