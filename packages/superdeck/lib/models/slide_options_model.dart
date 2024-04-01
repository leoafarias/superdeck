import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'slide_options_model.mapper.dart';

@MappableClass()
class ImageOptions with ImageOptionsMappable {
  final String src;
  final ImageFit fit;
  final ImagePosition position;

  const ImageOptions({
    required this.src,
    this.fit = ImageFit.cover,
    this.position = ImagePosition.left,
  });

  static const fromMap = ImageOptionsMapper.fromMap;
  static const fromJson = ImageOptionsMapper.fromJson;
}

@MappableEnum()
enum ImageFit {
  fill,
  contain,
  cover,
  fitWidth,
  fitHeight,
  none,
  scaleDown;

  const ImageFit();

  BoxFit toBoxFit() {
    return switch (this) {
      ImageFit.fill => BoxFit.fill,
      ImageFit.contain => BoxFit.contain,
      ImageFit.cover => BoxFit.cover,
      ImageFit.fitWidth => BoxFit.fitWidth,
      ImageFit.fitHeight => BoxFit.fitHeight,
      ImageFit.none => BoxFit.none,
      ImageFit.scaleDown => BoxFit.scaleDown,
    };
  }
}

@MappableEnum()
enum ImagePosition { left, right, top, bottom }

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
  bottomRight;

  const ContentAlignment();

  CrossAxisAlignment toCrossAxisAlignment() {
    switch (this) {
      // If the alignment is left align start
      case ContentAlignment.topLeft:
      case ContentAlignment.centerLeft:
      case ContentAlignment.bottomLeft:
        return CrossAxisAlignment.start;

      // If the alignment is right align end
      case ContentAlignment.topRight:
      case ContentAlignment.centerRight:
      case ContentAlignment.bottomRight:
        return CrossAxisAlignment.end;
      // If the alignment is center align center
      default:
        return CrossAxisAlignment.center;
    }
  }

  MainAxisAlignment toMainAxisAlignment() {
    switch (this) {
      // If the alignment is top align start
      case ContentAlignment.topLeft:
      case ContentAlignment.topCenter:
      case ContentAlignment.topRight:
        return MainAxisAlignment.start;

      // If the alignment is bottom align end
      case ContentAlignment.bottomLeft:
      case ContentAlignment.bottomCenter:
      case ContentAlignment.bottomRight:
        return MainAxisAlignment.end;

      // If the alignment is center align center
      default:
        return MainAxisAlignment.center;
    }
  }
}
