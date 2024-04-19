// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'options_model.dart';

class ImageFitMapper extends EnumMapper<ImageFit> {
  ImageFitMapper._();

  static ImageFitMapper? _instance;
  static ImageFitMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageFitMapper._());
    }
    return _instance!;
  }

  static ImageFit fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ImageFit decode(dynamic value) {
    switch (value) {
      case 'fill':
        return ImageFit.fill;
      case 'contain':
        return ImageFit.contain;
      case 'cover':
        return ImageFit.cover;
      case 'fit_width':
        return ImageFit.fitWidth;
      case 'fit_height':
        return ImageFit.fitHeight;
      case 'none':
        return ImageFit.none;
      case 'scale_down':
        return ImageFit.scaleDown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ImageFit self) {
    switch (self) {
      case ImageFit.fill:
        return 'fill';
      case ImageFit.contain:
        return 'contain';
      case ImageFit.cover:
        return 'cover';
      case ImageFit.fitWidth:
        return 'fit_width';
      case ImageFit.fitHeight:
        return 'fit_height';
      case ImageFit.none:
        return 'none';
      case ImageFit.scaleDown:
        return 'scale_down';
    }
  }
}

extension ImageFitMapperExtension on ImageFit {
  String toValue() {
    ImageFitMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ImageFit>(this) as String;
  }
}

class TransitionTypeMapper extends EnumMapper<TransitionType> {
  TransitionTypeMapper._();

