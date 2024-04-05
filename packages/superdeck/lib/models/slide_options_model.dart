import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'slide_options_model.mapper.dart';

@MappableClass()
class ImageOptions with ImageOptionsMappable {
  final String src;
  final ImageFit? fit;
  final LayoutPosition position;
  final int flex;

  const ImageOptions({
    required this.src,
    this.fit,
    this.flex = 1,
    this.position = LayoutPosition.left,
  });

  static const fromMap = ImageOptionsMapper.fromMap;
  static const fromJson = ImageOptionsMapper.fromJson;
}

@MappableEnum()
enum TransitionType {
  // FadeIn Animations
  fadeIn,
  fadeInDown,
  fadeInDownBig,
  fadeInUp,
  fadeInUpBig,
  fadeInLeft,
  fadeInLeftBig,
  fadeInRight,
  fadeInRightBig,

  // FadeOut Animations
  fadeOut,
  fadeOutDown,
  fadeOutDownBig,
  fadeOutUp,
  fadeOutUpBig,
  fadeOutLeft,
  fadeOutLeftBig,
  fadeOutRight,
  fadeOutRightBig,

  // BounceIn Animations
  bounceInDown,
  bounceInUp,
  bounceInLeft,
  bounceInRight,

  // ElasticIn Animations
  elasticIn,
  elasticInDown,
  elasticInUp,
  elasticInLeft,
  elasticInRight,

  // SlideIns Animations
  slideInDown,
  slideInUp,
  slideInLeft,
  slideInRight,

  // FlipIn Animations
  flipInX,
  flipInY,

  // Zooms
  zoomIn,
  zoomOut,

  // SpecialIn Animations
  jelloIn,

  // Attention Seeker
  bounce,
  dance,
  flash,
  pulse,
  roulette,
  shakeX,
  shakeY,
  spin,
  spinPerfect,
  swing,
}

@MappableEnum()
enum CurveType {
  ease,
  bounceIn,
  bounceOut,
  easeIn,
  easeInOut,
  easeOut,
  elasticIn,
  elasticInOut,
  elasticOut,
  fastLinearToSlowEaseIn,
  fastOutSlowIn,
  linear,
  decelerate,
  slowMiddle,
  linearToEaseOut,
}

@MappableClass(
    hook: SingleOptionHook(fieldName: 'type'),
    includeCustomMappers: [DurationMapper()])
class TransitionOptions with TransitionOptionsMappable {
  final TransitionType type;
  final Duration? duration;
  final Duration? delay;
  final CurveType? curve;

  const TransitionOptions({
    required this.type,
    this.duration,
    this.delay,
    this.curve,
  });

  static const fromMap = TransitionOptionsMapper.fromMap;

  static const fromJson = TransitionOptionsMapper.fromJson;
}

class DurationMapper extends SimpleMapper<Duration> {
  const DurationMapper();

  @override
  Duration decode(Object value) {
    return Duration(milliseconds: value as int);
  }

  @override
  int encode(Duration self) {
    return self.inMilliseconds;
  }
}

class SingleOptionHook extends MappingHook {
  const SingleOptionHook({required this.fieldName});

  final String fieldName;

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      return {fieldName: value};
    }
    return value;
  }
}

@MappableClass()
class WidgetOptions with WidgetOptionsMappable {
  final String name;
  final Map<String, dynamic> args;
  final LayoutPosition position;
  final int flex;

  const WidgetOptions({
    required this.name,
    this.args = const {},
    this.flex = 1,
    this.position = LayoutPosition.left,
  });

  static const fromMap = WidgetOptionsMapper.fromMap;
  static const fromJson = WidgetOptionsMapper.fromJson;
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
enum LayoutPosition { left, right, top, bottom }

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
