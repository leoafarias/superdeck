import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'slide_options_model.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.paramCase)
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

@MappableEnum(caseStyle: CaseStyle.paramCase)
enum ImagePosition { left, right }

@MappableEnum(caseStyle: CaseStyle.paramCase)
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

@MappableEnum(caseStyle: CaseStyle.paramCase)
enum VerticalAlignment { top, center, bottom }

@MappableEnum(caseStyle: CaseStyle.paramCase)
enum HorizontalAlignment { left, center, right }
