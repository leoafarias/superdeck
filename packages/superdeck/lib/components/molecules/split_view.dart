import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../helpers/hooks.dart';
import '../../helpers/utils.dart';
import '../../superdeck.dart';
import 'slide_thumbnail_list.dart';

// ignore: non_constant_identifier_names
final SlidePreviewBox = Style(
  $box.color.grey.shade900(),
  $box.margin.all(8),
  $box.maxHeight(140),
  $box.shadow(
    color: Colors.black.withOpacity(0.5),
    blurRadius: 4,
    spreadRadius: 1,
  ),
).box;

class SplitView extends HookWidget {
  final Widget child;

  const SplitView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final navigation = useNavigation();

    final animationController = useAnimationController(
      duration: Durations.medium1,
    );

    final animation = useAnimation(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));

    usePostFrameEffect(() {
      if (navigation.sideIsOpen) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }, [navigation.sideIsOpen]);

    final sideWidth = context.isMobileLandscape ? 200.0 : 400.0;
    const sideHeight = 200.0;

    final isSmall = context.isSmall || context.isMobileLandscape;

    final sidePanel = SlideThumbnailList(
      scrollDirection: isSmall ? Axis.horizontal : Axis.vertical,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final animatedWidth = animation * sideWidth;
        final animatedHeight = animation * sideHeight;

        Offset offset;
        EdgeInsets padding;
        if (isSmall) {
          offset = Offset(0, -(animatedHeight - sideHeight));
          padding = EdgeInsets.only(bottom: animatedHeight);
        } else {
          offset = Offset(animatedWidth - sideWidth, 0);
          padding = EdgeInsets.only(left: animatedWidth);
        }

        Widget drawer = Transform.translate(
          offset: offset,
          child: SizedBox(
            width: isSmall ? null : sideWidth,
            height: isSmall ? sideHeight : null,
            child: sidePanel,
          ),
        );

        // Align at the bottom if its a small screen
        if (isSmall) {
          drawer = Align(
            alignment: Alignment.bottomCenter,
            child: drawer,
          );
        }

        final current = Padding(
          padding: padding,
          child: Padding(
            padding: EdgeInsets.all(20 * animation),
            child: child,
          ),
        );

        return Stack(
          children: [current, drawer],
        );
      },
    );
  }
}
