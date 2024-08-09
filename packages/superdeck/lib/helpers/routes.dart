import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_paths/go_router_paths.dart';

import '../../superdeck.dart';
import '../helpers/dialog_page.dart';
import '../screens/export_screen.dart';
import '../screens/presentation_screen.dart';

class SDPaths {
  static Path get home => Path('/');
  static ExportPath get export => ExportPath();

  static SlidesPath get slides => SlidesPath();
}

class SlidesPath extends Path<SlidesPath> {
  SlidesPath() : super('slides');

  SlidePageIndexPath get _pageIndex => SlidePageIndexPath(this);
}

class ExportPath extends Path<ExportPath> {
  ExportPath() : super('export');

  Path get low => Path('low', parent: this);
  Path get good => Path('good', parent: this);
  Path get better => Path('better', parent: this);
  Path get best => Path('best', parent: this);
}

class SlidePageIndexPath extends Param<SlidePageIndexPath> {
  SlidePageIndexPath(SlidesPath parent)
      : super.only('pageIndex', parent: parent);
}

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final goRouterConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: SDPaths.home.goRoute,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionANavigatorKey,
          routes: [
            GoRoute(
              path: SDPaths.home.goRoute,
              builder: (context, state) {
                return PresentationScreen(slideIndex: 0);
              },
            ),
            GoRoute(
              path: SDPaths.slides.goRoute,
              // Dynamic path for slides/pageNumber
              builder: (context, state) {
                return PresentationScreen();
              },
              routes: [
                GoRoute(
                  path: SDPaths.slides._pageIndex.goRoute,
                  builder: (context, state) {
                    // Extract the page number
                    final slideIndex = int.tryParse(state
                                .pathParameters[SDPaths.slides._pageIndex.id] ??
                            '0') ??
                        0;

                    return PresentationScreen(slideIndex: slideIndex);
                  },
                ),
              ],
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

extension BuildContextRoutesX on BuildContext {
  int get currentSlideIndex {
    final currentPath = GoRouterState.of(this).uri.toString();
    final slidesPath = SDPaths.slides.path;
    final match = RegExp("$slidesPath" + r'/(\d+)').firstMatch(currentPath);

    if (match == null) {
      return 0;
    }

    return int.parse(match.group(1)!);
  }

  void goToSlide(int index) {
    go(SDPaths.slides._pageIndex
        .define('$index')
        .query(_drawerQueryParam)
        .path);
  }

  void nextSlide() {
    goToSlide(currentSlideIndex + 1);
  }

  String get currentPath {
    return GoRouterState.of(this).uri.toString();
  }

  void previousSlide() {
    goToSlide(currentSlideIndex - 1);
  }

  String _replaceQueryParam(String key, String value) {
    final uri = GoRouterState.of(this).uri;
    final queryParameters = Map<String, String>.from(uri.queryParameters);
    queryParameters[key] = value;
    return uri.replace(queryParameters: queryParameters).toString();
  }

  void openDrawer() {
    go(_replaceQueryParam('drawer', 'open'));
  }

  void closeDrawer() {
    go(_replaceQueryParam('drawer', 'close'));
  }

  void toggleDrawer() {
    if (isDrawerOpen) {
      closeDrawer();
    } else {
      openDrawer();
    }
  }

  bool get isDrawerOpen {
    return GoRouterState.of(this).uri.queryParameters['drawer'] == 'open';
  }

  Map<String, String> get _drawerQueryParam {
    return {'drawer': isDrawerOpen ? 'open' : 'close'};
  }

  void goPath(Path path) {
    go(path.query(_drawerQueryParam).path);
  }

  void pushPath(Path path) {
    push(path.query(_drawerQueryParam).path);
  }
}