  static TransitionTypeMapper? _instance;
  static TransitionTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TransitionTypeMapper._());
    }
    return _instance!;
  }

  static TransitionType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TransitionType decode(dynamic value) {
    switch (value) {
      case 'fade_in':
        return TransitionType.fadeIn;
      case 'fade_in_down':
        return TransitionType.fadeInDown;
      case 'fade_in_down_big':
        return TransitionType.fadeInDownBig;
      case 'fade_in_up':
        return TransitionType.fadeInUp;
      case 'fade_in_up_big':
        return TransitionType.fadeInUpBig;
      case 'fade_in_left':
        return TransitionType.fadeInLeft;
      case 'fade_in_left_big':
        return TransitionType.fadeInLeftBig;
      case 'fade_in_right':
        return TransitionType.fadeInRight;
      case 'fade_in_right_big':
        return TransitionType.fadeInRightBig;
      case 'fade_out':
        return TransitionType.fadeOut;
      case 'fade_out_down':
        return TransitionType.fadeOutDown;
      case 'fade_out_down_big':
        return TransitionType.fadeOutDownBig;
      case 'fade_out_up':
        return TransitionType.fadeOutUp;
      case 'fade_out_up_big':
        return TransitionType.fadeOutUpBig;
      case 'fade_out_left':
        return TransitionType.fadeOutLeft;
      case 'fade_out_left_big':
        return TransitionType.fadeOutLeftBig;
      case 'fade_out_right':
        return TransitionType.fadeOutRight;
      case 'fade_out_right_big':
        return TransitionType.fadeOutRightBig;
      case 'bounce_in_down':
        return TransitionType.bounceInDown;
      case 'bounce_in_up':
        return TransitionType.bounceInUp;
      case 'bounce_in_left':
        return TransitionType.bounceInLeft;
      case 'bounce_in_right':
        return TransitionType.bounceInRight;
      case 'elastic_in':
        return TransitionType.elasticIn;
      case 'elastic_in_down':
        return TransitionType.elasticInDown;
      case 'elastic_in_up':
        return TransitionType.elasticInUp;
      case 'elastic_in_left':
        return TransitionType.elasticInLeft;
      case 'elastic_in_right':
        return TransitionType.elasticInRight;
      case 'slide_in_down':
        return TransitionType.slideInDown;
      case 'slide_in_up':
        return TransitionType.slideInUp;
      case 'slide_in_left':
        return TransitionType.slideInLeft;
      case 'slide_in_right':
        return TransitionType.slideInRight;
      case 'flip_in_x':
        return TransitionType.flipInX;
      case 'flip_in_y':
        return TransitionType.flipInY;
      case 'zoom_in':
        return TransitionType.zoomIn;
      case 'zoom_out':
        return TransitionType.zoomOut;
      case 'jello_in':
        return TransitionType.jelloIn;
      case 'bounce':
        return TransitionType.bounce;
      case 'dance':
        return TransitionType.dance;
      case 'flash':
        return TransitionType.flash;
      case 'pulse':
        return TransitionType.pulse;
      case 'roulette':
        return TransitionType.roulette;
      case 'shake_x':
        return TransitionType.shakeX;
      case 'shake_y':
        return TransitionType.shakeY;
      case 'spin':
        return TransitionType.spin;
      case 'spin_perfect':
        return TransitionType.spinPerfect;
      case 'swing':
        return TransitionType.swing;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TransitionType self) {
    switch (self) {
      case TransitionType.fadeIn:
        return 'fade_in';
      case TransitionType.fadeInDown:
        return 'fade_in_down';
      case TransitionType.fadeInDownBig:
        return 'fade_in_down_big';
      case TransitionType.fadeInUp:
        return 'fade_in_up';
      case TransitionType.fadeInUpBig:
        return 'fade_in_up_big';
      case TransitionType.fadeInLeft:
        return 'fade_in_left';
      case TransitionType.fadeInLeftBig:
        return 'fade_in_left_big';
      case TransitionType.fadeInRight:
        return 'fade_in_right';
      case TransitionType.fadeInRightBig:
        return 'fade_in_right_big';
      case TransitionType.fadeOut:
        return 'fade_out';
      case TransitionType.fadeOutDown:
        return 'fade_out_down';
      case TransitionType.fadeOutDownBig:
        return 'fade_out_down_big';
      case TransitionType.fadeOutUp:
        return 'fade_out_up';
      case TransitionType.fadeOutUpBig:
        return 'fade_out_up_big';
      case TransitionType.fadeOutLeft:
        return 'fade_out_left';
      case TransitionType.fadeOutLeftBig:
        return 'fade_out_left_big';
      case TransitionType.fadeOutRight:
        return 'fade_out_right';
      case TransitionType.fadeOutRightBig:
        return 'fade_out_right_big';
      case TransitionType.bounceInDown:
        return 'bounce_in_down';
      case TransitionType.bounceInUp:
        return 'bounce_in_up';
      case TransitionType.bounceInLeft:
        return 'bounce_in_left';
      case TransitionType.bounceInRight:
        return 'bounce_in_right';
      case TransitionType.elasticIn:
        return 'elastic_in';
      case TransitionType.elasticInDown:
        return 'elastic_in_down';
      case TransitionType.elasticInUp:
        return 'elastic_in_up';
      case TransitionType.elasticInLeft:
        return 'elastic_in_left';
      case TransitionType.elasticInRight:
        return 'elastic_in_right';
      case TransitionType.slideInDown:
        return 'slide_in_down';
      case TransitionType.slideInUp:
        return 'slide_in_up';
      case TransitionType.slideInLeft:
        return 'slide_in_left';
      case TransitionType.slideInRight:
        return 'slide_in_right';
      case TransitionType.flipInX:
        return 'flip_in_x';
      case TransitionType.flipInY:
        return 'flip_in_y';
      case TransitionType.zoomIn:
        return 'zoom_in';
      case TransitionType.zoomOut:
        return 'zoom_out';
      case TransitionType.jelloIn:
        return 'jello_in';
      case TransitionType.bounce:
        return 'bounce';
      case TransitionType.dance:
        return 'dance';
      case TransitionType.flash:
        return 'flash';
      case TransitionType.pulse:
        return 'pulse';
      case TransitionType.roulette:
        return 'roulette';
      case TransitionType.shakeX:
        return 'shake_x';
      case TransitionType.shakeY:
        return 'shake_y';
      case TransitionType.spin:
        return 'spin';
      case TransitionType.spinPerfect:
        return 'spin_perfect';
      case TransitionType.swing:
        return 'swing';
    }
  }
}

extension TransitionTypeMapperExtension on TransitionType {
  String toValue() {
    TransitionTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TransitionType>(this) as String;
  }
}

class CurveTypeMapper extends EnumMapper<CurveType> {
  CurveTypeMapper._();

