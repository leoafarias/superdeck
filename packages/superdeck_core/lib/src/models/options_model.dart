part of 'models.dart';

@MappableClass(discriminatorValue: 'content')
class ContentOptions with ContentOptionsMappable {
  final ContentAlignment? align;
  final int? flex;

  const ContentOptions({
    this.flex,
    this.align,
  });

  ContentOptions merge(ContentOptions? other) {
    if (other == null) return this;
    return copyWith.$merge(other);
  }

  static final schema = SchemaShape(
    {
      "align": ContentAlignment.schema.optional(),
      "flex": Schema.integer.optional(),
    },
  );

  bool get isEmpty => flex == null && align == null;
}

@MappableClass(discriminatorValue: 'image')
class ImageOptions extends ContentOptions with ImageOptionsMappable {
  final String src;
  final ImageFit? fit;

  const ImageOptions({
    required this.src,
    this.fit,
    super.flex,
    super.align,
  });

  static final schema = ContentOptions.schema.extend(
    {
      "fit": ImageFit.schema,
      "src": Schema.string.required(),
    },
  );
}

@MappableClass(
  discriminatorValue: 'widget_options',
  hook: UnmappedPropertiesHook('args'),
)
class WidgetOptions extends ContentOptions with WidgetOptionsMappable {
  final String name;
  final Map<String, dynamic> args;

  const WidgetOptions({
    required this.name,
    this.args = const {},
    super.flex,
    super.align,
  });

  static final schema = ContentOptions.schema.extend(
    {
      "name": Schema.string.required(),
    },
    additionalProperties: true,
  );
}

@MappableClass(
  includeCustomMappers: [DurationMapper()],
)
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

  static const fromJson = TransitionOptionsMapper.fromJson;

  Duration get totalAnimationDuration =>
      (duration ?? Duration.zero) + (delay ?? Duration.zero);

  TransitionOptions merge(TransitionOptions? other) {
    if (other == null) return this;
    return copyWith.$merge(other);
  }

  static final schema = SchemaShape(
    {
      "type": TransitionType.schema.required(),
      "duration": Schema.integer.optional(),
      "delay": Schema.integer.optional(),
      "curve": CurveType.schema.optional(),
    },
  );
}

typedef Decoder<T> = T Function(Map<String, dynamic>);

T mapDecoder<T>(Map<String, dynamic> args) {
  return args as T;
}

class ArgsSchema<T> {
  final SchemaShape validator;
  final Decoder<T> decoder;

  const ArgsSchema({
    required this.validator,
    required this.decoder,
  });
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

  static final schema = Schema.string.isEnum(values);
}

class LayoutType {
  const LayoutType._();
  static const simple = 'simple';

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

  static final schema = Schema.string.isEnum(values);
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

  static final schema = Schema.string.isEnum(values);
}

@MappableEnum()
enum LayoutPosition {
  left,
  right,
  top,
  bottom;

  static final schema = Schema.string.isEnum(values);

  bool isHorizontal() {
    return switch (this) {
      LayoutPosition.left => true,
      LayoutPosition.right => true,
      LayoutPosition.top => false,
      LayoutPosition.bottom => false,
    };
  }

  bool isVertical() => !isHorizontal();
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

  static final schema = Schema.string.isEnum(values);
}

extension on SchemaValue<String> {
  SchemaValue<String> isEnum<T extends Enum>(List<T> values) {
    return copyWith(validators: [
      ...validators,
      ArrayValidator(values.map((e) => e.name.snakeCase()).toList()),
    ]);
  }
}
