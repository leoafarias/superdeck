import 'package:superdeck_core/superdeck_core.dart';
import 'package:flutter/material.dart';

class FlexAlignment {
  const FlexAlignment({
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
  });

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  factory FlexAlignment.fromContentAlignment(ContentAlignment alignment) {
    return FlexAlignment(
      mainAxisAlignment: _mainAxisFromContentAlignment(alignment),
      crossAxisAlignment: _crossAxisFromContentAlignment(alignment),
    );
  }
}

MainAxisAlignment _mainAxisFromContentAlignment(ContentAlignment alignment) {
  if (alignment.name.startsWith(VerticalAlignment.top.name)) {
    return MainAxisAlignment.start;
  }

  if (alignment.name.startsWith(VerticalAlignment.bottom.name)) {
    return MainAxisAlignment.end;
  }

  return MainAxisAlignment.center;
}

CrossAxisAlignment _crossAxisFromContentAlignment(ContentAlignment alignment) {
  // capitalize string

  if (alignment.name.toLowerCase().endsWith(HorizontalAlignment.left.name)) {
    return CrossAxisAlignment.start;
  }

  if (alignment.name.toLowerCase().endsWith(HorizontalAlignment.right.name)) {
    return CrossAxisAlignment.end;
  }

  return CrossAxisAlignment.center;
}

extension ImageFitExt on ImageFit {
  BoxFit get boxFit {
    switch (this) {
      case ImageFit.cover:
        return BoxFit.cover;
      case ImageFit.contain:
        return BoxFit.contain;
      case ImageFit.fill:
        return BoxFit.fill;
      case ImageFit.fitHeight:
        return BoxFit.fitHeight;
      case ImageFit.fitWidth:
        return BoxFit.fitWidth;
      case ImageFit.none:
        return BoxFit.none;
      case ImageFit.scaleDown:
        return BoxFit.scaleDown;
    }
  }
}