  static CurveTypeMapper? _instance;
  static CurveTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurveTypeMapper._());
    }
    return _instance!;
  }

  static CurveType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CurveType decode(dynamic value) {
    switch (value) {
      case 'ease':
        return CurveType.ease;
      case 'bounce_in':
        return CurveType.bounceIn;
      case 'bounce_out':
        return CurveType.bounceOut;
      case 'ease_in':
        return CurveType.easeIn;
      case 'ease_in_out':
        return CurveType.easeInOut;
      case 'ease_out':
        return CurveType.easeOut;
      case 'elastic_in':
        return CurveType.elasticIn;
      case 'elastic_in_out':
        return CurveType.elasticInOut;
      case 'elastic_out':
        return CurveType.elasticOut;
      case 'fast_linear_to_slow_ease_in':
        return CurveType.fastLinearToSlowEaseIn;
      case 'fast_out_slow_in':
        return CurveType.fastOutSlowIn;
      case 'linear':
        return CurveType.linear;
      case 'decelerate':
        return CurveType.decelerate;
      case 'slow_middle':
        return CurveType.slowMiddle;
      case 'linear_to_ease_out':
        return CurveType.linearToEaseOut;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CurveType self) {
    switch (self) {
      case CurveType.ease:
        return 'ease';
      case CurveType.bounceIn:
        return 'bounce_in';
      case CurveType.bounceOut:
        return 'bounce_out';
      case CurveType.easeIn:
        return 'ease_in';
      case CurveType.easeInOut:
        return 'ease_in_out';
      case CurveType.easeOut:
        return 'ease_out';
      case CurveType.elasticIn:
        return 'elastic_in';
      case CurveType.elasticInOut:
        return 'elastic_in_out';
      case CurveType.elasticOut:
        return 'elastic_out';
      case CurveType.fastLinearToSlowEaseIn:
        return 'fast_linear_to_slow_ease_in';
      case CurveType.fastOutSlowIn:
        return 'fast_out_slow_in';
      case CurveType.linear:
        return 'linear';
      case CurveType.decelerate:
        return 'decelerate';
      case CurveType.slowMiddle:
        return 'slow_middle';
      case CurveType.linearToEaseOut:
        return 'linear_to_ease_out';
    }
  }
}

extension CurveTypeMapperExtension on CurveType {
  String toValue() {
    CurveTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CurveType>(this) as String;
  }
}

class LayoutPositionMapper extends EnumMapper<LayoutPosition> {
  LayoutPositionMapper._();

  static LayoutPositionMapper? _instance;
  static LayoutPositionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LayoutPositionMapper._());
    }
    return _instance!;
  }

  static LayoutPosition fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  LayoutPosition decode(dynamic value) {
    switch (value) {
      case 'left':
        return LayoutPosition.left;
      case 'right':
        return LayoutPosition.right;
      case 'top':
        return LayoutPosition.top;
      case 'bottom':
        return LayoutPosition.bottom;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(LayoutPosition self) {
    switch (self) {
      case LayoutPosition.left:
        return 'left';
      case LayoutPosition.right:
        return 'right';
      case LayoutPosition.top:
        return 'top';
      case LayoutPosition.bottom:
        return 'bottom';
    }
  }
}

extension LayoutPositionMapperExtension on LayoutPosition {
  String toValue() {
    LayoutPositionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<LayoutPosition>(this) as String;
  }
}

class ContentAlignmentMapper extends EnumMapper<ContentAlignment> {
  ContentAlignmentMapper._();

  static ContentAlignmentMapper? _instance;
  static ContentAlignmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentAlignmentMapper._());
    }
    return _instance!;
  }

  static ContentAlignment fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ContentAlignment decode(dynamic value) {
    switch (value) {
      case 'top_left':
        return ContentAlignment.topLeft;
      case 'top_center':
        return ContentAlignment.topCenter;
      case 'top_right':
        return ContentAlignment.topRight;
      case 'center_left':
        return ContentAlignment.centerLeft;
      case 'center':
        return ContentAlignment.center;
      case 'center_right':
        return ContentAlignment.centerRight;
      case 'bottom_left':
        return ContentAlignment.bottomLeft;
      case 'bottom_center':
        return ContentAlignment.bottomCenter;
      case 'bottom_right':
        return ContentAlignment.bottomRight;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ContentAlignment self) {
    switch (self) {
      case ContentAlignment.topLeft:
        return 'top_left';
      case ContentAlignment.topCenter:
        return 'top_center';
      case ContentAlignment.topRight:
        return 'top_right';
      case ContentAlignment.centerLeft:
        return 'center_left';
      case ContentAlignment.center:
        return 'center';
      case ContentAlignment.centerRight:
        return 'center_right';
      case ContentAlignment.bottomLeft:
        return 'bottom_left';
      case ContentAlignment.bottomCenter:
        return 'bottom_center';
      case ContentAlignment.bottomRight:
        return 'bottom_right';
    }
  }
}

