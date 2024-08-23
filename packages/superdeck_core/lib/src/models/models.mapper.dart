// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'models.dart';

class AssetFileTypeMapper extends EnumMapper<AssetFileType> {
  AssetFileTypeMapper._();

  static AssetFileTypeMapper? _instance;
  static AssetFileTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetFileTypeMapper._());
    }
    return _instance!;
  }

  static AssetFileType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AssetFileType decode(dynamic value) {
    switch (value) {
      case 'png':
        return AssetFileType.png;
      case 'jpg':
        return AssetFileType.jpg;
      case 'jpeg':
        return AssetFileType.jpeg;
      case 'gif':
        return AssetFileType.gif;
      case 'webp':
        return AssetFileType.webp;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AssetFileType self) {
    switch (self) {
      case AssetFileType.png:
        return 'png';
      case AssetFileType.jpg:
        return 'jpg';
      case AssetFileType.jpeg:
        return 'jpeg';
      case AssetFileType.gif:
        return 'gif';
      case AssetFileType.webp:
        return 'webp';
    }
  }
}

extension AssetFileTypeMapperExtension on AssetFileType {
  String toValue() {
    AssetFileTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AssetFileType>(this) as String;
  }
}

class SlideAssetMapper extends ClassMapperBase<SlideAsset> {
  SlideAssetMapper._();

  static SlideAssetMapper? _instance;
  static SlideAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideAssetMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SlideAsset';

  static String _$path(SlideAsset v) => v.path;
  static const Field<SlideAsset, String> _f$path = Field('path', _$path);
  static int _$width(SlideAsset v) => v.width;
  static const Field<SlideAsset, int> _f$width = Field('width', _$width);
  static int _$height(SlideAsset v) => v.height;
  static const Field<SlideAsset, int> _f$height = Field('height', _$height);
  static String? _$reference(SlideAsset v) => v.reference;
  static const Field<SlideAsset, String> _f$reference =
      Field('reference', _$reference);

  @override
  final MappableFields<SlideAsset> fields = const {
    #path: _f$path,
    #width: _f$width,
    #height: _f$height,
    #reference: _f$reference,
  };
  @override
  final bool ignoreNull = true;

  static SlideAsset _instantiate(DecodingData data) {
    return SlideAsset(
        path: data.dec(_f$path),
        width: data.dec(_f$width),
        height: data.dec(_f$height),
        reference: data.dec(_f$reference));
  }

  @override
  final Function instantiate = _instantiate;

  static SlideAsset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideAsset>(map);
  }

  static SlideAsset fromJson(String json) {
    return ensureInitialized().decodeJson<SlideAsset>(json);
  }
}

mixin SlideAssetMappable {
  String toJson() {
    return SlideAssetMapper.ensureInitialized()
        .encodeJson<SlideAsset>(this as SlideAsset);
  }

  Map<String, dynamic> toMap() {
    return SlideAssetMapper.ensureInitialized()
        .encodeMap<SlideAsset>(this as SlideAsset);
  }

  SlideAssetCopyWith<SlideAsset, SlideAsset, SlideAsset> get copyWith =>
      _SlideAssetCopyWithImpl(this as SlideAsset, $identity, $identity);
  @override
  String toString() {
    return SlideAssetMapper.ensureInitialized()
        .stringifyValue(this as SlideAsset);
  }

  @override
  bool operator ==(Object other) {
    return SlideAssetMapper.ensureInitialized()
        .equalsValue(this as SlideAsset, other);
  }

  @override
  int get hashCode {
    return SlideAssetMapper.ensureInitialized().hashValue(this as SlideAsset);
  }
}

extension SlideAssetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SlideAsset, $Out> {
  SlideAssetCopyWith<$R, SlideAsset, $Out> get $asSlideAsset =>
      $base.as((v, t, t2) => _SlideAssetCopyWithImpl(v, t, t2));
}

abstract class SlideAssetCopyWith<$R, $In extends SlideAsset, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? path, int? width, int? height, String? reference});
  SlideAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideAssetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SlideAsset, $Out>
    implements SlideAssetCopyWith<$R, SlideAsset, $Out> {
  _SlideAssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SlideAsset> $mapper =
      SlideAssetMapper.ensureInitialized();
  @override
  $R call({String? path, int? width, int? height, Object? reference = $none}) =>
      $apply(FieldCopyWithData({
        if (path != null) #path: path,
        if (width != null) #width: width,
        if (height != null) #height: height,
        if (reference != $none) #reference: reference
      }));
  @override
  SlideAsset $make(CopyWithData data) => SlideAsset(
      path: data.get(#path, or: $value.path),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      reference: data.get(#reference, or: $value.reference));

  @override
  SlideAssetCopyWith<$R2, SlideAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideAssetCopyWithImpl($value, $cast, t);
}

class SlideOptionsMapper extends ClassMapperBase<SlideOptions> {
  SlideOptionsMapper._();

  static SlideOptionsMapper? _instance;
  static SlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideOptionsMapper._());
      ConfigMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideOptions';

  static String? _$title(SlideOptions v) => v.title;
  static const Field<SlideOptions, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(SlideOptions v) => v.background;
  static const Field<SlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static String? _$style(SlideOptions v) => v.style;
  static const Field<SlideOptions, String> _f$style =
      Field('style', _$style, opt: true);
  static TransitionOptions? _$transition(SlideOptions v) => v.transition;
  static const Field<SlideOptions, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);

  @override
  final MappableFields<SlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #style: _f$style,
    #transition: _f$transition,
  };
  @override
  final bool ignoreNull = true;

  static SlideOptions _instantiate(DecodingData data) {
    return SlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition));
  }

  @override
  final Function instantiate = _instantiate;

  static SlideOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideOptions>(map);
  }

  static SlideOptions fromJson(String json) {
    return ensureInitialized().decodeJson<SlideOptions>(json);
  }
}

mixin SlideOptionsMappable {
  String toJson() {
    return SlideOptionsMapper.ensureInitialized()
        .encodeJson<SlideOptions>(this as SlideOptions);
  }

  Map<String, dynamic> toMap() {
    return SlideOptionsMapper.ensureInitialized()
        .encodeMap<SlideOptions>(this as SlideOptions);
  }

  SlideOptionsCopyWith<SlideOptions, SlideOptions, SlideOptions> get copyWith =>
      _SlideOptionsCopyWithImpl(this as SlideOptions, $identity, $identity);
  @override
  String toString() {
    return SlideOptionsMapper.ensureInitialized()
        .stringifyValue(this as SlideOptions);
  }

  @override
  bool operator ==(Object other) {
    return SlideOptionsMapper.ensureInitialized()
        .equalsValue(this as SlideOptions, other);
  }

  @override
  int get hashCode {
    return SlideOptionsMapper.ensureInitialized()
        .hashValue(this as SlideOptions);
  }
}

extension SlideOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SlideOptions, $Out> {
  SlideOptionsCopyWith<$R, SlideOptions, $Out> get $asSlideOptions =>
      $base.as((v, t, t2) => _SlideOptionsCopyWithImpl(v, t, t2));
}

