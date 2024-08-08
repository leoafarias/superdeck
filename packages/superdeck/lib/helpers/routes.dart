import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_paths/go_router_paths.dart';

import '../../superdeck.dart';
import '../helpers/dialog_page.dart';
import '../screens/export_screen.dart';
import '../screens/presentation_screen.dart';

class SDPaths {
  static Path get presentation => Path('/');
  static ExportPath get export => ExportPath();

  static Param<Param> get slides => Param('slides', 'page');
}

class ExportPath extends Path<ExportPath> {
  ExportPath() : super('export');

  Path get low => Path('low', parent: this);
  Path get good => Path('good', parent: this);
  Path get better => Path('better', parent: this);
  Path get best => Path('best', parent: this);
}

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final goRouterConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        // The route branch for the first tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: _sectionANavigatorKey,
          routes: [
            GoRoute(
              path: SDPaths.presentation.goRoute,
              builder: (context, state) => const PresentationScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: SDPaths.export.goRoute,
              pageBuilder: (context, state) {
                return DialogPage(
                  builder: (_) => Dialog(
                    child: ExportScreen(),
                  ),
                  barrierColor: Colors.black54, // Optional, as it's the default
                  barrierDismissible: true, // Optional, as it's the default
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