extension ContentAlignmentMapperExtension on ContentAlignment {
  String toValue() {
    ContentAlignmentMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ContentAlignment>(this) as String;
  }
}

class ConfigMapper extends ClassMapperBase<Config> {
  ConfigMapper._();

  static ConfigMapper? _instance;
  static ConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigMapper._());
      TransitionOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Config';

  static String? _$background(Config v) => v.background;
  static const Field<Config, String> _f$background =
      Field('background', _$background);
  static String? _$style(Config v) => v.style;
  static const Field<Config, String> _f$style = Field('style', _$style);
  static TransitionOptions? _$transition(Config v) => v.transition;
  static const Field<Config, TransitionOptions> _f$transition =
      Field('transition', _$transition);

  @override
  final MappableFields<Config> fields = const {
    #background: _f$background,
    #style: _f$style,
    #transition: _f$transition,
  };
  @override
  final bool ignoreNull = true;

  static Config _instantiate(DecodingData data) {
    return Config(
        background: data.dec(_f$background),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition));
  }

  @override
  final Function instantiate = _instantiate;

  static Config fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Config>(map);
  }

  static Config fromJson(String json) {
    return ensureInitialized().decodeJson<Config>(json);
  }
}

mixin ConfigMappable {
  String toJson() {
    return ConfigMapper.ensureInitialized().encodeJson<Config>(this as Config);
  }

  Map<String, dynamic> toMap() {
    return ConfigMapper.ensureInitialized().encodeMap<Config>(this as Config);
  }

  ConfigCopyWith<Config, Config, Config> get copyWith =>
      _ConfigCopyWithImpl(this as Config, $identity, $identity);
  @override
  String toString() {
    return ConfigMapper.ensureInitialized().stringifyValue(this as Config);
  }

  @override
  bool operator ==(Object other) {
    return ConfigMapper.ensureInitialized().equalsValue(this as Config, other);
  }

  @override
  int get hashCode {
    return ConfigMapper.ensureInitialized().hashValue(this as Config);
  }
}

extension ConfigValueCopy<$R, $Out> on ObjectCopyWith<$R, Config, $Out> {
  ConfigCopyWith<$R, Config, $Out> get $asConfig =>
      $base.as((v, t, t2) => _ConfigCopyWithImpl(v, t, t2));
}

