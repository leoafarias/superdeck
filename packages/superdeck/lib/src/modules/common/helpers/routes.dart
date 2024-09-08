import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_paths/go_router_paths.dart';

import '../../../../../superdeck.dart';
import '../../../screens/export_screen.dart';
import '../../../screens/presentation_screen.dart';

class SDPaths {
  static Path get root => Path('/');
  static ExportPath get export => ExportPath();
  // static Param<Param> get slides => Param('slides', 'slideId');
  static SlidesPath get slides => SlidesPath();

  static ChatPath get chat => ChatPath();
}

class ExportPath extends Path<ExportPath> {
  ExportPath() : super('export');
}

class SlidesPath extends Path<SlidesPath> {
  SlidesPath() : super('slides');
  SlidePath get slide => SlidePath(this);
}

class SlidePath extends Param<SlidePath> {
  SlidePath(SlidesPath slidesPath) : super.only('slideId', parent: slidesPath);
}

class ChatPath extends Path<ChatPath> {
  ChatPath() : super('chat');
}

final kRootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final goRouterConfig = GoRouter(
  navigatorKey: kRootNavigatorKey,
  initialLocation: SDPaths.slides.goRoute,
  restorationScopeId: 'root',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      restorationScopeId: 'shell1',
      parentNavigatorKey: kRootNavigatorKey,
      builder: (context, state, navigationShell) {
        return AppShell(child: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: SDPaths.slides.goRoute,
                pageBuilder: (context, state) => _getPage(
                      const SlideScreen(
                        slideIndex: 0,
                      ),
                      state,
                    ),
                routes: [
                  GoRoute(
                    path: SDPaths.slides.slide.goRoute,
                    pageBuilder: (context, state) {
                      final index = int.parse(
                        state.pathParameters[SDPaths.slides.slide.id] ?? '0',
                      );
                      return _getPage(
                        SlideScreen(slideIndex: index),
                        state,
                      );
                    },
                  ),
                ]),
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

CupertinoPage _getPage(Widget child, GoRouterState state) {
  return CupertinoPage(
      key: state.pageKey, child: child, maintainState: true, canPop: false);
}

CustomTransitionPage<void> _getCupertinoTransition(
  Widget child,
  GoRouterState state,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    maintainState: true,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Use CurpertinoPageTransition
      // but change the animation
      return CupertinoPageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: true,
        child: child,
      );
    },
  );
}
