part of 'models.dart';

@MappableClass(discriminatorValue: 'content')
class BlockOptions with BlockOptionsMappable {
  final ContentAlignment? align;
  final int? flex;
  final String? tag;

  const BlockOptions({
    this.flex,
    this.align,
    this.tag,
  });

  BlockOptions merge(BlockOptions? other) {
    if (other == null) return this;
    return copyWith.$merge(other);
  }

  static final schema = SchemaShape({
    "align": ContentAlignment.schema.optional(),
    "flex": Schema.integer.optional(),
    "tag": Schema.string.optional(),
  });

  bool get isEmpty => flex == null && align == null;
}

@MappableClass(discriminatorValue: 'image')
class ImageOptions extends BlockOptions with ImageOptionsMappable {
  final String src;
  final ImageFit? fit;

  const ImageOptions({
    required this.src,
    this.fit,
    super.flex,
    super.align,
    super.tag,
  });

  static final schema = BlockOptions.schema.extend({
    "fit": ImageFit.schema,
    "src": Schema.string.required(),
  });
}

@MappableClass(
  discriminatorValue: 'widget_options',
  hook: UnmappedPropertiesHook('args'),
)
class WidgetOptions extends BlockOptions with WidgetOptionsMappable {
  final String name;
  final Map<String, dynamic> args;

  const WidgetOptions({
    required this.name,
    this.args = const {},
    super.flex,
    super.align,
    super.tag,
  });

  static final schema = BlockOptions.schema.extend(
    {"name": Schema.string.required()},
    additionalProperties: true,
  );
}

@MappableEnum()
enum DartPadTheme {
  dark,
  light;

  static final schema = Schema.string.isEnum(values);
}

@MappableClass()
class DartPadOptions extends BlockOptions with DartPadOptionsMappable {
  final String id;
  final DartPadTheme? theme;
  final bool embed;

  DartPadOptions({
    required this.id,
    this.theme,
    super.flex,
    super.tag,
    super.align,
    this.embed = true,
  });

  static final schema = BlockOptions.schema.extend({
    'id': Schema.string.required(),
    'theme': DartPadTheme.schema.optional(),
    'embed': Schema.boolean.optional(),
  });
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

  static final schema = SchemaShape({
    "type": TransitionType.schema.required(),
    "duration": Schema.integer.optional(),
    "delay": Schema.integer.optional(),
    "curve": CurveType.schema.optional(),
  });
}

typedef Decoder<T> = T Function(Map<String, dynamic>);

T mapDecoder<T>(Map<String, dynamic> args) {
  return args as T;
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
