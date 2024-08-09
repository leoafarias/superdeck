import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class SizedTransition extends StatelessWidget {
  const SizedTransition({
    super.key,
    required this.sizeFactor,
    this.child,
    this.direction = Axis.horizontal,
  });

  final double sizeFactor;
  final Axis direction;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    AlignmentDirectional alignment;
    if (direction == Axis.horizontal) {
      alignment = const AlignmentDirectional(0.0, -1.0);
    } else {
      alignment = const AlignmentDirectional(-1.0, 0.0);
    }
    return ClipRect(
      child: Align(
        alignment: alignment,
        heightFactor:
            direction == Axis.vertical ? math.max(sizeFactor, 0.0) : 1.0,
        widthFactor:
            direction == Axis.horizontal ? math.max(sizeFactor, 0.0) : 1.0,
        child: child,
      ),
    );
  }
}
