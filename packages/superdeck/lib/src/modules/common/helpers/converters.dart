import 'package:flutter/widgets.dart';
import 'package:superdeck_core/superdeck_core.dart';

class ConverterHelper {
  static BoxFit toBoxFit(ImageFit fit) {
    return switch (fit) {
      ImageFit.fill => BoxFit.fill,
      ImageFit.contain => BoxFit.contain,
      ImageFit.cover => BoxFit.cover,
      ImageFit.fitWidth => BoxFit.fitWidth,
      ImageFit.fitHeight => BoxFit.fitHeight,
      ImageFit.none => BoxFit.none,
      ImageFit.scaleDown => BoxFit.scaleDown,
    };
  }

  static Alignment toAlignment(ContentAlignment? alignment) {
    if (alignment == null) {
      return Alignment.center;
    }
    return switch (alignment) {
      ContentAlignment.topLeft => Alignment.topLeft,
      ContentAlignment.topCenter => Alignment.topCenter,
      ContentAlignment.topRight => Alignment.topRight,
      ContentAlignment.centerLeft => Alignment.centerLeft,
      ContentAlignment.center => Alignment.center,
      ContentAlignment.centerRight => Alignment.centerRight,
      ContentAlignment.bottomLeft => Alignment.bottomLeft,
      ContentAlignment.bottomCenter => Alignment.bottomCenter,
      ContentAlignment.bottomRight => Alignment.bottomRight,
    };
  }

  static (MainAxisAlignment mainAxis, CrossAxisAlignment crossAxis)
      toFlexAlignment(Axis axis, ContentAlignment alignment) {
    final isHorizontal = axis == Axis.horizontal;
    final (mainStart, mainCenter, mainEnd) = isHorizontal
        ? (
            MainAxisAlignment.start,
            MainAxisAlignment.center,
            MainAxisAlignment.end
          )
        : (
            MainAxisAlignment.end,
            MainAxisAlignment.center,
            MainAxisAlignment.start
          );

    final (crossStart, crossCenter, crossEnd) = (
      CrossAxisAlignment.start,
      CrossAxisAlignment.center,
      CrossAxisAlignment.end
    );

    return switch (alignment) {
      ContentAlignment.topLeft => (mainStart, crossStart),
      ContentAlignment.topCenter => (mainStart, crossCenter),
      ContentAlignment.topRight => (mainStart, crossEnd),
      ContentAlignment.centerLeft => (mainCenter, crossStart),
      ContentAlignment.center => (mainCenter, crossCenter),
      ContentAlignment.centerRight => (mainCenter, crossEnd),
      ContentAlignment.bottomLeft => (mainEnd, crossStart),
      ContentAlignment.bottomCenter => (mainEnd, crossCenter),
      ContentAlignment.bottomRight => (mainEnd, crossEnd),
    };
  }

  static (MainAxisAlignment mainAxis, CrossAxisAlignment crossAxis)
      toRowAlignment(ContentAlignment alignment) {
    return switch (alignment) {
      ContentAlignment.topLeft => (
          MainAxisAlignment.start,
          CrossAxisAlignment.start
        ),
      ContentAlignment.topCenter => (
          MainAxisAlignment.start,
          CrossAxisAlignment.center
        ),
      ContentAlignment.topRight => (
          MainAxisAlignment.start,
          CrossAxisAlignment.end
        ),
      ContentAlignment.centerLeft => (
          MainAxisAlignment.center,
          CrossAxisAlignment.start
        ),
      ContentAlignment.center => (
          MainAxisAlignment.center,
          CrossAxisAlignment.center
        ),
      ContentAlignment.centerRight => (
          MainAxisAlignment.center,
          CrossAxisAlignment.end
        ),
      ContentAlignment.bottomLeft => (
          MainAxisAlignment.end,
          CrossAxisAlignment.start
        ),
      ContentAlignment.bottomCenter => (
          MainAxisAlignment.end,
          CrossAxisAlignment.center
        ),
      ContentAlignment.bottomRight => (
          MainAxisAlignment.end,
          CrossAxisAlignment.end
        ),
    };
  }
}
