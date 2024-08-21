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
