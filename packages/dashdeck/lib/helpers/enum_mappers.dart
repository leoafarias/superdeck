import 'package:dashdeck_core/dashdeck_core.dart';
import 'package:flutter/material.dart';

class ContentAlignmentData {
  const ContentAlignmentData({
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
  });

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  factory ContentAlignmentData.fromContentAlignment(
      ContentAlignment alignment) {
    return ContentAlignmentData(
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
  if (alignment.name.toLowerCase().endsWith(HorizontalAlignment.left.name)) {
    return CrossAxisAlignment.start;
  }

  if (alignment.name.toLowerCase().endsWith(HorizontalAlignment.right.name)) {
    return CrossAxisAlignment.end;
  }

  return CrossAxisAlignment.center;
}

BoxFit mapImageToBoxFit(ImageFit fit) {
  switch (fit) {
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