// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_model.dart';

class AssetTypeMapper extends EnumMapper<AssetType> {
  AssetTypeMapper._();

  static AssetTypeMapper? _instance;
  static AssetTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetTypeMapper._());
    }
    return _instance!;
  }

  static AssetType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AssetType decode(dynamic value) {
    switch (value) {
      case 'cached':
        return AssetType.cached;
      case 'generated':
        return AssetType.generated;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AssetType self) {
    switch (self) {
      case AssetType.cached:
        return 'cached';
      case AssetType.generated:
        return 'generated';
    }
  }
}

extension AssetTypeMapperExtension on AssetType {
  String toValue() {
    AssetTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AssetType>(this) as String;
  }
}

class SlideAssetMapper extends ClassMapperBase<SlideAsset> {
  SlideAssetMapper._();

  static SlideAssetMapper? _instance;
  static SlideAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideAssetMapper._());
      MapperContainer.globals.useAll([AssetFileBytesMapper()]);
      GeneratedAssetMapper.ensureInitialized();
      CachedAssetMapper.ensureInitialized();
      AssetTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideAsset';

  static double _$width(SlideAsset v) => v.width;
  static const Field<SlideAsset, double> _f$width = Field('width', _$width);
  static double _$height(SlideAsset v) => v.height;
  static const Field<SlideAsset, double> _f$height = Field('height', _$height);
  static String _$localPath(SlideAsset v) => v.localPath;
  static const Field<SlideAsset, String> _f$localPath =
      Field('localPath', _$localPath, key: 'local_path');
  static String _$hash(SlideAsset v) => v.hash;
  static const Field<SlideAsset, String> _f$hash = Field('hash', _$hash);
  static AssetType _$type(SlideAsset v) => v.type;
  static const Field<SlideAsset, AssetType> _f$type = Field('type', _$type);

  @override
  final MappableFields<SlideAsset> fields = const {
    #width: _f$width,
    #height: _f$height,
    #localPath: _f$localPath,
    #hash: _f$hash,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  static SlideAsset _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'SlideAsset', 'type', '${data.value['type']}');
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
  String toJson();
  Map<String, dynamic> toMap();
  SlideAssetCopyWith<SlideAsset, SlideAsset, SlideAsset> get copyWith;
}

abstract class SlideAssetCopyWith<$R, $In extends SlideAsset, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? width, double? height, String? localPath});
  SlideAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class GeneratedAssetMapper extends SubClassMapperBase<GeneratedAsset> {
  GeneratedAssetMapper._();

  static GeneratedAssetMapper? _instance;
  static GeneratedAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GeneratedAssetMapper._());
      SlideAssetMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'GeneratedAsset';

  static double _$width(GeneratedAsset v) => v.width;
  static const Field<GeneratedAsset, double> _f$width = Field('width', _$width);
  static double _$height(GeneratedAsset v) => v.height;
  static const Field<GeneratedAsset, double> _f$height =
      Field('height', _$height);
  static String _$localPath(GeneratedAsset v) => v.localPath;
  static const Field<GeneratedAsset, String> _f$localPath =
      Field('localPath', _$localPath, key: 'local_path');
  static String _$hash(GeneratedAsset v) => v.hash;
  static const Field<GeneratedAsset, String> _f$hash = Field('hash', _$hash);
  static AssetType _$type(GeneratedAsset v) => v.type;
  static const Field<GeneratedAsset, AssetType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<GeneratedAsset> fields = const {
    #width: _f$width,
    #height: _f$height,
    #localPath: _f$localPath,
    #hash: _f$hash,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = AssetType.generated;
  @override
  late final ClassMapperBase superMapper = SlideAssetMapper.ensureInitialized();

  static GeneratedAsset _instantiate(DecodingData data) {
    return GeneratedAsset(
        width: data.dec(_f$width),
        height: data.dec(_f$height),
        localPath: data.dec(_f$localPath),
        hash: data.dec(_f$hash));
  }

  @override
  final Function instantiate = _instantiate;

  static GeneratedAsset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GeneratedAsset>(map);
  }

  static GeneratedAsset fromJson(String json) {
    return ensureInitialized().decodeJson<GeneratedAsset>(json);
  }
}

mixin GeneratedAssetMappable {
  String toJson() {
    return GeneratedAssetMapper.ensureInitialized()
        .encodeJson<GeneratedAsset>(this as GeneratedAsset);
  }

  Map<String, dynamic> toMap() {
    return GeneratedAssetMapper.ensureInitialized()
        .encodeMap<GeneratedAsset>(this as GeneratedAsset);
  }

  GeneratedAssetCopyWith<GeneratedAsset, GeneratedAsset, GeneratedAsset>
      get copyWith => _GeneratedAssetCopyWithImpl(
          this as GeneratedAsset, $identity, $identity);
  @override
  String toString() {
    return GeneratedAssetMapper.ensureInitialized()
        .stringifyValue(this as GeneratedAsset);
  }

  @override
  bool operator ==(Object other) {
    return GeneratedAssetMapper.ensureInitialized()
        .equalsValue(this as GeneratedAsset, other);
  }

  @override
  int get hashCode {
    return GeneratedAssetMapper.ensureInitialized()
        .hashValue(this as GeneratedAsset);
  }
}