abstract class SlideOptionsCopyWith<$R, $In extends SlideOptions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  $R call({String? background, String? style, TransitionOptions? transition});
  SlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SlideOptions, $Out>
    implements SlideOptionsCopyWith<$R, SlideOptions, $Out> {
  _SlideOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SlideOptions> $mapper =
      SlideOptionsMapper.ensureInitialized();
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
  SlideOptions $make(CopyWithData data) => SlideOptions(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      style: data.get(#style, or: $value.style),
      transition: data.get(#transition, or: $value.transition));

  @override
  SlideOptionsCopyWith<$R2, SlideOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideOptionsCopyWithImpl($value, $cast, t);
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
  static Duration? _$duration(TransitionOptions v) => v.duration;
  static const Field<TransitionOptions, Duration> _f$duration =
      Field('duration', _$duration, opt: true);
  static Duration? _$delay(TransitionOptions v) => v.delay;
  static const Field<TransitionOptions, Duration> _f$delay =
      Field('delay', _$delay, opt: true);
  static CurveType? _$curve(TransitionOptions v) => v.curve;
  static const Field<TransitionOptions, CurveType> _f$curve =
      Field('curve', _$curve, opt: true);

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
          Object? duration = $none,
          Object? delay = $none,
          Object? curve = $none}) =>
      $apply(FieldCopyWithData({
        if (type != null) #type: type,
        if (duration != $none) #duration: duration,
        if (delay != $none) #delay: delay,
        if (curve != $none) #curve: curve
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

class ConfigMapper extends SubClassMapperBase<Config> {
  ConfigMapper._();

  static ConfigMapper? _instance;
  static ConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigMapper._());
      SlideOptionsMapper.ensureInitialized().addSubMapper(_instance!);
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
  static bool? _$cacheRemoteAssets(Config v) => v.cacheRemoteAssets;
  static const Field<Config, bool> _f$cacheRemoteAssets = Field(
      'cacheRemoteAssets', _$cacheRemoteAssets,
      key: 'cache_remote_assets', opt: true);
  static String? _$title(Config v) => v.title;
  static const Field<Config, String> _f$title =
      Field('title', _$title, mode: FieldMode.member);

  @override
  final MappableFields<Config> fields = const {
    #background: _f$background,
    #style: _f$style,
    #transition: _f$transition,
    #cacheRemoteAssets: _f$cacheRemoteAssets,
    #title: _f$title,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Config';
  @override
  late final ClassMapperBase superMapper =
      SlideOptionsMapper.ensureInitialized();

  static Config _instantiate(DecodingData data) {
    return Config(
        background: data.dec(_f$background),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition),
        cacheRemoteAssets: data.dec(_f$cacheRemoteAssets));
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
    implements SlideOptionsCopyWith<$R, $In, $Out> {
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? background,
      String? style,
      TransitionOptions? transition,
      bool? cacheRemoteAssets});
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
          Object? transition = $none,
          Object? cacheRemoteAssets = $none}) =>
      $apply(FieldCopyWithData({
        if (background != $none) #background: background,
        if (style != $none) #style: style,
        if (transition != $none) #transition: transition,
        if (cacheRemoteAssets != $none) #cacheRemoteAssets: cacheRemoteAssets
      }));
  @override
  Config $make(CopyWithData data) => Config(
      background: data.get(#background, or: $value.background),
      style: data.get(#style, or: $value.style),
      transition: data.get(#transition, or: $value.transition),
      cacheRemoteAssets:
          data.get(#cacheRemoteAssets, or: $value.cacheRemoteAssets));

  @override
  ConfigCopyWith<$R2, Config, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ConfigCopyWithImpl($value, $cast, t);
}

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

class ContentOptionsMapper extends ClassMapperBase<ContentOptions> {
  ContentOptionsMapper._();

  static ContentOptionsMapper? _instance;
  static ContentOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentOptionsMapper._());
      ImageOptionsMapper.ensureInitialized();
      WidgetOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContentOptions';

  static int? _$flex(ContentOptions v) => v.flex;
  static const Field<ContentOptions, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(ContentOptions v) => v.align;
  static const Field<ContentOptions, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);

  @override
  final MappableFields<ContentOptions> fields = const {
    #flex: _f$flex,
    #align: _f$align,
  };
  @override
  final bool ignoreNull = true;

  static ContentOptions _instantiate(DecodingData data) {
    return ContentOptions(flex: data.dec(_f$flex), align: data.dec(_f$align));
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
  $R call({int? flex, ContentAlignment? align});
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
  $R call({Object? flex = $none, Object? align = $none}) =>
      $apply(FieldCopyWithData(
          {if (flex != $none) #flex: flex, if (align != $none) #align: align}));
  @override
  ContentOptions $make(CopyWithData data) => ContentOptions(
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align));

  @override
  ContentOptionsCopyWith<$R2, ContentOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ContentOptionsCopyWithImpl($value, $cast, t);
}

class ImageOptionsMapper extends SubClassMapperBase<ImageOptions> {
  ImageOptionsMapper._();

  static ImageOptionsMapper? _instance;
  static ImageOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageOptionsMapper._());
      ContentOptionsMapper.ensureInitialized().addSubMapper(_instance!);
      ImageFitMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
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
  static int? _$flex(ImageOptions v) => v.flex;
  static const Field<ImageOptions, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(ImageOptions v) => v.align;
  static const Field<ImageOptions, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);

  @override
  final MappableFields<ImageOptions> fields = const {
    #src: _f$src,
    #fit: _f$fit,
    #flex: _f$flex,
    #align: _f$align,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ImageOptions';
  @override
  late final ClassMapperBase superMapper =
      ContentOptionsMapper.ensureInitialized();

  static ImageOptions _instantiate(DecodingData data) {
    return ImageOptions(
        src: data.dec(_f$src),
        fit: data.dec(_f$fit),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align));
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
    implements ContentOptionsCopyWith<$R, $In, $Out> {
  @override
  $R call({String? src, ImageFit? fit, int? flex, ContentAlignment? align});
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
          Object? flex = $none,
          Object? align = $none}) =>
      $apply(FieldCopyWithData({
        if (src != null) #src: src,
        if (fit != $none) #fit: fit,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align
      }));
  @override
  ImageOptions $make(CopyWithData data) => ImageOptions(
      src: data.get(#src, or: $value.src),
      fit: data.get(#fit, or: $value.fit),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align));

  @override
  ImageOptionsCopyWith<$R2, ImageOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageOptionsCopyWithImpl($value, $cast, t);
}

class WidgetOptionsMapper extends SubClassMapperBase<WidgetOptions> {
  WidgetOptionsMapper._();

  static WidgetOptionsMapper? _instance;
  static WidgetOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetOptionsMapper._());
      ContentOptionsMapper.ensureInitialized().addSubMapper(_instance!);
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WidgetOptions';

  static String _$name(WidgetOptions v) => v.name;
  static const Field<WidgetOptions, String> _f$name = Field('name', _$name);
  static Map<String, dynamic> _$args(WidgetOptions v) => v.args;
  static const Field<WidgetOptions, Map<String, dynamic>> _f$args =
      Field('args', _$args, opt: true, def: const {});
  static int? _$flex(WidgetOptions v) => v.flex;
  static const Field<WidgetOptions, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(WidgetOptions v) => v.align;
  static const Field<WidgetOptions, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);

  @override
  final MappableFields<WidgetOptions> fields = const {
    #name: _f$name,
    #args: _f$args,
    #flex: _f$flex,
    #align: _f$align,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'WidgetOptions';
  @override
  late final ClassMapperBase superMapper =
      ContentOptionsMapper.ensureInitialized();

  @override
  final MappingHook hook = const UnmappedPropertiesHook('args');
  static WidgetOptions _instantiate(DecodingData data) {
    return WidgetOptions(
        name: data.dec(_f$name),
        args: data.dec(_f$args),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align));
  }

  @override
  final Function instantiate = _instantiate;

  static WidgetOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WidgetOptions>(map);
  }

  static WidgetOptions fromJson(String json) {
    return ensureInitialized().decodeJson<WidgetOptions>(json);
  }
}

mixin WidgetOptionsMappable {
  String toJson() {
    return WidgetOptionsMapper.ensureInitialized()
        .encodeJson<WidgetOptions>(this as WidgetOptions);
  }

  Map<String, dynamic> toMap() {
    return WidgetOptionsMapper.ensureInitialized()
        .encodeMap<WidgetOptions>(this as WidgetOptions);
  }

  WidgetOptionsCopyWith<WidgetOptions, WidgetOptions, WidgetOptions>
      get copyWith => _WidgetOptionsCopyWithImpl(
          this as WidgetOptions, $identity, $identity);
  @override
  String toString() {
    return WidgetOptionsMapper.ensureInitialized()
        .stringifyValue(this as WidgetOptions);
  }

  @override
  bool operator ==(Object other) {
    return WidgetOptionsMapper.ensureInitialized()
        .equalsValue(this as WidgetOptions, other);
  }

  @override
  int get hashCode {
    return WidgetOptionsMapper.ensureInitialized()
        .hashValue(this as WidgetOptions);
  }
}

extension WidgetOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WidgetOptions, $Out> {
  WidgetOptionsCopyWith<$R, WidgetOptions, $Out> get $asWidgetOptions =>
      $base.as((v, t, t2) => _WidgetOptionsCopyWithImpl(v, t, t2));
}

abstract class WidgetOptionsCopyWith<$R, $In extends WidgetOptions, $Out>
    implements ContentOptionsCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get args;
  @override
  $R call(
      {String? name,
      Map<String, dynamic>? args,
      int? flex,
      ContentAlignment? align});
  WidgetOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WidgetOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WidgetOptions, $Out>
    implements WidgetOptionsCopyWith<$R, WidgetOptions, $Out> {
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
          Object? flex = $none,
          Object? align = $none}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (args != null) #args: args,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align
      }));
  @override
  WidgetOptions $make(CopyWithData data) => WidgetOptions(
      name: data.get(#name, or: $value.name),
      args: data.get(#args, or: $value.args),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align));

  @override
  WidgetOptionsCopyWith<$R2, WidgetOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WidgetOptionsCopyWithImpl($value, $cast, t);
}

class SuperDeckReferenceMapper extends ClassMapperBase<SuperDeckReference> {
  SuperDeckReferenceMapper._();

  static SuperDeckReferenceMapper? _instance;
  static SuperDeckReferenceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SuperDeckReferenceMapper._());
      ConfigMapper.ensureInitialized();
      SlideMapper.ensureInitialized();
      SlideAssetMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SuperDeckReference';

  static Config _$config(SuperDeckReference v) => v.config;
  static const Field<SuperDeckReference, Config> _f$config =
      Field('config', _$config);
  static List<Slide> _$slides(SuperDeckReference v) => v.slides;
  static const Field<SuperDeckReference, List<Slide>> _f$slides =
      Field('slides', _$slides);
  static List<SlideAsset> _$assets(SuperDeckReference v) => v.assets;
  static const Field<SuperDeckReference, List<SlideAsset>> _f$assets =
      Field('assets', _$assets);

  @override
  final MappableFields<SuperDeckReference> fields = const {
    #config: _f$config,
    #slides: _f$slides,
    #assets: _f$assets,
  };
  @override
  final bool ignoreNull = true;

  static SuperDeckReference _instantiate(DecodingData data) {
    return SuperDeckReference(
        config: data.dec(_f$config),
        slides: data.dec(_f$slides),
        assets: data.dec(_f$assets));
  }

  @override
  final Function instantiate = _instantiate;

  static SuperDeckReference fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SuperDeckReference>(map);
  }

  static SuperDeckReference fromJson(String json) {
    return ensureInitialized().decodeJson<SuperDeckReference>(json);
  }
}

mixin SuperDeckReferenceMappable {
  String toJson() {
    return SuperDeckReferenceMapper.ensureInitialized()
        .encodeJson<SuperDeckReference>(this as SuperDeckReference);
  }

  Map<String, dynamic> toMap() {
    return SuperDeckReferenceMapper.ensureInitialized()
        .encodeMap<SuperDeckReference>(this as SuperDeckReference);
  }

  SuperDeckReferenceCopyWith<SuperDeckReference, SuperDeckReference,
          SuperDeckReference>
      get copyWith => _SuperDeckReferenceCopyWithImpl(
          this as SuperDeckReference, $identity, $identity);
  @override
  String toString() {
    return SuperDeckReferenceMapper.ensureInitialized()
        .stringifyValue(this as SuperDeckReference);
  }

  @override
  bool operator ==(Object other) {
    return SuperDeckReferenceMapper.ensureInitialized()
        .equalsValue(this as SuperDeckReference, other);
  }

  @override
  int get hashCode {
    return SuperDeckReferenceMapper.ensureInitialized()
        .hashValue(this as SuperDeckReference);
  }
}

extension SuperDeckReferenceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SuperDeckReference, $Out> {
  SuperDeckReferenceCopyWith<$R, SuperDeckReference, $Out>
      get $asSuperDeckReference =>
          $base.as((v, t, t2) => _SuperDeckReferenceCopyWithImpl(v, t, t2));
}

abstract class SuperDeckReferenceCopyWith<$R, $In extends SuperDeckReference,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ConfigCopyWith<$R, Config, Config> get config;
  ListCopyWith<$R, Slide, SlideCopyWith<$R, Slide, Slide>> get slides;
  ListCopyWith<$R, SlideAsset, SlideAssetCopyWith<$R, SlideAsset, SlideAsset>>
      get assets;
  $R call({Config? config, List<Slide>? slides, List<SlideAsset>? assets});
  SuperDeckReferenceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SuperDeckReferenceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SuperDeckReference, $Out>
    implements SuperDeckReferenceCopyWith<$R, SuperDeckReference, $Out> {
  _SuperDeckReferenceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SuperDeckReference> $mapper =
      SuperDeckReferenceMapper.ensureInitialized();
  @override
  ConfigCopyWith<$R, Config, Config> get config =>
      $value.config.copyWith.$chain((v) => call(config: v));
  @override
  ListCopyWith<$R, Slide, SlideCopyWith<$R, Slide, Slide>> get slides =>
      ListCopyWith($value.slides, (v, t) => v.copyWith.$chain(t),
          (v) => call(slides: v));
  @override
  ListCopyWith<$R, SlideAsset, SlideAssetCopyWith<$R, SlideAsset, SlideAsset>>
      get assets => ListCopyWith($value.assets, (v, t) => v.copyWith.$chain(t),
          (v) => call(assets: v));
  @override
  $R call({Config? config, List<Slide>? slides, List<SlideAsset>? assets}) =>
      $apply(FieldCopyWithData({
        if (config != null) #config: config,
        if (slides != null) #slides: slides,
        if (assets != null) #assets: assets
      }));
  @override
  SuperDeckReference $make(CopyWithData data) => SuperDeckReference(
      config: data.get(#config, or: $value.config),
      slides: data.get(#slides, or: $value.slides),
      assets: data.get(#assets, or: $value.assets));

  @override
  SuperDeckReferenceCopyWith<$R2, SuperDeckReference, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SuperDeckReferenceCopyWithImpl($value, $cast, t);
}

class SlideMapper extends ClassMapperBase<Slide> {
  SlideMapper._();

  static SlideMapper? _instance;
  static SlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideMapper._());
      SlideOptionsMapper.ensureInitialized();
      SectionDtoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Slide';

  static int _$index(Slide v) => v.index;
  static const Field<Slide, int> _f$index = Field('index', _$index);
  static String _$content(Slide v) => v.content;
  static const Field<Slide, String> _f$content = Field('content', _$content);
  static String _$key(Slide v) => v.key;
  static const Field<Slide, String> _f$key = Field('key', _$key);
  static SlideOptions? _$options(Slide v) => v.options;
  static const Field<Slide, SlideOptions> _f$options =
      Field('options', _$options, opt: true);
  static List<SectionDto> _$sections(Slide v) => v.sections;
  static const Field<Slide, List<SectionDto>> _f$sections =
      Field('sections', _$sections, opt: true, def: const []);

  @override
  final MappableFields<Slide> fields = const {
    #index: _f$index,
    #content: _f$content,
    #key: _f$key,
    #options: _f$options,
    #sections: _f$sections,
  };
  @override
  final bool ignoreNull = true;

  static Slide _instantiate(DecodingData data) {
    return Slide(
        index: data.dec(_f$index),
        content: data.dec(_f$content),
        key: data.dec(_f$key),
        options: data.dec(_f$options),
        sections: data.dec(_f$sections));
  }

  @override
  final Function instantiate = _instantiate;

  static Slide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Slide>(map);
  }

  static Slide fromJson(String json) {
    return ensureInitialized().decodeJson<Slide>(json);
  }
}

mixin SlideMappable {
  String toJson() {
    return SlideMapper.ensureInitialized().encodeJson<Slide>(this as Slide);
  }

  Map<String, dynamic> toMap() {
    return SlideMapper.ensureInitialized().encodeMap<Slide>(this as Slide);
  }

  SlideCopyWith<Slide, Slide, Slide> get copyWith =>
      _SlideCopyWithImpl(this as Slide, $identity, $identity);
  @override
  String toString() {
    return SlideMapper.ensureInitialized().stringifyValue(this as Slide);
  }

  @override
  bool operator ==(Object other) {
    return SlideMapper.ensureInitialized().equalsValue(this as Slide, other);
  }

  @override
  int get hashCode {
    return SlideMapper.ensureInitialized().hashValue(this as Slide);
  }
}

extension SlideValueCopy<$R, $Out> on ObjectCopyWith<$R, Slide, $Out> {
  SlideCopyWith<$R, Slide, $Out> get $asSlide =>
      $base.as((v, t, t2) => _SlideCopyWithImpl(v, t, t2));
}

abstract class SlideCopyWith<$R, $In extends Slide, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SlideOptionsCopyWith<$R, SlideOptions, SlideOptions>? get options;
  ListCopyWith<$R, SectionDto, SectionDtoCopyWith<$R, SectionDto, SectionDto>>
      get sections;
  $R call(
      {int? index,
      String? content,
      String? key,
      SlideOptions? options,
      List<SectionDto>? sections});
  SlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Slide, $Out>
    implements SlideCopyWith<$R, Slide, $Out> {
  _SlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Slide> $mapper = SlideMapper.ensureInitialized();
  @override
  SlideOptionsCopyWith<$R, SlideOptions, SlideOptions>? get options =>
      $value.options?.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<$R, SectionDto, SectionDtoCopyWith<$R, SectionDto, SectionDto>>
      get sections => ListCopyWith($value.sections,
          (v, t) => v.copyWith.$chain(t), (v) => call(sections: v));
  @override
  $R call(
          {int? index,
          String? content,
          String? key,
          Object? options = $none,
          List<SectionDto>? sections}) =>
      $apply(FieldCopyWithData({
        if (index != null) #index: index,
        if (content != null) #content: content,
        if (key != null) #key: key,
        if (options != $none) #options: options,
        if (sections != null) #sections: sections
      }));
  @override
  Slide $make(CopyWithData data) => Slide(
      index: data.get(#index, or: $value.index),
      content: data.get(#content, or: $value.content),
      key: data.get(#key, or: $value.key),
      options: data.get(#options, or: $value.options),
      sections: data.get(#sections, or: $value.sections));

  @override
  SlideCopyWith<$R2, Slide, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SlideCopyWithImpl($value, $cast, t);
}

class SectionDtoMapper extends ClassMapperBase<SectionDto> {
  SectionDtoMapper._();

  static SectionDtoMapper? _instance;
  static SectionDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SectionDtoMapper._());
      RootLayoutPartMapper.ensureInitialized();
      HeaderLayoutPartMapper.ensureInitialized();
      BodyLayoutPartMapper.ensureInitialized();
      FooterLayoutPartMapper.ensureInitialized();
      SectionTypeMapper.ensureInitialized();
      ContentOptionsMapper.ensureInitialized();
      ContentSectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SectionDto';

  static SectionType _$type(SectionDto v) => v.type;
  static const Field<SectionDto, SectionType> _f$type = Field('type', _$type);
  static ContentOptions _$options(SectionDto v) => v.options;
  static const Field<SectionDto, ContentOptions> _f$options =
      Field('options', _$options);
  static List<ContentSectionPart<ContentOptions>> _$contentSections(
          SectionDto v) =>
      v.contentSections;
  static const Field<SectionDto, List<ContentSectionPart<ContentOptions>>>
      _f$contentSections = Field('contentSections', _$contentSections,
          key: 'content_sections', opt: true, def: const []);

  @override
  final MappableFields<SectionDto> fields = const {
    #type: _f$type,
    #options: _f$options,
    #contentSections: _f$contentSections,
  };
  @override
  final bool ignoreNull = true;

  static SectionDto _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'SectionDto', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static SectionDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SectionDto>(map);
  }

  static SectionDto fromJson(String json) {
    return ensureInitialized().decodeJson<SectionDto>(json);
  }
}

mixin SectionDtoMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SectionDtoCopyWith<SectionDto, SectionDto, SectionDto> get copyWith;
}

abstract class SectionDtoCopyWith<$R, $In extends SectionDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections;
  $R call(
      {ContentOptions? options,
      List<ContentSectionPart<ContentOptions>>? contentSections});
  SectionDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SectionTypeMapper extends EnumMapper<SectionType> {
  SectionTypeMapper._();

  static SectionTypeMapper? _instance;
  static SectionTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SectionTypeMapper._());
    }
    return _instance!;
  }

  static SectionType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SectionType decode(dynamic value) {
    switch (value) {
      case 'root':
        return SectionType.root;
      case 'header':
        return SectionType.header;
      case 'body':
        return SectionType.body;
      case 'footer':
        return SectionType.footer;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SectionType self) {
    switch (self) {
      case SectionType.root:
        return 'root';
      case SectionType.header:
        return 'header';
      case SectionType.body:
        return 'body';
      case SectionType.footer:
        return 'footer';
    }
  }
}

extension SectionTypeMapperExtension on SectionType {
  String toValue() {
    SectionTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SectionType>(this) as String;
  }
}

class ContentSectionPartMapper extends ClassMapperBase<ContentSectionPart> {
  ContentSectionPartMapper._();

  static ContentSectionPartMapper? _instance;
  static ContentSectionPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentSectionPartMapper._());
      ContentPartMapper.ensureInitialized();
      WidgetPartMapper.ensureInitialized();
      ImagePartMapper.ensureInitialized();
      SubSectionTypeMapper.ensureInitialized();
      ContentOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContentSectionPart';
  @override
  Function get typeFactory =>
      <T extends ContentOptions>(f) => f<ContentSectionPart<T>>();

  static SubSectionType _$type(ContentSectionPart v) => v.type;
  static const Field<ContentSectionPart, SubSectionType> _f$type =
      Field('type', _$type);
  static String _$content(ContentSectionPart v) => v.content;
  static const Field<ContentSectionPart, String> _f$content =
      Field('content', _$content);
  static ContentOptions _$options(ContentSectionPart v) => v.options;
  static dynamic _arg$options<T extends ContentOptions>(f) => f<T>();
  static const Field<ContentSectionPart, ContentOptions> _f$options =
      Field('options', _$options, arg: _arg$options);

  @override
  final MappableFields<ContentSectionPart> fields = const {
    #type: _f$type,
    #content: _f$content,
    #options: _f$options,
  };
  @override
  final bool ignoreNull = true;

  static ContentSectionPart<T> _instantiate<T extends ContentOptions>(
      DecodingData data) {
    throw MapperException.missingSubclass(
        'ContentSectionPart', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static ContentSectionPart<T> fromMap<T extends ContentOptions>(
      Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContentSectionPart<T>>(map);
  }

  static ContentSectionPart<T> fromJson<T extends ContentOptions>(String json) {
    return ensureInitialized().decodeJson<ContentSectionPart<T>>(json);
  }
}

mixin ContentSectionPartMappable<T extends ContentOptions> {
  String toJson();
  Map<String, dynamic> toMap();
  ContentSectionPartCopyWith<ContentSectionPart<T>, ContentSectionPart<T>,
      ContentSectionPart<T>, T> get copyWith;
}

abstract class ContentSectionPartCopyWith<$R, $In extends ContentSectionPart<T>,
    $Out, T extends ContentOptions> implements ClassCopyWith<$R, $In, $Out> {
  ContentOptionsCopyWith<$R, ContentOptions, T> get options;
  $R call({String? content, T? options});
  ContentSectionPartCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class SubSectionTypeMapper extends EnumMapper<SubSectionType> {
  SubSectionTypeMapper._();

  static SubSectionTypeMapper? _instance;
  static SubSectionTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SubSectionTypeMapper._());
    }
    return _instance!;
  }

  static SubSectionType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SubSectionType decode(dynamic value) {
    switch (value) {
      case 'content':
        return SubSectionType.content;
      case 'image':
        return SubSectionType.image;
      case 'widget':
        return SubSectionType.widget;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SubSectionType self) {
    switch (self) {
      case SubSectionType.content:
        return 'content';
      case SubSectionType.image:
        return 'image';
      case SubSectionType.widget:
        return 'widget';
    }
  }
}

extension SubSectionTypeMapperExtension on SubSectionType {
  String toValue() {
    SubSectionTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SubSectionType>(this) as String;
  }
}

class SectionDataMapper extends RecordMapperBase<SectionData> {
  static SectionDataMapper? _instance;
  SectionDataMapper._();

  static SectionDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SectionDataMapper._());
      MapperBase.addType(<A, B>(f) => f<({A content, B options})>());
    }
    return _instance!;
  }

  static String _$content(SectionData v) => v.content;
  static const Field<SectionData, String> _f$content =
      Field('content', _$content);
  static ContentOptions? _$options(SectionData v) => v.options;
  static const Field<SectionData, ContentOptions> _f$options =
      Field('options', _$options);

  @override
  final MappableFields<SectionData> fields = const {
    #content: _f$content,
    #options: _f$options,
  };

  @override
  Function get typeFactory => (f) => f<SectionData>();

  @override
  List<Type> apply(MappingContext context) {
    return [];
  }

  static SectionData _instantiate(DecodingData<SectionData> data) {
    return (content: data.dec(_f$content), options: data.dec(_f$options));
  }

  @override
  final Function instantiate = _instantiate;

  static SectionData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SectionData>(map);
  }

  static SectionData fromJson(String json) {
    return ensureInitialized().decodeJson<SectionData>(json);
  }
}

extension SectionDataMappable on SectionData {
  Map<String, dynamic> toMap() {
    return SectionDataMapper.ensureInitialized().encodeMap(this);
  }

  String toJson() {
    return SectionDataMapper.ensureInitialized().encodeJson(this);
  }

  SectionDataCopyWith<SectionData> get copyWith =>
      _SectionDataCopyWithImpl(this, $identity, $identity);
}

extension SectionDataValueCopy<$R>
    on ObjectCopyWith<$R, SectionData, SectionData> {
  SectionDataCopyWith<$R> get $asSectionData =>
      $base.as((v, t, t2) => _SectionDataCopyWithImpl(v, t, t2));
}

abstract class SectionDataCopyWith<$R>
    implements RecordCopyWith<$R, SectionData> {
  $R call({String? content, ContentOptions? options});
  SectionDataCopyWith<$R2> $chain<$R2>(Then<SectionData, $R2> t);
}

class _SectionDataCopyWithImpl<$R> extends RecordCopyWithBase<$R, SectionData>
    implements SectionDataCopyWith<$R> {
  _SectionDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final RecordMapperBase<SectionData> $mapper =
      SectionDataMapper.ensureInitialized();
  @override
  $R call({String? content, Object? options = $none}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (options != $none) #options: options
      }));
  @override
  SectionData $make(CopyWithData data) => (
        content: data.get(#content, or: $value.content),
        options: data.get(#options, or: $value.options)
      );

  @override
  SectionDataCopyWith<$R2> $chain<$R2>(Then<SectionData, $R2> t) =>
      _SectionDataCopyWithImpl($value, $cast, t);
}

class ContentPartMapper extends SubClassMapperBase<ContentPart> {
  ContentPartMapper._();

  static ContentPartMapper? _instance;
  static ContentPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentPartMapper._());
      ContentSectionPartMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContentPart';

  static String _$content(ContentPart v) => v.content;
  static const Field<ContentPart, String> _f$content =
      Field('content', _$content);
  static ContentOptions _$options(ContentPart v) => v.options;
  static const Field<ContentPart, ContentOptions> _f$options =
      Field('options', _$options);
  static SubSectionType _$type(ContentPart v) => v.type;
  static const Field<ContentPart, SubSectionType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<ContentPart> fields = const {
    #content: _f$content,
    #options: _f$options,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'content';
  @override
  late final ClassMapperBase superMapper =
      ContentSectionPartMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static ContentPart _instantiate(DecodingData data) {
    return ContentPart(
        content: data.dec(_f$content), options: data.dec(_f$options));
  }

  @override
  final Function instantiate = _instantiate;

  static ContentPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContentPart>(map);
  }

  static ContentPart fromJson(String json) {
    return ensureInitialized().decodeJson<ContentPart>(json);
  }
}

mixin ContentPartMappable {
  String toJson() {
    return ContentPartMapper.ensureInitialized()
        .encodeJson<ContentPart>(this as ContentPart);
  }

  Map<String, dynamic> toMap() {
    return ContentPartMapper.ensureInitialized()
        .encodeMap<ContentPart>(this as ContentPart);
  }

  ContentPartCopyWith<ContentPart, ContentPart, ContentPart> get copyWith =>
      _ContentPartCopyWithImpl(this as ContentPart, $identity, $identity);
  @override
  String toString() {
    return ContentPartMapper.ensureInitialized()
        .stringifyValue(this as ContentPart);
  }

  @override
  bool operator ==(Object other) {
    return ContentPartMapper.ensureInitialized()
        .equalsValue(this as ContentPart, other);
  }

  @override
  int get hashCode {
    return ContentPartMapper.ensureInitialized().hashValue(this as ContentPart);
  }
}

extension ContentPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContentPart, $Out> {
  ContentPartCopyWith<$R, ContentPart, $Out> get $asContentPart =>
      $base.as((v, t, t2) => _ContentPartCopyWithImpl(v, t, t2));
}

abstract class ContentPartCopyWith<$R, $In extends ContentPart, $Out>
    implements ContentSectionPartCopyWith<$R, $In, $Out, ContentOptions> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  @override
  $R call({String? content, ContentOptions? options});
  ContentPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ContentPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContentPart, $Out>
    implements ContentPartCopyWith<$R, ContentPart, $Out> {
  _ContentPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContentPart> $mapper =
      ContentPartMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options =>
      ($value.options as ContentOptions)
          .copyWith
          .$chain((v) => call(options: v));
  @override
  $R call({String? content, ContentOptions? options}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (options != null) #options: options
      }));
  @override
  ContentPart $make(CopyWithData data) => ContentPart(
      content: data.get(#content, or: $value.content),
      options: data.get(#options, or: $value.options));

  @override
  ContentPartCopyWith<$R2, ContentPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ContentPartCopyWithImpl($value, $cast, t);
}

class WidgetPartMapper extends SubClassMapperBase<WidgetPart> {
  WidgetPartMapper._();

  static WidgetPartMapper? _instance;
  static WidgetPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetPartMapper._());
      ContentSectionPartMapper.ensureInitialized().addSubMapper(_instance!);
      WidgetOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WidgetPart';

  static WidgetOptions _$options(WidgetPart v) => v.options;
  static const Field<WidgetPart, WidgetOptions> _f$options =
      Field('options', _$options);
  static String _$content(WidgetPart v) => v.content;
  static const Field<WidgetPart, String> _f$content =
      Field('content', _$content);
  static SubSectionType _$type(WidgetPart v) => v.type;
  static const Field<WidgetPart, SubSectionType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<WidgetPart> fields = const {
    #options: _f$options,
    #content: _f$content,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'widget';
  @override
  late final ClassMapperBase superMapper =
      ContentSectionPartMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static WidgetPart _instantiate(DecodingData data) {
    return WidgetPart(
        options: data.dec(_f$options), content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static WidgetPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WidgetPart>(map);
  }

  static WidgetPart fromJson(String json) {
    return ensureInitialized().decodeJson<WidgetPart>(json);
  }
}

mixin WidgetPartMappable {
  String toJson() {
    return WidgetPartMapper.ensureInitialized()
        .encodeJson<WidgetPart>(this as WidgetPart);
  }

  Map<String, dynamic> toMap() {
    return WidgetPartMapper.ensureInitialized()
        .encodeMap<WidgetPart>(this as WidgetPart);
  }

  WidgetPartCopyWith<WidgetPart, WidgetPart, WidgetPart> get copyWith =>
      _WidgetPartCopyWithImpl(this as WidgetPart, $identity, $identity);
  @override
  String toString() {
    return WidgetPartMapper.ensureInitialized()
        .stringifyValue(this as WidgetPart);
  }

  @override
  bool operator ==(Object other) {
    return WidgetPartMapper.ensureInitialized()
        .equalsValue(this as WidgetPart, other);
  }

  @override
  int get hashCode {
    return WidgetPartMapper.ensureInitialized().hashValue(this as WidgetPart);
  }
}

extension WidgetPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WidgetPart, $Out> {
  WidgetPartCopyWith<$R, WidgetPart, $Out> get $asWidgetPart =>
      $base.as((v, t, t2) => _WidgetPartCopyWithImpl(v, t, t2));
}

abstract class WidgetPartCopyWith<$R, $In extends WidgetPart, $Out>
    implements ContentSectionPartCopyWith<$R, $In, $Out, WidgetOptions> {
  @override
  WidgetOptionsCopyWith<$R, WidgetOptions, WidgetOptions> get options;
  @override
  $R call({WidgetOptions? options, String? content});
  WidgetPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WidgetPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WidgetPart, $Out>
    implements WidgetPartCopyWith<$R, WidgetPart, $Out> {
  _WidgetPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WidgetPart> $mapper =
      WidgetPartMapper.ensureInitialized();
  @override
  WidgetOptionsCopyWith<$R, WidgetOptions, WidgetOptions> get options =>
      ($value.options as WidgetOptions)
          .copyWith
          .$chain((v) => call(options: v));
  @override
  $R call({WidgetOptions? options, String? content}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (content != null) #content: content
      }));
  @override
  WidgetPart $make(CopyWithData data) => WidgetPart(
      options: data.get(#options, or: $value.options),
      content: data.get(#content, or: $value.content));

  @override
  WidgetPartCopyWith<$R2, WidgetPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WidgetPartCopyWithImpl($value, $cast, t);
}

class ImagePartMapper extends SubClassMapperBase<ImagePart> {
  ImagePartMapper._();

  static ImagePartMapper? _instance;
  static ImagePartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImagePartMapper._());
      ContentSectionPartMapper.ensureInitialized().addSubMapper(_instance!);
      ImageOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImagePart';

  static ImageOptions _$options(ImagePart v) => v.options;
  static const Field<ImagePart, ImageOptions> _f$options =
      Field('options', _$options);
  static String _$content(ImagePart v) => v.content;
  static const Field<ImagePart, String> _f$content =
      Field('content', _$content);
  static SubSectionType _$type(ImagePart v) => v.type;
  static const Field<ImagePart, SubSectionType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<ImagePart> fields = const {
    #options: _f$options,
    #content: _f$content,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'image';
  @override
  late final ClassMapperBase superMapper =
      ContentSectionPartMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static ImagePart _instantiate(DecodingData data) {
    return ImagePart(
        options: data.dec(_f$options), content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static ImagePart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImagePart>(map);
  }

  static ImagePart fromJson(String json) {
    return ensureInitialized().decodeJson<ImagePart>(json);
  }
}

mixin ImagePartMappable {
  String toJson() {
    return ImagePartMapper.ensureInitialized()
        .encodeJson<ImagePart>(this as ImagePart);
  }

  Map<String, dynamic> toMap() {
    return ImagePartMapper.ensureInitialized()
        .encodeMap<ImagePart>(this as ImagePart);
  }

  ImagePartCopyWith<ImagePart, ImagePart, ImagePart> get copyWith =>
      _ImagePartCopyWithImpl(this as ImagePart, $identity, $identity);
  @override
  String toString() {
    return ImagePartMapper.ensureInitialized()
        .stringifyValue(this as ImagePart);
  }

  @override
  bool operator ==(Object other) {
    return ImagePartMapper.ensureInitialized()
        .equalsValue(this as ImagePart, other);
  }

  @override
  int get hashCode {
    return ImagePartMapper.ensureInitialized().hashValue(this as ImagePart);
  }
}

extension ImagePartValueCopy<$R, $Out> on ObjectCopyWith<$R, ImagePart, $Out> {
  ImagePartCopyWith<$R, ImagePart, $Out> get $asImagePart =>
      $base.as((v, t, t2) => _ImagePartCopyWithImpl(v, t, t2));
}

abstract class ImagePartCopyWith<$R, $In extends ImagePart, $Out>
    implements ContentSectionPartCopyWith<$R, $In, $Out, ImageOptions> {
  @override
  ImageOptionsCopyWith<$R, ImageOptions, ImageOptions> get options;
  @override
  $R call({ImageOptions? options, String? content});
  ImagePartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImagePartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImagePart, $Out>
    implements ImagePartCopyWith<$R, ImagePart, $Out> {
  _ImagePartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImagePart> $mapper =
      ImagePartMapper.ensureInitialized();
  @override
  ImageOptionsCopyWith<$R, ImageOptions, ImageOptions> get options =>
      ($value.options as ImageOptions).copyWith.$chain((v) => call(options: v));
  @override
  $R call({ImageOptions? options, String? content}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (content != null) #content: content
      }));
  @override
  ImagePart $make(CopyWithData data) => ImagePart(
      options: data.get(#options, or: $value.options),
      content: data.get(#content, or: $value.content));

  @override
  ImagePartCopyWith<$R2, ImagePart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImagePartCopyWithImpl($value, $cast, t);
}

class RootLayoutPartMapper extends SubClassMapperBase<RootLayoutPart> {
  RootLayoutPartMapper._();

  static RootLayoutPartMapper? _instance;
  static RootLayoutPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RootLayoutPartMapper._());
      SectionDtoMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      ContentSectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RootLayoutPart';

  static ContentOptions _$options(RootLayoutPart v) => v.options;
  static const Field<RootLayoutPart, ContentOptions> _f$options =
      Field('options', _$options);
  static List<ContentSectionPart<ContentOptions>> _$contentSections(
          RootLayoutPart v) =>
      v.contentSections;
  static const Field<RootLayoutPart, List<ContentSectionPart<ContentOptions>>>
      _f$contentSections = Field('contentSections', _$contentSections,
          key: 'content_sections', opt: true, def: const []);
  static SectionType _$type(RootLayoutPart v) => v.type;
  static const Field<RootLayoutPart, SectionType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<RootLayoutPart> fields = const {
    #options: _f$options,
    #contentSections: _f$contentSections,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'root';
  @override
  late final ClassMapperBase superMapper = SectionDtoMapper.ensureInitialized();

  static RootLayoutPart _instantiate(DecodingData data) {
    return RootLayoutPart(
        options: data.dec(_f$options),
        contentSections: data.dec(_f$contentSections));
  }

  @override
  final Function instantiate = _instantiate;

  static RootLayoutPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RootLayoutPart>(map);
  }

  static RootLayoutPart fromJson(String json) {
    return ensureInitialized().decodeJson<RootLayoutPart>(json);
  }
}

mixin RootLayoutPartMappable {
  String toJson() {
    return RootLayoutPartMapper.ensureInitialized()
        .encodeJson<RootLayoutPart>(this as RootLayoutPart);
  }

  Map<String, dynamic> toMap() {
    return RootLayoutPartMapper.ensureInitialized()
        .encodeMap<RootLayoutPart>(this as RootLayoutPart);
  }

  RootLayoutPartCopyWith<RootLayoutPart, RootLayoutPart, RootLayoutPart>
      get copyWith => _RootLayoutPartCopyWithImpl(
          this as RootLayoutPart, $identity, $identity);
  @override
  String toString() {
    return RootLayoutPartMapper.ensureInitialized()
        .stringifyValue(this as RootLayoutPart);
  }

  @override
  bool operator ==(Object other) {
    return RootLayoutPartMapper.ensureInitialized()
        .equalsValue(this as RootLayoutPart, other);
  }

  @override
  int get hashCode {
    return RootLayoutPartMapper.ensureInitialized()
        .hashValue(this as RootLayoutPart);
  }
}

extension RootLayoutPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RootLayoutPart, $Out> {
  RootLayoutPartCopyWith<$R, RootLayoutPart, $Out> get $asRootLayoutPart =>
      $base.as((v, t, t2) => _RootLayoutPartCopyWithImpl(v, t, t2));
}

abstract class RootLayoutPartCopyWith<$R, $In extends RootLayoutPart, $Out>
    implements SectionDtoCopyWith<$R, $In, $Out> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections;
  @override
  $R call(
      {ContentOptions? options,
      List<ContentSectionPart<ContentOptions>>? contentSections});
  RootLayoutPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RootLayoutPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RootLayoutPart, $Out>
    implements RootLayoutPartCopyWith<$R, RootLayoutPart, $Out> {
  _RootLayoutPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RootLayoutPart> $mapper =
      RootLayoutPartMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options =>
      $value.options.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections => ListCopyWith(
      $value.contentSections,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(contentSections: v));
  @override
  $R call(
          {ContentOptions? options,
          List<ContentSectionPart<ContentOptions>>? contentSections}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (contentSections != null) #contentSections: contentSections
      }));
  @override
  RootLayoutPart $make(CopyWithData data) => RootLayoutPart(
      options: data.get(#options, or: $value.options),
      contentSections: data.get(#contentSections, or: $value.contentSections));

  @override
  RootLayoutPartCopyWith<$R2, RootLayoutPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RootLayoutPartCopyWithImpl($value, $cast, t);
}

class HeaderLayoutPartMapper extends SubClassMapperBase<HeaderLayoutPart> {
  HeaderLayoutPartMapper._();

  static HeaderLayoutPartMapper? _instance;
  static HeaderLayoutPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HeaderLayoutPartMapper._());
      SectionDtoMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      ContentSectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HeaderLayoutPart';

  static ContentOptions _$options(HeaderLayoutPart v) => v.options;
  static const Field<HeaderLayoutPart, ContentOptions> _f$options =
      Field('options', _$options);
  static List<ContentSectionPart<ContentOptions>> _$contentSections(
          HeaderLayoutPart v) =>
      v.contentSections;
  static const Field<HeaderLayoutPart, List<ContentSectionPart<ContentOptions>>>
      _f$contentSections = Field('contentSections', _$contentSections,
          key: 'content_sections', opt: true, def: const []);
  static SectionType _$type(HeaderLayoutPart v) => v.type;
  static const Field<HeaderLayoutPart, SectionType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<HeaderLayoutPart> fields = const {
    #options: _f$options,
    #contentSections: _f$contentSections,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'header';
  @override
  late final ClassMapperBase superMapper = SectionDtoMapper.ensureInitialized();

  static HeaderLayoutPart _instantiate(DecodingData data) {
    return HeaderLayoutPart(
        options: data.dec(_f$options),
        contentSections: data.dec(_f$contentSections));
  }

  @override
  final Function instantiate = _instantiate;

  static HeaderLayoutPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HeaderLayoutPart>(map);
  }

  static HeaderLayoutPart fromJson(String json) {
    return ensureInitialized().decodeJson<HeaderLayoutPart>(json);
  }
}

mixin HeaderLayoutPartMappable {
  String toJson() {
    return HeaderLayoutPartMapper.ensureInitialized()
        .encodeJson<HeaderLayoutPart>(this as HeaderLayoutPart);
  }

  Map<String, dynamic> toMap() {
    return HeaderLayoutPartMapper.ensureInitialized()
        .encodeMap<HeaderLayoutPart>(this as HeaderLayoutPart);
  }

  HeaderLayoutPartCopyWith<HeaderLayoutPart, HeaderLayoutPart, HeaderLayoutPart>
      get copyWith => _HeaderLayoutPartCopyWithImpl(
          this as HeaderLayoutPart, $identity, $identity);
  @override
  String toString() {
    return HeaderLayoutPartMapper.ensureInitialized()
        .stringifyValue(this as HeaderLayoutPart);
  }

  @override
  bool operator ==(Object other) {
    return HeaderLayoutPartMapper.ensureInitialized()
        .equalsValue(this as HeaderLayoutPart, other);
  }

  @override
  int get hashCode {
    return HeaderLayoutPartMapper.ensureInitialized()
        .hashValue(this as HeaderLayoutPart);
  }
}

extension HeaderLayoutPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HeaderLayoutPart, $Out> {
  HeaderLayoutPartCopyWith<$R, HeaderLayoutPart, $Out>
      get $asHeaderLayoutPart =>
          $base.as((v, t, t2) => _HeaderLayoutPartCopyWithImpl(v, t, t2));
}

abstract class HeaderLayoutPartCopyWith<$R, $In extends HeaderLayoutPart, $Out>
    implements SectionDtoCopyWith<$R, $In, $Out> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections;
  @override
  $R call(
      {ContentOptions? options,
      List<ContentSectionPart<ContentOptions>>? contentSections});
  HeaderLayoutPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _HeaderLayoutPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HeaderLayoutPart, $Out>
    implements HeaderLayoutPartCopyWith<$R, HeaderLayoutPart, $Out> {
  _HeaderLayoutPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HeaderLayoutPart> $mapper =
      HeaderLayoutPartMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options =>
      $value.options.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections => ListCopyWith(
      $value.contentSections,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(contentSections: v));
  @override
  $R call(
          {ContentOptions? options,
          List<ContentSectionPart<ContentOptions>>? contentSections}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (contentSections != null) #contentSections: contentSections
      }));
  @override
  HeaderLayoutPart $make(CopyWithData data) => HeaderLayoutPart(
      options: data.get(#options, or: $value.options),
      contentSections: data.get(#contentSections, or: $value.contentSections));

  @override
  HeaderLayoutPartCopyWith<$R2, HeaderLayoutPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HeaderLayoutPartCopyWithImpl($value, $cast, t);
}

class BodyLayoutPartMapper extends SubClassMapperBase<BodyLayoutPart> {
  BodyLayoutPartMapper._();

  static BodyLayoutPartMapper? _instance;
  static BodyLayoutPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BodyLayoutPartMapper._());
      SectionDtoMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      ContentSectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BodyLayoutPart';

  static ContentOptions _$options(BodyLayoutPart v) => v.options;
  static const Field<BodyLayoutPart, ContentOptions> _f$options =
      Field('options', _$options);
  static List<ContentSectionPart<ContentOptions>> _$contentSections(
          BodyLayoutPart v) =>
      v.contentSections;
  static const Field<BodyLayoutPart, List<ContentSectionPart<ContentOptions>>>
      _f$contentSections = Field('contentSections', _$contentSections,
          key: 'content_sections', opt: true, def: const []);
  static SectionType _$type(BodyLayoutPart v) => v.type;
  static const Field<BodyLayoutPart, SectionType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<BodyLayoutPart> fields = const {
    #options: _f$options,
    #contentSections: _f$contentSections,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'body';
  @override
  late final ClassMapperBase superMapper = SectionDtoMapper.ensureInitialized();

  static BodyLayoutPart _instantiate(DecodingData data) {
    return BodyLayoutPart(
        options: data.dec(_f$options),
        contentSections: data.dec(_f$contentSections));
  }

  @override
  final Function instantiate = _instantiate;

  static BodyLayoutPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BodyLayoutPart>(map);
  }

  static BodyLayoutPart fromJson(String json) {
    return ensureInitialized().decodeJson<BodyLayoutPart>(json);
  }
}

mixin BodyLayoutPartMappable {
  String toJson() {
    return BodyLayoutPartMapper.ensureInitialized()
        .encodeJson<BodyLayoutPart>(this as BodyLayoutPart);
  }

  Map<String, dynamic> toMap() {
    return BodyLayoutPartMapper.ensureInitialized()
        .encodeMap<BodyLayoutPart>(this as BodyLayoutPart);
  }

  BodyLayoutPartCopyWith<BodyLayoutPart, BodyLayoutPart, BodyLayoutPart>
      get copyWith => _BodyLayoutPartCopyWithImpl(
          this as BodyLayoutPart, $identity, $identity);
  @override
  String toString() {
    return BodyLayoutPartMapper.ensureInitialized()
        .stringifyValue(this as BodyLayoutPart);
  }

  @override
  bool operator ==(Object other) {
    return BodyLayoutPartMapper.ensureInitialized()
        .equalsValue(this as BodyLayoutPart, other);
  }

  @override
  int get hashCode {
    return BodyLayoutPartMapper.ensureInitialized()
        .hashValue(this as BodyLayoutPart);
  }
}

extension BodyLayoutPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BodyLayoutPart, $Out> {
  BodyLayoutPartCopyWith<$R, BodyLayoutPart, $Out> get $asBodyLayoutPart =>
      $base.as((v, t, t2) => _BodyLayoutPartCopyWithImpl(v, t, t2));
}

abstract class BodyLayoutPartCopyWith<$R, $In extends BodyLayoutPart, $Out>
    implements SectionDtoCopyWith<$R, $In, $Out> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections;
  @override
  $R call(
      {ContentOptions? options,
      List<ContentSectionPart<ContentOptions>>? contentSections});
  BodyLayoutPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BodyLayoutPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BodyLayoutPart, $Out>
    implements BodyLayoutPartCopyWith<$R, BodyLayoutPart, $Out> {
  _BodyLayoutPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BodyLayoutPart> $mapper =
      BodyLayoutPartMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options =>
      $value.options.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections => ListCopyWith(
      $value.contentSections,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(contentSections: v));
  @override
  $R call(
          {ContentOptions? options,
          List<ContentSectionPart<ContentOptions>>? contentSections}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (contentSections != null) #contentSections: contentSections
      }));
  @override
  BodyLayoutPart $make(CopyWithData data) => BodyLayoutPart(
      options: data.get(#options, or: $value.options),
      contentSections: data.get(#contentSections, or: $value.contentSections));

  @override
  BodyLayoutPartCopyWith<$R2, BodyLayoutPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BodyLayoutPartCopyWithImpl($value, $cast, t);
}

class FooterLayoutPartMapper extends SubClassMapperBase<FooterLayoutPart> {
  FooterLayoutPartMapper._();

  static FooterLayoutPartMapper? _instance;
  static FooterLayoutPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FooterLayoutPartMapper._());
      SectionDtoMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      ContentSectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FooterLayoutPart';

  static ContentOptions _$options(FooterLayoutPart v) => v.options;
  static const Field<FooterLayoutPart, ContentOptions> _f$options =
      Field('options', _$options);
  static List<ContentSectionPart<ContentOptions>> _$contentSections(
          FooterLayoutPart v) =>
      v.contentSections;
  static const Field<FooterLayoutPart, List<ContentSectionPart<ContentOptions>>>
      _f$contentSections = Field('contentSections', _$contentSections,
          key: 'content_sections', opt: true, def: const []);
  static SectionType _$type(FooterLayoutPart v) => v.type;
  static const Field<FooterLayoutPart, SectionType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<FooterLayoutPart> fields = const {
    #options: _f$options,
    #contentSections: _f$contentSections,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'footer';
  @override
  late final ClassMapperBase superMapper = SectionDtoMapper.ensureInitialized();

  static FooterLayoutPart _instantiate(DecodingData data) {
    return FooterLayoutPart(
        options: data.dec(_f$options),
        contentSections: data.dec(_f$contentSections));
  }

  @override
  final Function instantiate = _instantiate;

  static FooterLayoutPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FooterLayoutPart>(map);
  }

  static FooterLayoutPart fromJson(String json) {
    return ensureInitialized().decodeJson<FooterLayoutPart>(json);
  }
}

mixin FooterLayoutPartMappable {
  String toJson() {
    return FooterLayoutPartMapper.ensureInitialized()
        .encodeJson<FooterLayoutPart>(this as FooterLayoutPart);
  }

  Map<String, dynamic> toMap() {
    return FooterLayoutPartMapper.ensureInitialized()
        .encodeMap<FooterLayoutPart>(this as FooterLayoutPart);
  }

  FooterLayoutPartCopyWith<FooterLayoutPart, FooterLayoutPart, FooterLayoutPart>
      get copyWith => _FooterLayoutPartCopyWithImpl(
          this as FooterLayoutPart, $identity, $identity);
  @override
  String toString() {
    return FooterLayoutPartMapper.ensureInitialized()
        .stringifyValue(this as FooterLayoutPart);
  }

  @override
  bool operator ==(Object other) {
    return FooterLayoutPartMapper.ensureInitialized()
        .equalsValue(this as FooterLayoutPart, other);
  }

  @override
  int get hashCode {
    return FooterLayoutPartMapper.ensureInitialized()
        .hashValue(this as FooterLayoutPart);
  }
}

extension FooterLayoutPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FooterLayoutPart, $Out> {
  FooterLayoutPartCopyWith<$R, FooterLayoutPart, $Out>
      get $asFooterLayoutPart =>
          $base.as((v, t, t2) => _FooterLayoutPartCopyWithImpl(v, t, t2));
}

abstract class FooterLayoutPartCopyWith<$R, $In extends FooterLayoutPart, $Out>
    implements SectionDtoCopyWith<$R, $In, $Out> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections;
  @override
  $R call(
      {ContentOptions? options,
      List<ContentSectionPart<ContentOptions>>? contentSections});
  FooterLayoutPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FooterLayoutPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FooterLayoutPart, $Out>
    implements FooterLayoutPartCopyWith<$R, FooterLayoutPart, $Out> {
  _FooterLayoutPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FooterLayoutPart> $mapper =
      FooterLayoutPartMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options =>
      $value.options.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections => ListCopyWith(
      $value.contentSections,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(contentSections: v));
  @override
  $R call(
          {ContentOptions? options,
          List<ContentSectionPart<ContentOptions>>? contentSections}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (contentSections != null) #contentSections: contentSections
      }));
  @override
  FooterLayoutPart $make(CopyWithData data) => FooterLayoutPart(
      options: data.get(#options, or: $value.options),
      contentSections: data.get(#contentSections, or: $value.contentSections));

  @override
  FooterLayoutPartCopyWith<$R2, FooterLayoutPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FooterLayoutPartCopyWithImpl($value, $cast, t);
}
