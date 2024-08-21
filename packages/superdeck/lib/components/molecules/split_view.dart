import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hooks.dart';
import '../../helpers/routes.dart';
import '../organisms/slide_thumbnail_list.dart';
import 'floating_bottom_bar.dart';

final kScaffoldKey = GlobalKey<ScaffoldState>();

class SplitView extends HookWidget {
  final StatefulNavigationShell navigationShell;

  const SplitView({
    super.key,
    required this.navigationShell,
  });

  final _thumbnailWidth = 300.0;
  final _duration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final isBottomOpen = context.isPresenterMenuOpen;
    final isSideOpen = context.isDrawerOpen;
    final sideAnimation = useAnimationController(
      duration: _duration,
      initialValue: isSideOpen && isBottomOpen ? 1.0 : 0.0,
    );
    final bottomAnimation = useAnimationController(
      duration: _duration,
      initialValue: isBottomOpen ? 1.0 : 0.0,
    );

    usePostFrameEffect(() {
      if (isBottomOpen) {
        bottomAnimation.forward();
        if (isSideOpen) {
          sideAnimation.forward();
        } else {
          sideAnimation.reverse();
        }
      } else {
        sideAnimation.reverse();
        bottomAnimation.reverse();
      }
    }, [isBottomOpen, isSideOpen]);

    // usePostFrameEffect(() {
    //   if (isSideOpen) {
    //     sideAnimation.forward();
    //   } else {
    //     sideAnimation.reverse();
    //   }
    // }, [isSideOpen]);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 9, 9),
      key: kScaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: !context.isPresenterMenuOpen
          ? FloatingActionButton(
              onPressed: () => context.togglePresenterMenu(),
              child: const Icon(Icons.arrow_forward),
            )
          : null,
      body: Stack(
        children: [
          Row(
            children: [
              SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: CurvedAnimation(
                  parent: sideAnimation,
                  curve: Curves.easeInOut,
                ),
                child: SizedBox(
                  width: _thumbnailWidth,
                  child: const SlideThumbnailList(),
                ),
              ),
              Expanded(child: navigationShell)
            ],
          ),
          AnimatedPositioned(
            duration: Durations.short2,
            bottom: isBottomOpen ? 0 : -FloatingBottomBar.height,
            child: FloatingBottomBar(
              isVisible: true,
            ),
          ),
        ],
      ),
    );
  }
}
