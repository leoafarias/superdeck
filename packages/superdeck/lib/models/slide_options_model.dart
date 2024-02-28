import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'slide_options_model.mapper.dart';

@MappableEnum()
enum ImageFit {
  // cover, contain, fill, fitHeight, fitWidth, none, scaleDown
  cover(),
  contain(),
  fill(),
  fitHeight(),
  fitWidth(),
  none(),
  scaleDown();

  const ImageFit();

  BoxFit toBoxFit() {
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

@MappableEnum()
enum ImagePosition { left, right }

@MappableEnum()
enum ContentAlignment {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight
}

@MappableEnum()
enum VerticalAlignment { top, center, bottom }

@MappableEnum()
enum HorizontalAlignment { left, center, right }
