import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../helpers/hooks.dart';
import '../../helpers/utils.dart';
import '../../superdeck.dart';
import '../atoms/sized_transition.dart';
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

  final _maxWidth = 450.0;
  final _minWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    final navigation = useNavigation();
    final sideSize = useState(context.isMobileLandscape ? 200.0 : _maxWidth);
    final isDragging = useState(false);

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

    final handleUpdateSize = useCallback((DragUpdateDetails details) {
      sideSize.value =
          (sideSize.value + details.delta.dx).clamp(_minWidth, _maxWidth);
    }, [sideSize.value]);

    const sideHeight = 200.0;

    final isSmall = context.isSmall || context.isMobileLandscape;

    final sidePanel = SlideThumbnailList(
      key: ValueKey(isSmall ? Axis.horizontal : Axis.vertical),
      scrollDirection: isSmall ? Axis.horizontal : Axis.vertical,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final animatedWidth = animation * sideSize.value;
        final animatedHeight = animation * sideHeight;

        EdgeInsets padding;
        if (isSmall) {
          padding = EdgeInsets.only(bottom: animatedHeight);
        } else {
          padding = EdgeInsets.only(left: animatedWidth);
        }

        final divider = MouseRegion(
          cursor: SystemMouseCursors.resizeColumn,
          child: GestureDetector(
            onHorizontalDragUpdate: handleUpdateSize,
            onHorizontalDragStart: (_) {
              isDragging.value = true;
            },
            onHorizontalDragEnd: (_) {
              isDragging.value = false;
            },
            child: Container(
              color: Colors.black,
              width: 8,
            ),
          ),
        );

        final drawer = Align(
          alignment: isSmall ? Alignment.bottomCenter : Alignment.centerLeft,
          child: SizedTransition(
            sizeFactor: animation,
            child: SizedBox(
              width: isSmall ? null : sideSize.value,
              height: isSmall ? sideHeight : null,
              child: Row(
                children: [
                  Expanded(child: isDragging.value ? Container() : sidePanel),
                  divider,
                ],
              ),
            ),
          ),
        );

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
