import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../helpers/layout_builder.dart';
import '../helpers/mappers.dart';
import '../schema/schema_model.dart';
import '../schema/schema_values.dart';
import 'slide_model.dart';

part 'options_model.mapper.dart';

@MappableClass()
class ContentOptions with ContentOptionsMappable {
  final ContentAlignment alignment;
  final int flex;

  const ContentOptions({
    this.flex = 1,
    this.alignment = ContentAlignment.centerLeft,
  });

  ContentOptions merge(ContentOptions? other) {
    if (other == null) return this;
    return copyWith.$merge(other);
  }

  static final schema = Schema(
    {
      "alignment": ContentAlignment.schema.isOptional(),
      "flex": Schema.integer.isOptional(),
    },
  );
}

@MappableClass()
abstract class SplitOptions with SplitOptionsMappable {
  final int flex;
  final LayoutPosition position;

  const SplitOptions({
    this.flex = 1,
    this.position = LayoutPosition.right,
  });

  static final schema = Schema(
    {
      "flex": Schema.integer.isOptional(),
      "position": LayoutPosition.schema.isOptional(),
    },
  );
}

@MappableClass()
class ImageOptions extends SplitOptions with ImageOptionsMappable {
  final String src;
  final ImageFit? fit;

  const ImageOptions({
    required this.src,
    this.fit,
    super.flex,
    super.position,
  });

  static final schema = SplitOptions.schema.merge(
    {
      "fit": ImageFit.schema.isOptional(),
      "src": Schema.string.isRequired(),
    },
  );
}

@MappableClass()
class WidgetOptions<T> extends SplitOptions with WidgetOptionsMappable {
  final String name;
  final Map<String, dynamic> args;

  const WidgetOptions({
    required this.name,
    this.args = const {},
    super.flex,
    super.position,
  });

  static final schema = SplitOptions.schema.merge(
    {
      "name": Schema.string.isRequired(),
      "args": Schema.any.isOptional(),
    },
  );
}

@MappableClass(
  includeCustomMappers: [DurationMapper()],
)
class TransitionOptions with TransitionOptionsMappable {
  final TransitionType type;
  final Duration duration;
  final Duration delay;
  final CurveType curve;

  const TransitionOptions({
    required this.type,
    this.duration = const Duration(milliseconds: 200),
    this.delay = const Duration(milliseconds: 0),
    this.curve = CurveType.ease,
  });

  static const fromJson = TransitionOptionsMapper.fromJson;

  Duration get totalAnimationDuration => duration + delay;

  TransitionOptions merge(TransitionOptions? other) {
    if (other == null) return this;
    return copyWith.$merge(other);
  }

  static final schema = Schema(
    {
      "type": TransitionType.schema.isRequired(),
      "duration": Schema.integer.isOptional(),
      "delay": Schema.integer.isOptional(),
      "curve": CurveType.schema.isOptional()
    },
  );
}

typedef Decoder<T> = T Function(Map<String, dynamic>);

T mapDecoder<T>(Map<String, dynamic> args) {
  return args as T;
}

class ArgsSchema<T> {
  final Schema validator;
  final Decoder<T> decoder;

  const ArgsSchema({
    required this.validator,
    required this.decoder,
  });
}

class Example<T> extends ExampleWidget {
  final Widget Function(T) builder;

  @override
  final ArgsSchema<T>? schema;

  const Example._({
    required super.name,
    required this.builder,
    this.schema,
  });

  static Example device<T>({
    required String name,
    required Widget Function(T) builder,
    ArgsSchema<T>? schema,
  }) {
    return Example<T>._(
      name: name,
      schema: schema,
      builder: (args) {
        return Padding(
          padding: const EdgeInsets.all(40.0),
          child: builder(args),
        );
      },
    );
  }

  factory Example({
    required String name,
    required Widget Function(T) builder,
    ArgsSchema<T>? schema,
  }) {
    return Example._(
      name: name,
      schema: schema,
      builder: builder,
    );
  }

  @override
  Widget build(args) {
    return builder(args);
  }
}

abstract class ExampleWidget<T> {
  const ExampleWidget({
    required this.name,
  });

  final String name;

  T decode(Map<String, dynamic> args) {
    if (schema?.decoder == null) {
      return args as T;
    } else {
      return schema!.decoder(args);
    }
  }

  ArgsSchema? get schema => null;

  SchemaValidationResult _validate(Map<String, dynamic> args) {
    if (schema?.validator == null) {
      return SchemaValidationResult.valid(['widget', name]);
    } else {
      return schema!.validator.validate(['widget', name], args);
    }
  }

  Widget call(Map<String, dynamic> args) {
    final result = _validate(args);
    if (!result.isValid) {
      return Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.red,
              child: InvalidSlideBuilder(
                config: InvalidSlide.schemaError(result),
              ),
            ),
          ),
        ],
      );
    }
    return build(decode(args));
  }

  Widget build(T args);
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

  static final schema = EnumSchema(
    values: ImageFit.values.map((e) => e.name.snakeCase).toList(),
  );

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

class LayoutType {
  const LayoutType._();
  static const simple = 'simple';
  static const image = 'image';
  static const widget = 'widget';
  static const twoColumn = 'two_column';
  static const twoColumnHeader = 'two_column_header';
  static const invalid = 'invalid';
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
  swing;

  static final schema = EnumSchema(
    values: TransitionType.values.map((e) => e.name.snakeCase).toList(),
  );
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
  linearToEaseOut;

  static final schema = EnumSchema(
    values: values.map((e) => e.name.snakeCase).toList(),
  );
}

@MappableEnum()
enum LayoutPosition {
  left,
  right,
  top,
  bottom;

  static final schema = EnumSchema(
    values: LayoutPosition.values.map((e) => e.name.snakeCase).toList(),
  );

  bool isHorizontal() {
    return switch (this) {
      LayoutPosition.left => true,
      LayoutPosition.right => true,
      LayoutPosition.top => false,
      LayoutPosition.bottom => false,
    };
  }

  bool isVertical() {
    return !isHorizontal();
  }
}

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

  static final schema = EnumSchema(
    values: ContentAlignment.values.map((e) => e.name.snakeCase).toList(),
  );

  Alignment toAlignment() {
    return switch (this) {
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
}