abstract class ConfigCopyWith<$R, $In extends Config, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  $R call({String? background, String? style, TransitionOptions? transition});
  ConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ConfigCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Config, $Out>
    implements ConfigCopyWith<$R, Config, $Out> {
  _ConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Config> $mapper = ConfigMapper.ensureInitialized();
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? background = $none,
          Object? style = $none,
          Object? transition = $none}) =>
      $apply(FieldCopyWithData({
        if (background != $none) #background: background,
        if (style != $none) #style: style,
        if (transition != $none) #transition: transition
      }));
  @override
  Config $make(CopyWithData data) => Config(
      background: data.get(#background, or: $value.background),
      style: data.get(#style, or: $value.style),
      transition: data.get(#transition, or: $value.transition));

  @override
  ConfigCopyWith<$R2, Config, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ConfigCopyWithImpl($value, $cast, t);
}

class TransitionOptionsMapper extends ClassMapperBase<TransitionOptions> {
  TransitionOptionsMapper._();

  static TransitionOptionsMapper? _instance;
  static TransitionOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TransitionOptionsMapper._());
      MapperContainer.globals.useAll([DurationMapper()]);
      TransitionTypeMapper.ensureInitialized();
      CurveTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TransitionOptions';

  static TransitionType _$type(TransitionOptions v) => v.type;
  static const Field<TransitionOptions, TransitionType> _f$type =
      Field('type', _$type);
  static Duration _$duration(TransitionOptions v) => v.duration;
  static const Field<TransitionOptions, Duration> _f$duration = Field(
      'duration', _$duration,
      opt: true, def: const Duration(milliseconds: 200));
  static Duration _$delay(TransitionOptions v) => v.delay;
  static const Field<TransitionOptions, Duration> _f$delay =
      Field('delay', _$delay, opt: true, def: const Duration(milliseconds: 0));
  static CurveType _$curve(TransitionOptions v) => v.curve;
  static const Field<TransitionOptions, CurveType> _f$curve =
      Field('curve', _$curve, opt: true, def: CurveType.ease);

  @override
  final MappableFields<TransitionOptions> fields = const {
    #type: _f$type,
    #duration: _f$duration,
    #delay: _f$delay,
    #curve: _f$curve,
  };
  @override
  final bool ignoreNull = true;

  static TransitionOptions _instantiate(DecodingData data) {
    return TransitionOptions(
        type: data.dec(_f$type),
        duration: data.dec(_f$duration),
        delay: data.dec(_f$delay),
        curve: data.dec(_f$curve));
  }

  @override
  final Function instantiate = _instantiate;

  static TransitionOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TransitionOptions>(map);
  }

  static TransitionOptions fromJson(String json) {
    return ensureInitialized().decodeJson<TransitionOptions>(json);
  }
}

mixin TransitionOptionsMappable {
  String toJson() {
    return TransitionOptionsMapper.ensureInitialized()
        .encodeJson<TransitionOptions>(this as TransitionOptions);
  }

  Map<String, dynamic> toMap() {
    return TransitionOptionsMapper.ensureInitialized()
        .encodeMap<TransitionOptions>(this as TransitionOptions);
  }

  TransitionOptionsCopyWith<TransitionOptions, TransitionOptions,
          TransitionOptions>
      get copyWith => _TransitionOptionsCopyWithImpl(
          this as TransitionOptions, $identity, $identity);
  @override
  String toString() {
    return TransitionOptionsMapper.ensureInitialized()
        .stringifyValue(this as TransitionOptions);
  }

  @override
  bool operator ==(Object other) {
    return TransitionOptionsMapper.ensureInitialized()
        .equalsValue(this as TransitionOptions, other);
  }

  @override
  int get hashCode {
    return TransitionOptionsMapper.ensureInitialized()
        .hashValue(this as TransitionOptions);
  }
}

extension TransitionOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TransitionOptions, $Out> {
  TransitionOptionsCopyWith<$R, TransitionOptions, $Out>
      get $asTransitionOptions =>
          $base.as((v, t, t2) => _TransitionOptionsCopyWithImpl(v, t, t2));
}

abstract class TransitionOptionsCopyWith<$R, $In extends TransitionOptions,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {TransitionType? type,
      Duration? duration,
      Duration? delay,
      CurveType? curve});
  TransitionOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TransitionOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TransitionOptions, $Out>
    implements TransitionOptionsCopyWith<$R, TransitionOptions, $Out> {
  _TransitionOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TransitionOptions> $mapper =
      TransitionOptionsMapper.ensureInitialized();
  @override
  $R call(
          {TransitionType? type,
          Duration? duration,
          Duration? delay,
          CurveType? curve}) =>
      $apply(FieldCopyWithData({
        if (type != null) #type: type,
        if (duration != null) #duration: duration,
        if (delay != null) #delay: delay,
        if (curve != null) #curve: curve
      }));
  @override
  TransitionOptions $make(CopyWithData data) => TransitionOptions(
      type: data.get(#type, or: $value.type),
      duration: data.get(#duration, or: $value.duration),
      delay: data.get(#delay, or: $value.delay),
      curve: data.get(#curve, or: $value.curve));

  @override
  TransitionOptionsCopyWith<$R2, TransitionOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TransitionOptionsCopyWithImpl($value, $cast, t);
}

class ContentOptionsMapper extends ClassMapperBase<ContentOptions> {
  ContentOptionsMapper._();

  static ContentOptionsMapper? _instance;
  static ContentOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentOptionsMapper._());
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContentOptions';

  static int _$flex(ContentOptions v) => v.flex;
  static const Field<ContentOptions, int> _f$flex =
      Field('flex', _$flex, opt: true, def: 1);
  static ContentAlignment _$alignment(ContentOptions v) => v.alignment;
  static const Field<ContentOptions, ContentAlignment> _f$alignment = Field(
      'alignment', _$alignment,
      opt: true, def: ContentAlignment.centerLeft);

  @override
  final MappableFields<ContentOptions> fields = const {
    #flex: _f$flex,
    #alignment: _f$alignment,
  };
  @override
  final bool ignoreNull = true;

  static ContentOptions _instantiate(DecodingData data) {
    return ContentOptions(
        flex: data.dec(_f$flex), alignment: data.dec(_f$alignment));
  }

  @override
  final Function instantiate = _instantiate;

  static ContentOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContentOptions>(map);
  }

  static ContentOptions fromJson(String json) {
    return ensureInitialized().decodeJson<ContentOptions>(json);
  }
}

mixin ContentOptionsMappable {
  String toJson() {
    return ContentOptionsMapper.ensureInitialized()
        .encodeJson<ContentOptions>(this as ContentOptions);
  }

  Map<String, dynamic> toMap() {
    return ContentOptionsMapper.ensureInitialized()
        .encodeMap<ContentOptions>(this as ContentOptions);
  }

  ContentOptionsCopyWith<ContentOptions, ContentOptions, ContentOptions>
      get copyWith => _ContentOptionsCopyWithImpl(
          this as ContentOptions, $identity, $identity);
  @override
  String toString() {
    return ContentOptionsMapper.ensureInitialized()
        .stringifyValue(this as ContentOptions);
  }

  @override
  bool operator ==(Object other) {
    return ContentOptionsMapper.ensureInitialized()
        .equalsValue(this as ContentOptions, other);
  }

  @override
  int get hashCode {
    return ContentOptionsMapper.ensureInitialized()
        .hashValue(this as ContentOptions);
  }
}

extension ContentOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContentOptions, $Out> {
  ContentOptionsCopyWith<$R, ContentOptions, $Out> get $asContentOptions =>
      $base.as((v, t, t2) => _ContentOptionsCopyWithImpl(v, t, t2));
}

abstract class ContentOptionsCopyWith<$R, $In extends ContentOptions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? flex, ContentAlignment? alignment});
  ContentOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ContentOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContentOptions, $Out>
    implements ContentOptionsCopyWith<$R, ContentOptions, $Out> {
  _ContentOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContentOptions> $mapper =
      ContentOptionsMapper.ensureInitialized();
  @override
  $R call({int? flex, ContentAlignment? alignment}) =>
      $apply(FieldCopyWithData({
        if (flex != null) #flex: flex,
        if (alignment != null) #alignment: alignment
      }));
  @override
  ContentOptions $make(CopyWithData data) => ContentOptions(
      flex: data.get(#flex, or: $value.flex),
      alignment: data.get(#alignment, or: $value.alignment));

  @override
  ContentOptionsCopyWith<$R2, ContentOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ContentOptionsCopyWithImpl($value, $cast, t);
}

class SplitOptionsMapper extends ClassMapperBase<SplitOptions> {
  SplitOptionsMapper._();

  static SplitOptionsMapper? _instance;
  static SplitOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SplitOptionsMapper._());
      ImageOptionsMapper.ensureInitialized();
      WidgetOptionsMapper.ensureInitialized();
      LayoutPositionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SplitOptions';

  static int _$flex(SplitOptions v) => v.flex;
  static const Field<SplitOptions, int> _f$flex =
      Field('flex', _$flex, opt: true, def: 1);
  static LayoutPosition _$position(SplitOptions v) => v.position;
  static const Field<SplitOptions, LayoutPosition> _f$position =
      Field('position', _$position, opt: true, def: LayoutPosition.right);

  @override
  final MappableFields<SplitOptions> fields = const {
    #flex: _f$flex,
    #position: _f$position,
  };
  @override
  final bool ignoreNull = true;

  static SplitOptions _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('SplitOptions');
  }

  @override
  final Function instantiate = _instantiate;

  static SplitOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SplitOptions>(map);
  }

  static SplitOptions fromJson(String json) {
    return ensureInitialized().decodeJson<SplitOptions>(json);
  }
}

mixin SplitOptionsMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SplitOptionsCopyWith<SplitOptions, SplitOptions, SplitOptions> get copyWith;
}

