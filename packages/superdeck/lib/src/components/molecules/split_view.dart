import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../modules/common/helpers/hooks.dart';
import '../../modules/common/helpers/routes.dart';
import '../organisms/slide_thumbnail_list.dart';
import 'bottom_bar.dart';

final kScaffoldKey = GlobalKey<ScaffoldState>();

class SplitView extends HookWidget {
  final Widget child;

  const SplitView({
    super.key,
    required this.child,
  });

  final _thumbnailWidth = 300.0;
  final _duration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final isBottomOpen = context.isPresenterMenuOpen;

    final bottomAnimation = useAnimationController(
      duration: _duration,
      initialValue: isBottomOpen ? 1.0 : 0.0,
    );

    usePostFrameEffect(() {
      if (isBottomOpen) {
        bottomAnimation.forward();
      } else {
        bottomAnimation.reverse();
      }
    }, [isBottomOpen]);

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
      bottomNavigationBar: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: bottomAnimation,
          curve: Curves.easeInOut,
        ),
        axis: Axis.vertical,
        child: const SDBottomBar(),
      ),
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
              child: const SlideThumbnailList(),
            ),
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
