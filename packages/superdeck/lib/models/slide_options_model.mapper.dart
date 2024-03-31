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

class ImagePositionMapper extends EnumMapper<ImagePosition> {
  ImagePositionMapper._();

  static ImagePositionMapper? _instance;
  static ImagePositionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImagePositionMapper._());
    }
    return _instance!;
  }

  static ImagePosition fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ImagePosition decode(dynamic value) {
    switch (value) {
      case 'left':
        return ImagePosition.left;
      case 'right':
        return ImagePosition.right;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ImagePosition self) {
    switch (self) {
      case ImagePosition.left:
        return 'left';
      case ImagePosition.right:
        return 'right';
    }
  }
}

extension ImagePositionMapperExtension on ImagePosition {
  String toValue() {
    ImagePositionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ImagePosition>(this) as String;
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

class ImageConfigMapper extends ClassMapperBase<ImageConfig> {
  ImageConfigMapper._();

  static ImageConfigMapper? _instance;
  static ImageConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageConfigMapper._());
      ImageFitMapper.ensureInitialized();
      ImagePositionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageConfig';

  static String _$src(ImageConfig v) => v.src;
  static const Field<ImageConfig, String> _f$src = Field('src', _$src);
  static ImageFit _$fit(ImageConfig v) => v.fit;
  static const Field<ImageConfig, ImageFit> _f$fit =
      Field('fit', _$fit, opt: true, def: ImageFit.cover);
  static ImagePosition _$position(ImageConfig v) => v.position;
  static const Field<ImageConfig, ImagePosition> _f$position =
      Field('position', _$position, opt: true, def: ImagePosition.left);

  @override
  final MappableFields<ImageConfig> fields = const {
    #src: _f$src,
    #fit: _f$fit,
    #position: _f$position,
  };

  static ImageConfig _instantiate(DecodingData data) {
    return ImageConfig(
        src: data.dec(_f$src),
        fit: data.dec(_f$fit),
        position: data.dec(_f$position));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageConfig>(map);
  }

  static ImageConfig fromJson(String json) {
    return ensureInitialized().decodeJson<ImageConfig>(json);
  }
}

mixin ImageConfigMappable {
  String toJson() {
    return ImageConfigMapper.ensureInitialized()
        .encodeJson<ImageConfig>(this as ImageConfig);
  }

  Map<String, dynamic> toMap() {
    return ImageConfigMapper.ensureInitialized()
        .encodeMap<ImageConfig>(this as ImageConfig);
  }

  ImageConfigCopyWith<ImageConfig, ImageConfig, ImageConfig> get copyWith =>
      _ImageConfigCopyWithImpl(this as ImageConfig, $identity, $identity);
  @override
  String toString() {
    return ImageConfigMapper.ensureInitialized()
        .stringifyValue(this as ImageConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ImageConfigMapper.ensureInitialized()
                .isValueEqual(this as ImageConfig, other));
  }

  @override
  int get hashCode {
    return ImageConfigMapper.ensureInitialized().hashValue(this as ImageConfig);
  }
}

extension ImageConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageConfig, $Out> {
  ImageConfigCopyWith<$R, ImageConfig, $Out> get $asImageConfig =>
      $base.as((v, t, t2) => _ImageConfigCopyWithImpl(v, t, t2));
}

abstract class ImageConfigCopyWith<$R, $In extends ImageConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? src, ImageFit? fit, ImagePosition? position});
  ImageConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageConfig, $Out>
    implements ImageConfigCopyWith<$R, ImageConfig, $Out> {
  _ImageConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageConfig> $mapper =
      ImageConfigMapper.ensureInitialized();
  @override
  $R call({String? src, ImageFit? fit, ImagePosition? position}) =>
      $apply(FieldCopyWithData({
        if (src != null) #src: src,
        if (fit != null) #fit: fit,
        if (position != null) #position: position
      }));
  @override
  ImageConfig $make(CopyWithData data) => ImageConfig(
      src: data.get(#src, or: $value.src),
      fit: data.get(#fit, or: $value.fit),
      position: data.get(#position, or: $value.position));

  @override
  ImageConfigCopyWith<$R2, ImageConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageConfigCopyWithImpl($value, $cast, t);
}