abstract class SplitOptionsCopyWith<$R, $In extends SplitOptions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? flex, LayoutPosition? position});
  SplitOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ImageOptionsMapper extends ClassMapperBase<ImageOptions> {
  ImageOptionsMapper._();

  static ImageOptionsMapper? _instance;
  static ImageOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageOptionsMapper._());
      SplitOptionsMapper.ensureInitialized();
      ImageFitMapper.ensureInitialized();
      LayoutPositionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageOptions';

  static String _$src(ImageOptions v) => v.src;
  static const Field<ImageOptions, String> _f$src = Field('src', _$src);
  static ImageFit? _$fit(ImageOptions v) => v.fit;
  static const Field<ImageOptions, ImageFit> _f$fit =
      Field('fit', _$fit, opt: true);
  static int _$flex(ImageOptions v) => v.flex;
  static const Field<ImageOptions, int> _f$flex =
      Field('flex', _$flex, opt: true, def: 1);
  static LayoutPosition _$position(ImageOptions v) => v.position;
  static const Field<ImageOptions, LayoutPosition> _f$position =
      Field('position', _$position, opt: true, def: LayoutPosition.right);

  @override
  final MappableFields<ImageOptions> fields = const {
    #src: _f$src,
    #fit: _f$fit,
    #flex: _f$flex,
    #position: _f$position,
  };
  @override
  final bool ignoreNull = true;

  static ImageOptions _instantiate(DecodingData data) {
    return ImageOptions(
        src: data.dec(_f$src),
        fit: data.dec(_f$fit),
        flex: data.dec(_f$flex),
        position: data.dec(_f$position));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageOptions>(map);
  }

  static ImageOptions fromJson(String json) {
    return ensureInitialized().decodeJson<ImageOptions>(json);
  }
}

