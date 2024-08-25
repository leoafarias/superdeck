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

class ConfigMapper extends ClassMapperBase<Config> {
  ConfigMapper._();

  static ConfigMapper? _instance;
  static ConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigMapper._());
      SlideOptionsMapper.ensureInitialized();
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
  final dynamic discriminatorValue = 'image';
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
  final dynamic discriminatorValue = 'widget_options';
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

class ReferenceDtoMapper extends ClassMapperBase<ReferenceDto> {
  ReferenceDtoMapper._();

  static ReferenceDtoMapper? _instance;
  static ReferenceDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReferenceDtoMapper._());
      ConfigMapper.ensureInitialized();
      SlideMapper.ensureInitialized();
      SlideAssetMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ReferenceDto';

  static Config _$config(ReferenceDto v) => v.config;
  static const Field<ReferenceDto, Config> _f$config =
      Field('config', _$config);
  static List<Slide> _$slides(ReferenceDto v) => v.slides;
  static const Field<ReferenceDto, List<Slide>> _f$slides =
      Field('slides', _$slides);
  static List<SlideAsset> _$assets(ReferenceDto v) => v.assets;
  static const Field<ReferenceDto, List<SlideAsset>> _f$assets =
      Field('assets', _$assets);

  @override
  final MappableFields<ReferenceDto> fields = const {
    #config: _f$config,
    #slides: _f$slides,
    #assets: _f$assets,
  };
  @override
  final bool ignoreNull = true;

  static ReferenceDto _instantiate(DecodingData data) {
    return ReferenceDto(
        config: data.dec(_f$config),
        slides: data.dec(_f$slides),
        assets: data.dec(_f$assets));
  }

  @override
  final Function instantiate = _instantiate;

  static ReferenceDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReferenceDto>(map);
  }

  static ReferenceDto fromJson(String json) {
    return ensureInitialized().decodeJson<ReferenceDto>(json);
  }
}

mixin ReferenceDtoMappable {
  String toJson() {
    return ReferenceDtoMapper.ensureInitialized()
        .encodeJson<ReferenceDto>(this as ReferenceDto);
  }

  Map<String, dynamic> toMap() {
    return ReferenceDtoMapper.ensureInitialized()
        .encodeMap<ReferenceDto>(this as ReferenceDto);
  }

  ReferenceDtoCopyWith<ReferenceDto, ReferenceDto, ReferenceDto> get copyWith =>
      _ReferenceDtoCopyWithImpl(this as ReferenceDto, $identity, $identity);
  @override
  String toString() {
    return ReferenceDtoMapper.ensureInitialized()
        .stringifyValue(this as ReferenceDto);
  }

  @override
  bool operator ==(Object other) {
    return ReferenceDtoMapper.ensureInitialized()
        .equalsValue(this as ReferenceDto, other);
  }

  @override
  int get hashCode {
    return ReferenceDtoMapper.ensureInitialized()
        .hashValue(this as ReferenceDto);
  }
}

extension ReferenceDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReferenceDto, $Out> {
  ReferenceDtoCopyWith<$R, ReferenceDto, $Out> get $asReferenceDto =>
      $base.as((v, t, t2) => _ReferenceDtoCopyWithImpl(v, t, t2));
}

