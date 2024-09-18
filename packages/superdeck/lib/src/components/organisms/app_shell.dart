import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../modules/common/helpers/constants.dart';
import '../../modules/common/helpers/extensions.dart';
import '../../modules/common/helpers/hooks.dart';
import '../../modules/deck/slide_provider.dart';
import '../../modules/navigation/navigation_hooks.dart';
import '../molecules/block_widget.dart';
import '../molecules/bottom_bar.dart';
import '../molecules/scaled_app.dart';
import 'note_panel.dart';
import 'thumbnail_panel.dart';

final kScaffoldKey = GlobalKey<ScaffoldState>();

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class AppShell extends HookWidget {
  const AppShell({
    required this.child,
    super.key = const ValueKey<String>('app_shell'),
  });

  /// The navigation shell and container for the branch Navigators.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final actions = useNavigationActions();

    final bindings = {
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
        meta: true,
      ): actions.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
        meta: true,
      ): actions.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.space,
        meta: true,
      ): actions.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
        meta: true,
      ): actions.previousSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
        meta: true,
      ): actions.previousSlide,
    };

    return CallbackShortcuts(
      bindings: bindings,
      child: SplitView(
        child: child,
      ),
    );
  }
}

class SplitView extends HookWidget {
  final Widget child;

  const SplitView({
    super.key,
    required this.child,
  });

  int _getCurrentSlideIndex(BuildContext context) {
    final goRouter = GoRouter.of(context);
    final uri = goRouter.routeInformationProvider.value.uri;

    if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'slides') {
      final slideIdStr = uri.pathSegments[1];
      final slideIndex = int.tryParse(slideIdStr);
      if (slideIndex != null) {
        return slideIndex;
      }
    }

    return 0;
  }

  final _thumbnailWidth = 300.0;
  final _duration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final isPresenterMenuOpen = useIsPresenterMenuOpen();
    final navigationActions = useNavigationActions();
    final navigatonState = useNavigationState();

    final bottomAnimation = useAnimationController(
      duration: _duration,
      initialValue: isPresenterMenuOpen ? 1.0 : 0.0,
    );

    usePostFrameEffect(() {
      if (isPresenterMenuOpen) {
        bottomAnimation.forward();
      } else {
        bottomAnimation.reverse();
      }
    }, [isPresenterMenuOpen]);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 9, 9),
      key: kScaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: !isPresenterMenuOpen
          ? IconButton(
              onPressed: navigationActions.openPresenterMenu,
              icon: const Icon(Icons.menu),
            )
          : null,
      body: Row(
        children: [
          SizeTransition(
            axis: Axis.horizontal,
            sizeFactor: CurvedAnimation(
              parent: bottomAnimation,
              curve: Curves.easeInOut,
            ),
            child: SizedBox(
              width: _thumbnailWidth,
              child: const Column(
                children: [
                  Expanded(flex: 3, child: ThumbnailPanel()),
                  Expanded(
                    flex: 1,
                    child: NotePanel(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Scaffold(
              bottomNavigationBar: SizeTransition(
                sizeFactor: CurvedAnimation(
                  parent: bottomAnimation,
                  curve: Curves.easeInOut,
                ),
                axis: Axis.vertical,
                child: const SDBottomBar(),
              ),
              body: Center(
                child: SlideConfigurationBuilder(
                    controller: context.deck,
                    slideIndex: _getCurrentSlideIndex(context),
                    builder: (context, _) {
                      return BlockProvider(
                        data: const BlockConfiguration(size: kResolution),
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: context.deck.buildBackground()),
                            ScaledWidget(child: child),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