mixin ImageOptionsMappable {
  String toJson() {
    return ImageOptionsMapper.ensureInitialized()
        .encodeJson<ImageOptions>(this as ImageOptions);
  }

  Map<String, dynamic> toMap() {
    return ImageOptionsMapper.ensureInitialized()
        .encodeMap<ImageOptions>(this as ImageOptions);
  }

  ImageOptionsCopyWith<ImageOptions, ImageOptions, ImageOptions> get copyWith =>
      _ImageOptionsCopyWithImpl(this as ImageOptions, $identity, $identity);
  @override
  String toString() {
    return ImageOptionsMapper.ensureInitialized()
        .stringifyValue(this as ImageOptions);
  }

  @override
  bool operator ==(Object other) {
    return ImageOptionsMapper.ensureInitialized()
        .equalsValue(this as ImageOptions, other);
  }

  @override
  int get hashCode {
    return ImageOptionsMapper.ensureInitialized()
        .hashValue(this as ImageOptions);
  }
}

extension ImageOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageOptions, $Out> {
  ImageOptionsCopyWith<$R, ImageOptions, $Out> get $asImageOptions =>
      $base.as((v, t, t2) => _ImageOptionsCopyWithImpl(v, t, t2));
}

abstract class ImageOptionsCopyWith<$R, $In extends ImageOptions, $Out>
    implements SplitOptionsCopyWith<$R, $In, $Out> {
  @override
  $R call({String? src, ImageFit? fit, int? flex, LayoutPosition? position});
  ImageOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageOptions, $Out>
    implements ImageOptionsCopyWith<$R, ImageOptions, $Out> {
  _ImageOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageOptions> $mapper =
      ImageOptionsMapper.ensureInitialized();
  @override
  $R call(
          {String? src,
          Object? fit = $none,
          int? flex,
          LayoutPosition? position}) =>
      $apply(FieldCopyWithData({
        if (src != null) #src: src,
        if (fit != $none) #fit: fit,
        if (flex != null) #flex: flex,
        if (position != null) #position: position
      }));
  @override
  ImageOptions $make(CopyWithData data) => ImageOptions(
      src: data.get(#src, or: $value.src),
      fit: data.get(#fit, or: $value.fit),
      flex: data.get(#flex, or: $value.flex),
      position: data.get(#position, or: $value.position));

  @override
  ImageOptionsCopyWith<$R2, ImageOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageOptionsCopyWithImpl($value, $cast, t);
}

class WidgetOptionsMapper extends ClassMapperBase<WidgetOptions> {
  WidgetOptionsMapper._();

  static WidgetOptionsMapper? _instance;
  static WidgetOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetOptionsMapper._());
      SplitOptionsMapper.ensureInitialized();
      LayoutPositionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WidgetOptions';
  @override
  Function get typeFactory => <T>(f) => f<WidgetOptions<T>>();

  static String _$name(WidgetOptions v) => v.name;
  static const Field<WidgetOptions, String> _f$name = Field('name', _$name);
  static Map<String, dynamic> _$args(WidgetOptions v) => v.args;
  static const Field<WidgetOptions, Map<String, dynamic>> _f$args =
      Field('args', _$args, opt: true, def: const {});
  static bool _$preview(WidgetOptions v) => v.preview;
  static const Field<WidgetOptions, bool> _f$preview =
      Field('preview', _$preview, opt: true, def: false);
  static int _$flex(WidgetOptions v) => v.flex;
  static const Field<WidgetOptions, int> _f$flex =
      Field('flex', _$flex, opt: true, def: 1);
  static LayoutPosition _$position(WidgetOptions v) => v.position;
  static const Field<WidgetOptions, LayoutPosition> _f$position =
      Field('position', _$position, opt: true, def: LayoutPosition.right);

  @override
  final MappableFields<WidgetOptions> fields = const {
    #name: _f$name,
    #args: _f$args,
    #preview: _f$preview,
    #flex: _f$flex,
    #position: _f$position,
  };
  @override
  final bool ignoreNull = true;

  static WidgetOptions<T> _instantiate<T>(DecodingData data) {
    return WidgetOptions(
        name: data.dec(_f$name),
        args: data.dec(_f$args),
        preview: data.dec(_f$preview),
        flex: data.dec(_f$flex),
        position: data.dec(_f$position));
  }

  @override
  final Function instantiate = _instantiate;

  static WidgetOptions<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WidgetOptions<T>>(map);
  }

  static WidgetOptions<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<WidgetOptions<T>>(json);
  }
}

mixin WidgetOptionsMappable<T> {
  String toJson() {
    return WidgetOptionsMapper.ensureInitialized()
        .encodeJson<WidgetOptions<T>>(this as WidgetOptions<T>);
  }

  Map<String, dynamic> toMap() {
    return WidgetOptionsMapper.ensureInitialized()
        .encodeMap<WidgetOptions<T>>(this as WidgetOptions<T>);
  }

  WidgetOptionsCopyWith<WidgetOptions<T>, WidgetOptions<T>, WidgetOptions<T>, T>
      get copyWith => _WidgetOptionsCopyWithImpl(
          this as WidgetOptions<T>, $identity, $identity);
  @override
  String toString() {
    return WidgetOptionsMapper.ensureInitialized()
        .stringifyValue(this as WidgetOptions<T>);
  }

  @override
  bool operator ==(Object other) {
    return WidgetOptionsMapper.ensureInitialized()
        .equalsValue(this as WidgetOptions<T>, other);
  }

  @override
  int get hashCode {
    return WidgetOptionsMapper.ensureInitialized()
        .hashValue(this as WidgetOptions<T>);
  }
}

extension WidgetOptionsValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, WidgetOptions<T>, $Out> {
  WidgetOptionsCopyWith<$R, WidgetOptions<T>, $Out, T> get $asWidgetOptions =>
      $base.as((v, t, t2) => _WidgetOptionsCopyWithImpl(v, t, t2));
}

abstract class WidgetOptionsCopyWith<$R, $In extends WidgetOptions<T>, $Out, T>
    implements SplitOptionsCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get args;
  @override
  $R call(
      {String? name,
      Map<String, dynamic>? args,
      bool? preview,
      int? flex,
      LayoutPosition? position});
  WidgetOptionsCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WidgetOptionsCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, WidgetOptions<T>, $Out>
    implements WidgetOptionsCopyWith<$R, WidgetOptions<T>, $Out, T> {
  _WidgetOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WidgetOptions> $mapper =
      WidgetOptionsMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get args => MapCopyWith($value.args,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(args: v));
  @override
  $R call(
          {String? name,
          Map<String, dynamic>? args,
          bool? preview,
          int? flex,
          LayoutPosition? position}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (args != null) #args: args,
        if (preview != null) #preview: preview,
        if (flex != null) #flex: flex,
        if (position != null) #position: position
      }));
  @override
  WidgetOptions<T> $make(CopyWithData data) => WidgetOptions(
      name: data.get(#name, or: $value.name),
      args: data.get(#args, or: $value.args),
      preview: data.get(#preview, or: $value.preview),
      flex: data.get(#flex, or: $value.flex),
      position: data.get(#position, or: $value.position));

  @override
  WidgetOptionsCopyWith<$R2, WidgetOptions<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WidgetOptionsCopyWithImpl($value, $cast, t);
}
