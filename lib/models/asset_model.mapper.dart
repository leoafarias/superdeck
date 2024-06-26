// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_model.dart';

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

class SlideAssetTypeMapper extends EnumMapper<SlideAssetType> {
  SlideAssetTypeMapper._();

  static SlideAssetTypeMapper? _instance;
  static SlideAssetTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideAssetTypeMapper._());
    }
    return _instance!;
  }

  static SlideAssetType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SlideAssetType decode(dynamic value) {
    switch (value) {
      case 'cached':
        return SlideAssetType.cached;
      case 'thumb':
        return SlideAssetType.thumb;
      case 'mermaid':
        return SlideAssetType.mermaid;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SlideAssetType self) {
    switch (self) {
      case SlideAssetType.cached:
        return 'cached';
      case SlideAssetType.thumb:
        return 'thumb';
      case SlideAssetType.mermaid:
        return 'mermaid';
    }
  }
}

extension SlideAssetTypeMapperExtension on SlideAssetType {
  String toValue() {
    SlideAssetTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SlideAssetType>(this) as String;
  }
}

class SlideAssetMapper extends ClassMapperBase<SlideAsset> {
  SlideAssetMapper._();

  static SlideAssetMapper? _instance;
  static SlideAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideAssetMapper._());
      MapperContainer.globals.useAll([FileMapper(), SizeMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'SlideAsset';

  static File _$file(SlideAsset v) => v.file;
  static const Field<SlideAsset, File> _f$file = Field('file', _$file);
  static Size _$dimensions(SlideAsset v) => v.dimensions;
  static const Field<SlideAsset, Size> _f$dimensions =
      Field('dimensions', _$dimensions);

  @override
  final MappableFields<SlideAsset> fields = const {
    #file: _f$file,
    #dimensions: _f$dimensions,
  };
  @override
  final bool ignoreNull = true;

  static SlideAsset _instantiate(DecodingData data) {
    return SlideAsset(
        file: data.dec(_f$file), dimensions: data.dec(_f$dimensions));
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
  $R call({File? file, Size? dimensions});
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
  $R call({File? file, Size? dimensions}) => $apply(FieldCopyWithData({
        if (file != null) #file: file,
        if (dimensions != null) #dimensions: dimensions
      }));
  @override
  SlideAsset $make(CopyWithData data) => SlideAsset(
      file: data.get(#file, or: $value.file),
      dimensions: data.get(#dimensions, or: $value.dimensions));

  @override
  SlideAssetCopyWith<$R2, SlideAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideAssetCopyWithImpl($value, $cast, t);
}