extension GeneratedAssetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GeneratedAsset, $Out> {
  GeneratedAssetCopyWith<$R, GeneratedAsset, $Out> get $asGeneratedAsset =>
      $base.as((v, t, t2) => _GeneratedAssetCopyWithImpl(v, t, t2));
}

abstract class GeneratedAssetCopyWith<$R, $In extends GeneratedAsset, $Out>
    implements SlideAssetCopyWith<$R, $In, $Out> {
  @override
  $R call({double? width, double? height, String? localPath, String? hash});
  GeneratedAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GeneratedAssetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GeneratedAsset, $Out>
    implements GeneratedAssetCopyWith<$R, GeneratedAsset, $Out> {
  _GeneratedAssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GeneratedAsset> $mapper =
      GeneratedAssetMapper.ensureInitialized();
  @override
  $R call({double? width, double? height, String? localPath, String? hash}) =>
      $apply(FieldCopyWithData({
        if (width != null) #width: width,
        if (height != null) #height: height,
        if (localPath != null) #localPath: localPath,
        if (hash != null) #hash: hash
      }));
  @override
  GeneratedAsset $make(CopyWithData data) => GeneratedAsset(
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      localPath: data.get(#localPath, or: $value.localPath),
      hash: data.get(#hash, or: $value.hash));

  @override
  GeneratedAssetCopyWith<$R2, GeneratedAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GeneratedAssetCopyWithImpl($value, $cast, t);
}

class CachedAssetMapper extends SubClassMapperBase<CachedAsset> {
  CachedAssetMapper._();

  static CachedAssetMapper? _instance;
  static CachedAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CachedAssetMapper._());
      SlideAssetMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'CachedAsset';

  static const Field<CachedAsset, String> _f$uri =
      Field('uri', null, mode: FieldMode.param);
  static double _$width(CachedAsset v) => v.width;
  static const Field<CachedAsset, double> _f$width = Field('width', _$width);
  static double _$height(CachedAsset v) => v.height;
  static const Field<CachedAsset, double> _f$height = Field('height', _$height);
  static String _$localPath(CachedAsset v) => v.localPath;
  static const Field<CachedAsset, String> _f$localPath =
      Field('localPath', _$localPath, key: 'local_path');
  static String _$hash(CachedAsset v) => v.hash;
  static const Field<CachedAsset, String> _f$hash =
      Field('hash', _$hash, mode: FieldMode.member);
  static AssetType _$type(CachedAsset v) => v.type;
  static const Field<CachedAsset, AssetType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<CachedAsset> fields = const {
    #uri: _f$uri,
    #width: _f$width,
    #height: _f$height,
    #localPath: _f$localPath,
    #hash: _f$hash,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = AssetType.cached;
  @override
  late final ClassMapperBase superMapper = SlideAssetMapper.ensureInitialized();

  static CachedAsset _instantiate(DecodingData data) {
    return CachedAsset(
        uri: data.dec(_f$uri),
        width: data.dec(_f$width),
        height: data.dec(_f$height),
        localPath: data.dec(_f$localPath));
  }

  @override
  final Function instantiate = _instantiate;

  static CachedAsset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CachedAsset>(map);
  }

  static CachedAsset fromJson(String json) {
    return ensureInitialized().decodeJson<CachedAsset>(json);
  }
}

mixin CachedAssetMappable {
  String toJson() {
    return CachedAssetMapper.ensureInitialized()
        .encodeJson<CachedAsset>(this as CachedAsset);
  }

  Map<String, dynamic> toMap() {
    return CachedAssetMapper.ensureInitialized()
        .encodeMap<CachedAsset>(this as CachedAsset);
  }

  CachedAssetCopyWith<CachedAsset, CachedAsset, CachedAsset> get copyWith =>
      _CachedAssetCopyWithImpl(this as CachedAsset, $identity, $identity);
  @override
  String toString() {
    return CachedAssetMapper.ensureInitialized()
        .stringifyValue(this as CachedAsset);
  }

  @override
  bool operator ==(Object other) {
    return CachedAssetMapper.ensureInitialized()
        .equalsValue(this as CachedAsset, other);
  }

  @override
  int get hashCode {
    return CachedAssetMapper.ensureInitialized().hashValue(this as CachedAsset);
  }
}

extension CachedAssetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CachedAsset, $Out> {
  CachedAssetCopyWith<$R, CachedAsset, $Out> get $asCachedAsset =>
      $base.as((v, t, t2) => _CachedAssetCopyWithImpl(v, t, t2));
}

abstract class CachedAssetCopyWith<$R, $In extends CachedAsset, $Out>
    implements SlideAssetCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {required String uri, double? width, double? height, String? localPath});
  CachedAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CachedAssetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CachedAsset, $Out>
    implements CachedAssetCopyWith<$R, CachedAsset, $Out> {
  _CachedAssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CachedAsset> $mapper =
      CachedAssetMapper.ensureInitialized();
  @override
  $R call(
          {required String uri,
          double? width,
          double? height,
          String? localPath}) =>
      $apply(FieldCopyWithData({
        #uri: uri,
        if (width != null) #width: width,
        if (height != null) #height: height,
        if (localPath != null) #localPath: localPath
      }));
  @override
  CachedAsset $make(CopyWithData data) => CachedAsset(
      uri: data.get(#uri),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      localPath: data.get(#localPath, or: $value.localPath));

  @override
  CachedAssetCopyWith<$R2, CachedAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CachedAssetCopyWithImpl($value, $cast, t);
}