abstract class ReferenceDtoCopyWith<$R, $In extends ReferenceDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ConfigCopyWith<$R, Config, Config> get config;
  ListCopyWith<$R, Slide, SlideCopyWith<$R, Slide, Slide>> get slides;
  ListCopyWith<$R, SlideAsset, SlideAssetCopyWith<$R, SlideAsset, SlideAsset>>
      get assets;
  $R call({Config? config, List<Slide>? slides, List<SlideAsset>? assets});
  ReferenceDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReferenceDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReferenceDto, $Out>
    implements ReferenceDtoCopyWith<$R, ReferenceDto, $Out> {
  _ReferenceDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReferenceDto> $mapper =
      ReferenceDtoMapper.ensureInitialized();
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
  ReferenceDto $make(CopyWithData data) => ReferenceDto(
      config: data.get(#config, or: $value.config),
      slides: data.get(#slides, or: $value.slides),
      assets: data.get(#assets, or: $value.assets));

  @override
  ReferenceDtoCopyWith<$R2, ReferenceDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ReferenceDtoCopyWithImpl($value, $cast, t);
}

class SlideMapper extends ClassMapperBase<Slide> {
  SlideMapper._();

  static SlideMapper? _instance;
  static SlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideMapper._());
      SlideOptionsMapper.ensureInitialized();
      SectionBlockDtoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Slide';

  static int _$index(Slide v) => v.index;
  static const Field<Slide, int> _f$index = Field('index', _$index);
  static String _$key(Slide v) => v.key;
  static const Field<Slide, String> _f$key = Field('key', _$key);
  static SlideOptions? _$options(Slide v) => v.options;
  static const Field<Slide, SlideOptions> _f$options =
      Field('options', _$options, opt: true);
  static String _$content(Slide v) => v.content;
  static const Field<Slide, String> _f$content = Field('content', _$content);
  static List<SectionBlockDto> _$sections(Slide v) => v.sections;
  static const Field<Slide, List<SectionBlockDto>> _f$sections =
      Field('sections', _$sections, opt: true, def: const []);

  @override
  final MappableFields<Slide> fields = const {
    #index: _f$index,
    #key: _f$key,
    #options: _f$options,
    #content: _f$content,
    #sections: _f$sections,
  };
  @override
  final bool ignoreNull = true;

  static Slide _instantiate(DecodingData data) {
    return Slide(
        index: data.dec(_f$index),
        key: data.dec(_f$key),
        options: data.dec(_f$options),
        content: data.dec(_f$content),
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
  ListCopyWith<$R, SectionBlockDto,
          SectionBlockDtoCopyWith<$R, SectionBlockDto, SectionBlockDto>>
      get sections;
  $R call(
      {int? index,
      String? key,
      SlideOptions? options,
      String? content,
      List<SectionBlockDto>? sections});
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
  ListCopyWith<$R, SectionBlockDto,
          SectionBlockDtoCopyWith<$R, SectionBlockDto, SectionBlockDto>>
      get sections => ListCopyWith($value.sections,
          (v, t) => v.copyWith.$chain(t), (v) => call(sections: v));
  @override
  $R call(
          {int? index,
          String? key,
          Object? options = $none,
          String? content,
          List<SectionBlockDto>? sections}) =>
      $apply(FieldCopyWithData({
        if (index != null) #index: index,
        if (key != null) #key: key,
        if (options != $none) #options: options,
        if (content != null) #content: content,
        if (sections != null) #sections: sections
      }));
  @override
  Slide $make(CopyWithData data) => Slide(
      index: data.get(#index, or: $value.index),
      key: data.get(#key, or: $value.key),
      options: data.get(#options, or: $value.options),
      content: data.get(#content, or: $value.content),
      sections: data.get(#sections, or: $value.sections));

  @override
  SlideCopyWith<$R2, Slide, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SlideCopyWithImpl($value, $cast, t);
}

class SectionBlockDtoMapper extends ClassMapperBase<SectionBlockDto> {
  SectionBlockDtoMapper._();

  static SectionBlockDtoMapper? _instance;
  static SectionBlockDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SectionBlockDtoMapper._());
      MapperContainer.globals.useAll([OptionsMapper()]);
      ContentOptionsMapper.ensureInitialized();
      SubSectionBlockDtoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SectionBlockDto';

  static ContentOptions? _$options(SectionBlockDto v) => v.options;
  static const Field<SectionBlockDto, ContentOptions> _f$options =
      Field('options', _$options, opt: true);
  static List<SubSectionBlockDto<ContentOptions>> _$subSections(
          SectionBlockDto v) =>
      v.subSections;
  static const Field<SectionBlockDto, List<SubSectionBlockDto<ContentOptions>>>
      _f$subSections = Field('subSections', _$subSections,
          key: 'sub_sections', opt: true, def: const []);

  @override
  final MappableFields<SectionBlockDto> fields = const {
    #options: _f$options,
    #subSections: _f$subSections,
  };
  @override
  final bool ignoreNull = true;

  static SectionBlockDto _instantiate(DecodingData data) {
    return SectionBlockDto(
        options: data.dec(_f$options), subSections: data.dec(_f$subSections));
  }

  @override
  final Function instantiate = _instantiate;

  static SectionBlockDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SectionBlockDto>(map);
  }

  static SectionBlockDto fromJson(String json) {
    return ensureInitialized().decodeJson<SectionBlockDto>(json);
  }
}

mixin SectionBlockDtoMappable {
  String toJson() {
    return SectionBlockDtoMapper.ensureInitialized()
        .encodeJson<SectionBlockDto>(this as SectionBlockDto);
  }

  Map<String, dynamic> toMap() {
    return SectionBlockDtoMapper.ensureInitialized()
        .encodeMap<SectionBlockDto>(this as SectionBlockDto);
  }

  SectionBlockDtoCopyWith<SectionBlockDto, SectionBlockDto, SectionBlockDto>
      get copyWith => _SectionBlockDtoCopyWithImpl(
          this as SectionBlockDto, $identity, $identity);
  @override
  String toString() {
    return SectionBlockDtoMapper.ensureInitialized()
        .stringifyValue(this as SectionBlockDto);
  }

  @override
  bool operator ==(Object other) {
    return SectionBlockDtoMapper.ensureInitialized()
        .equalsValue(this as SectionBlockDto, other);
  }

  @override
  int get hashCode {
    return SectionBlockDtoMapper.ensureInitialized()
        .hashValue(this as SectionBlockDto);
  }
}

extension SectionBlockDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SectionBlockDto, $Out> {
  SectionBlockDtoCopyWith<$R, SectionBlockDto, $Out> get $asSectionBlockDto =>
      $base.as((v, t, t2) => _SectionBlockDtoCopyWithImpl(v, t, t2));
}

abstract class SectionBlockDtoCopyWith<$R, $In extends SectionBlockDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>? get options;
  ListCopyWith<
      $R,
      SubSectionBlockDto<ContentOptions>,
      SubSectionBlockDtoCopyWith<$R, SubSectionBlockDto<ContentOptions>,
          SubSectionBlockDto<ContentOptions>, ContentOptions>> get subSections;
  $R call(
      {ContentOptions? options,
      List<SubSectionBlockDto<ContentOptions>>? subSections});
  SectionBlockDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SectionBlockDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SectionBlockDto, $Out>
    implements SectionBlockDtoCopyWith<$R, SectionBlockDto, $Out> {
  _SectionBlockDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SectionBlockDto> $mapper =
      SectionBlockDtoMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>? get options =>
      $value.options?.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<
      $R,
      SubSectionBlockDto<ContentOptions>,
      SubSectionBlockDtoCopyWith<
          $R,
          SubSectionBlockDto<ContentOptions>,
          SubSectionBlockDto<ContentOptions>,
          ContentOptions>> get subSections => ListCopyWith($value.subSections,
      (v, t) => v.copyWith.$chain(t), (v) => call(subSections: v));
  @override
  $R call(
          {Object? options = $none,
          List<SubSectionBlockDto<ContentOptions>>? subSections}) =>
      $apply(FieldCopyWithData({
        if (options != $none) #options: options,
        if (subSections != null) #subSections: subSections
      }));
  @override
  SectionBlockDto $make(CopyWithData data) => SectionBlockDto(
      options: data.get(#options, or: $value.options),
      subSections: data.get(#subSections, or: $value.subSections));

  @override
  SectionBlockDtoCopyWith<$R2, SectionBlockDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SectionBlockDtoCopyWithImpl($value, $cast, t);
}

class SubSectionBlockDtoMapper extends ClassMapperBase<SubSectionBlockDto> {
  SubSectionBlockDtoMapper._();

  static SubSectionBlockDtoMapper? _instance;
  static SubSectionBlockDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SubSectionBlockDtoMapper._());
      MapperContainer.globals.useAll([OptionsMapper()]);
      ColumnBlockDtoMapper.ensureInitialized();
      WidgetBlockDtoMapper.ensureInitialized();
      ImageBlockDtoMapper.ensureInitialized();
      ContentOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SubSectionBlockDto';
  @override
  Function get typeFactory =>
      <T extends ContentOptions>(f) => f<SubSectionBlockDto<T>>();

  static String _$content(SubSectionBlockDto v) => v.content;
  static const Field<SubSectionBlockDto, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final MappableFields<SubSectionBlockDto> fields = const {
    #content: _f$content,
  };
  @override
  final bool ignoreNull = true;

  static SubSectionBlockDto<T> _instantiate<T extends ContentOptions>(
      DecodingData data) {
    throw MapperException.missingSubclass(
        'SubSectionBlockDto', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static SubSectionBlockDto<T> fromMap<T extends ContentOptions>(
      Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SubSectionBlockDto<T>>(map);
  }

  static SubSectionBlockDto<T> fromJson<T extends ContentOptions>(String json) {
    return ensureInitialized().decodeJson<SubSectionBlockDto<T>>(json);
  }
}

mixin SubSectionBlockDtoMappable<T extends ContentOptions> {
  String toJson();
  Map<String, dynamic> toMap();
  SubSectionBlockDtoCopyWith<SubSectionBlockDto<T>, SubSectionBlockDto<T>,
      SubSectionBlockDto<T>, T> get copyWith;
}

abstract class SubSectionBlockDtoCopyWith<$R, $In extends SubSectionBlockDto<T>,
    $Out, T extends ContentOptions> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? content});
  SubSectionBlockDtoCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class BlockTypeMapper extends EnumMapper<BlockType> {
  BlockTypeMapper._();

  static BlockTypeMapper? _instance;
  static BlockTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BlockTypeMapper._());
    }
    return _instance!;
  }

  static BlockType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BlockType decode(dynamic value) {
    switch (value) {
      case 'section':
        return BlockType.section;
      case 'column':
        return BlockType.column;
      case 'image':
        return BlockType.image;
      case 'widget':
        return BlockType.widget;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BlockType self) {
    switch (self) {
      case BlockType.section:
        return 'section';
      case BlockType.column:
        return 'column';
      case BlockType.image:
        return 'image';
      case BlockType.widget:
        return 'widget';
    }
  }
}

extension BlockTypeMapperExtension on BlockType {
  String toValue() {
    BlockTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BlockType>(this) as String;
  }
}

class ColumnBlockDtoMapper extends SubClassMapperBase<ColumnBlockDto> {
  ColumnBlockDtoMapper._();

  static ColumnBlockDtoMapper? _instance;
  static ColumnBlockDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ColumnBlockDtoMapper._());
      SubSectionBlockDtoMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ColumnBlockDto';

  static String _$content(ColumnBlockDto v) => v.content;
  static const Field<ColumnBlockDto, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static ContentOptions? _$options(ColumnBlockDto v) => v.options;
  static const Field<ColumnBlockDto, ContentOptions> _f$options =
      Field('options', _$options, opt: true);

  @override
  final MappableFields<ColumnBlockDto> fields = const {
    #content: _f$content,
    #options: _f$options,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'column';
  @override
  late final ClassMapperBase superMapper =
      SubSectionBlockDtoMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static ColumnBlockDto _instantiate(DecodingData data) {
    return ColumnBlockDto(
        content: data.dec(_f$content), options: data.dec(_f$options));
  }

  @override
  final Function instantiate = _instantiate;

  static ColumnBlockDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ColumnBlockDto>(map);
  }

  static ColumnBlockDto fromJson(String json) {
    return ensureInitialized().decodeJson<ColumnBlockDto>(json);
  }
}

mixin ColumnBlockDtoMappable {
  String toJson() {
    return ColumnBlockDtoMapper.ensureInitialized()
        .encodeJson<ColumnBlockDto>(this as ColumnBlockDto);
  }

  Map<String, dynamic> toMap() {
    return ColumnBlockDtoMapper.ensureInitialized()
        .encodeMap<ColumnBlockDto>(this as ColumnBlockDto);
  }

  ColumnBlockDtoCopyWith<ColumnBlockDto, ColumnBlockDto, ColumnBlockDto>
      get copyWith => _ColumnBlockDtoCopyWithImpl(
          this as ColumnBlockDto, $identity, $identity);
  @override
  String toString() {
    return ColumnBlockDtoMapper.ensureInitialized()
        .stringifyValue(this as ColumnBlockDto);
  }

  @override
  bool operator ==(Object other) {
    return ColumnBlockDtoMapper.ensureInitialized()
        .equalsValue(this as ColumnBlockDto, other);
  }

  @override
  int get hashCode {
    return ColumnBlockDtoMapper.ensureInitialized()
        .hashValue(this as ColumnBlockDto);
  }
}

extension ColumnBlockDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ColumnBlockDto, $Out> {
  ColumnBlockDtoCopyWith<$R, ColumnBlockDto, $Out> get $asColumnBlockDto =>
      $base.as((v, t, t2) => _ColumnBlockDtoCopyWithImpl(v, t, t2));
}

abstract class ColumnBlockDtoCopyWith<$R, $In extends ColumnBlockDto, $Out>
    implements SubSectionBlockDtoCopyWith<$R, $In, $Out, ContentOptions> {
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>? get options;
  @override
  $R call({String? content, ContentOptions? options});
  ColumnBlockDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ColumnBlockDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ColumnBlockDto, $Out>
    implements ColumnBlockDtoCopyWith<$R, ColumnBlockDto, $Out> {
  _ColumnBlockDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ColumnBlockDto> $mapper =
      ColumnBlockDtoMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>? get options =>
      $value.options?.copyWith.$chain((v) => call(options: v));
  @override
  $R call({String? content, Object? options = $none}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (options != $none) #options: options
      }));
  @override
  ColumnBlockDto $make(CopyWithData data) => ColumnBlockDto(
      content: data.get(#content, or: $value.content),
      options: data.get(#options, or: $value.options));

  @override
  ColumnBlockDtoCopyWith<$R2, ColumnBlockDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ColumnBlockDtoCopyWithImpl($value, $cast, t);
}

class WidgetBlockDtoMapper extends SubClassMapperBase<WidgetBlockDto> {
  WidgetBlockDtoMapper._();

  static WidgetBlockDtoMapper? _instance;
  static WidgetBlockDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetBlockDtoMapper._());
      SubSectionBlockDtoMapper.ensureInitialized().addSubMapper(_instance!);
      WidgetOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WidgetBlockDto';

  static WidgetOptions? _$options(WidgetBlockDto v) => v.options;
  static const Field<WidgetBlockDto, WidgetOptions> _f$options =
      Field('options', _$options, opt: true);
  static String _$content(WidgetBlockDto v) => v.content;
  static const Field<WidgetBlockDto, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final MappableFields<WidgetBlockDto> fields = const {
    #options: _f$options,
    #content: _f$content,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'widget';
  @override
  late final ClassMapperBase superMapper =
      SubSectionBlockDtoMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static WidgetBlockDto _instantiate(DecodingData data) {
    return WidgetBlockDto(
        options: data.dec(_f$options), content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static WidgetBlockDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WidgetBlockDto>(map);
  }

  static WidgetBlockDto fromJson(String json) {
    return ensureInitialized().decodeJson<WidgetBlockDto>(json);
  }
}

mixin WidgetBlockDtoMappable {
  String toJson() {
    return WidgetBlockDtoMapper.ensureInitialized()
        .encodeJson<WidgetBlockDto>(this as WidgetBlockDto);
  }

  Map<String, dynamic> toMap() {
    return WidgetBlockDtoMapper.ensureInitialized()
        .encodeMap<WidgetBlockDto>(this as WidgetBlockDto);
  }

  WidgetBlockDtoCopyWith<WidgetBlockDto, WidgetBlockDto, WidgetBlockDto>
      get copyWith => _WidgetBlockDtoCopyWithImpl(
          this as WidgetBlockDto, $identity, $identity);
  @override
  String toString() {
    return WidgetBlockDtoMapper.ensureInitialized()
        .stringifyValue(this as WidgetBlockDto);
  }

  @override
  bool operator ==(Object other) {
    return WidgetBlockDtoMapper.ensureInitialized()
        .equalsValue(this as WidgetBlockDto, other);
  }

  @override
  int get hashCode {
    return WidgetBlockDtoMapper.ensureInitialized()
        .hashValue(this as WidgetBlockDto);
  }
}

extension WidgetBlockDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WidgetBlockDto, $Out> {
  WidgetBlockDtoCopyWith<$R, WidgetBlockDto, $Out> get $asWidgetBlockDto =>
      $base.as((v, t, t2) => _WidgetBlockDtoCopyWithImpl(v, t, t2));
}

abstract class WidgetBlockDtoCopyWith<$R, $In extends WidgetBlockDto, $Out>
    implements SubSectionBlockDtoCopyWith<$R, $In, $Out, WidgetOptions> {
  WidgetOptionsCopyWith<$R, WidgetOptions, WidgetOptions>? get options;
  @override
  $R call({WidgetOptions? options, String? content});
  WidgetBlockDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WidgetBlockDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WidgetBlockDto, $Out>
    implements WidgetBlockDtoCopyWith<$R, WidgetBlockDto, $Out> {
  _WidgetBlockDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WidgetBlockDto> $mapper =
      WidgetBlockDtoMapper.ensureInitialized();
  @override
  WidgetOptionsCopyWith<$R, WidgetOptions, WidgetOptions>? get options =>
      $value.options?.copyWith.$chain((v) => call(options: v));
  @override
  $R call({Object? options = $none, String? content}) =>
      $apply(FieldCopyWithData({
        if (options != $none) #options: options,
        if (content != null) #content: content
      }));
  @override
  WidgetBlockDto $make(CopyWithData data) => WidgetBlockDto(
      options: data.get(#options, or: $value.options),
      content: data.get(#content, or: $value.content));

  @override
  WidgetBlockDtoCopyWith<$R2, WidgetBlockDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WidgetBlockDtoCopyWithImpl($value, $cast, t);
}

class ImageBlockDtoMapper extends SubClassMapperBase<ImageBlockDto> {
  ImageBlockDtoMapper._();

  static ImageBlockDtoMapper? _instance;
  static ImageBlockDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageBlockDtoMapper._());
      SubSectionBlockDtoMapper.ensureInitialized().addSubMapper(_instance!);
      ImageOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageBlockDto';

  static ImageOptions? _$options(ImageBlockDto v) => v.options;
  static const Field<ImageBlockDto, ImageOptions> _f$options =
      Field('options', _$options, opt: true);
  static String _$content(ImageBlockDto v) => v.content;
  static const Field<ImageBlockDto, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final MappableFields<ImageBlockDto> fields = const {
    #options: _f$options,
    #content: _f$content,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'image';
  @override
  late final ClassMapperBase superMapper =
      SubSectionBlockDtoMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static ImageBlockDto _instantiate(DecodingData data) {
    return ImageBlockDto(
        options: data.dec(_f$options), content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageBlockDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageBlockDto>(map);
  }

  static ImageBlockDto fromJson(String json) {
    return ensureInitialized().decodeJson<ImageBlockDto>(json);
  }
}

mixin ImageBlockDtoMappable {
  String toJson() {
    return ImageBlockDtoMapper.ensureInitialized()
        .encodeJson<ImageBlockDto>(this as ImageBlockDto);
  }

  Map<String, dynamic> toMap() {
    return ImageBlockDtoMapper.ensureInitialized()
        .encodeMap<ImageBlockDto>(this as ImageBlockDto);
  }

  ImageBlockDtoCopyWith<ImageBlockDto, ImageBlockDto, ImageBlockDto>
      get copyWith => _ImageBlockDtoCopyWithImpl(
          this as ImageBlockDto, $identity, $identity);
  @override
  String toString() {
    return ImageBlockDtoMapper.ensureInitialized()
        .stringifyValue(this as ImageBlockDto);
  }

  @override
  bool operator ==(Object other) {
    return ImageBlockDtoMapper.ensureInitialized()
        .equalsValue(this as ImageBlockDto, other);
  }

  @override
  int get hashCode {
    return ImageBlockDtoMapper.ensureInitialized()
        .hashValue(this as ImageBlockDto);
  }
}

extension ImageBlockDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageBlockDto, $Out> {
  ImageBlockDtoCopyWith<$R, ImageBlockDto, $Out> get $asImageBlockDto =>
      $base.as((v, t, t2) => _ImageBlockDtoCopyWithImpl(v, t, t2));
}

abstract class ImageBlockDtoCopyWith<$R, $In extends ImageBlockDto, $Out>
    implements SubSectionBlockDtoCopyWith<$R, $In, $Out, ImageOptions> {
  ImageOptionsCopyWith<$R, ImageOptions, ImageOptions>? get options;
  @override
  $R call({ImageOptions? options, String? content});
  ImageBlockDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageBlockDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageBlockDto, $Out>
    implements ImageBlockDtoCopyWith<$R, ImageBlockDto, $Out> {
  _ImageBlockDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageBlockDto> $mapper =
      ImageBlockDtoMapper.ensureInitialized();
  @override
  ImageOptionsCopyWith<$R, ImageOptions, ImageOptions>? get options =>
      $value.options?.copyWith.$chain((v) => call(options: v));
  @override
  $R call({Object? options = $none, String? content}) =>
      $apply(FieldCopyWithData({
        if (options != $none) #options: options,
        if (content != null) #content: content
      }));
  @override
  ImageBlockDto $make(CopyWithData data) => ImageBlockDto(
      options: data.get(#options, or: $value.options),
      content: data.get(#content, or: $value.content));

  @override
  ImageBlockDtoCopyWith<$R2, ImageBlockDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageBlockDtoCopyWithImpl($value, $cast, t);
}