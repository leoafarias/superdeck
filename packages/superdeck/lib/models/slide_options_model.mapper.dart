// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_options_model.dart';

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

class ImageOptionsMapper extends ClassMapperBase<ImageOptions> {
  ImageOptionsMapper._();

  static ImageOptionsMapper? _instance;
  static ImageOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageOptionsMapper._());
      ImageFitMapper.ensureInitialized();
      LayoutPositionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageOptions';

  static String _$src(ImageOptions v) => v.src;
  static const Field<ImageOptions, String> _f$src = Field('src', _$src);
  static ImageFit _$fit(ImageOptions v) => v.fit;
  static const Field<ImageOptions, ImageFit> _f$fit =
      Field('fit', _$fit, opt: true, def: ImageFit.cover);
  static LayoutPosition _$position(ImageOptions v) => v.position;
  static const Field<ImageOptions, LayoutPosition> _f$position =
      Field('position', _$position, opt: true, def: LayoutPosition.left);

  @override
  final MappableFields<ImageOptions> fields = const {
    #src: _f$src,
    #fit: _f$fit,
    #position: _f$position,
  };

  static ImageOptions _instantiate(DecodingData data) {
    return ImageOptions(
        src: data.dec(_f$src),
        fit: data.dec(_f$fit),
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
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ImageOptionsMapper.ensureInitialized()
                .isValueEqual(this as ImageOptions, other));
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
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? src, ImageFit? fit, LayoutPosition? position});
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
  $R call({String? src, ImageFit? fit, LayoutPosition? position}) =>
      $apply(FieldCopyWithData({
        if (src != null) #src: src,
        if (fit != null) #fit: fit,
        if (position != null) #position: position
      }));
  @override
  ImageOptions $make(CopyWithData data) => ImageOptions(
      src: data.get(#src, or: $value.src),
      fit: data.get(#fit, or: $value.fit),
      position: data.get(#position, or: $value.position));

  @override
  ImageOptionsCopyWith<$R2, ImageOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageOptionsCopyWithImpl($value, $cast, t);
}

class PreviewOptionsMapper extends ClassMapperBase<PreviewOptions> {
  PreviewOptionsMapper._();

  static PreviewOptionsMapper? _instance;
  static PreviewOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PreviewOptionsMapper._());
      LayoutPositionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PreviewOptions';

  static String _$name(PreviewOptions v) => v.name;
  static const Field<PreviewOptions, String> _f$name = Field('name', _$name);
  static Map<String, dynamic> _$args(PreviewOptions v) => v.args;
  static const Field<PreviewOptions, Map<String, dynamic>> _f$args =
      Field('args', _$args, opt: true, def: const {});
  static LayoutPosition _$position(PreviewOptions v) => v.position;
  static const Field<PreviewOptions, LayoutPosition> _f$position =
      Field('position', _$position, opt: true, def: LayoutPosition.left);

  @override
  final MappableFields<PreviewOptions> fields = const {
    #name: _f$name,
    #args: _f$args,
    #position: _f$position,
  };

  static PreviewOptions _instantiate(DecodingData data) {
    return PreviewOptions(
        name: data.dec(_f$name),
        args: data.dec(_f$args),
        position: data.dec(_f$position));
  }

  @override
  final Function instantiate = _instantiate;

  static PreviewOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PreviewOptions>(map);
  }

  static PreviewOptions fromJson(String json) {
    return ensureInitialized().decodeJson<PreviewOptions>(json);
  }
}

mixin PreviewOptionsMappable {
  String toJson() {
    return PreviewOptionsMapper.ensureInitialized()
        .encodeJson<PreviewOptions>(this as PreviewOptions);
  }

  Map<String, dynamic> toMap() {
    return PreviewOptionsMapper.ensureInitialized()
        .encodeMap<PreviewOptions>(this as PreviewOptions);
  }

  PreviewOptionsCopyWith<PreviewOptions, PreviewOptions, PreviewOptions>
      get copyWith => _PreviewOptionsCopyWithImpl(
          this as PreviewOptions, $identity, $identity);
  @override
  String toString() {
    return PreviewOptionsMapper.ensureInitialized()
        .stringifyValue(this as PreviewOptions);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PreviewOptionsMapper.ensureInitialized()
                .isValueEqual(this as PreviewOptions, other));
  }

  @override
  int get hashCode {
    return PreviewOptionsMapper.ensureInitialized()
        .hashValue(this as PreviewOptions);
  }
}

extension PreviewOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PreviewOptions, $Out> {
  PreviewOptionsCopyWith<$R, PreviewOptions, $Out> get $asPreviewOptions =>
      $base.as((v, t, t2) => _PreviewOptionsCopyWithImpl(v, t, t2));
}

abstract class PreviewOptionsCopyWith<$R, $In extends PreviewOptions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get args;
  $R call({String? name, Map<String, dynamic>? args, LayoutPosition? position});
  PreviewOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PreviewOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PreviewOptions, $Out>
    implements PreviewOptionsCopyWith<$R, PreviewOptions, $Out> {
  _PreviewOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PreviewOptions> $mapper =
      PreviewOptionsMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get args => MapCopyWith($value.args,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(args: v));
  @override
  $R call(
          {String? name,
          Map<String, dynamic>? args,
          LayoutPosition? position}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (args != null) #args: args,
        if (position != null) #position: position
      }));
  @override
  PreviewOptions $make(CopyWithData data) => PreviewOptions(
      name: data.get(#name, or: $value.name),
      args: data.get(#args, or: $value.args),
      position: data.get(#position, or: $value.position));

  @override
  PreviewOptionsCopyWith<$R2, PreviewOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PreviewOptionsCopyWithImpl($value, $cast, t);
}
