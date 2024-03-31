// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_asset_model.dart';

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

  static String _$name(SlideAsset v) => v.name;
  static const Field<SlideAsset, String> _f$name = Field('name', _$name);
  static String _$base64(SlideAsset v) => v.base64;
  static const Field<SlideAsset, String> _f$base64 = Field('base64', _$base64);

  @override
  final MappableFields<SlideAsset> fields = const {
    #name: _f$name,
    #base64: _f$base64,
  };

  static SlideAsset _instantiate(DecodingData data) {
    return SlideAsset(name: data.dec(_f$name), base64: data.dec(_f$base64));
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
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SlideAssetMapper.ensureInitialized()
                .isValueEqual(this as SlideAsset, other));
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
  $R call({String? name, String? base64});
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
  $R call({String? name, String? base64}) => $apply(FieldCopyWithData(
      {if (name != null) #name: name, if (base64 != null) #base64: base64}));
  @override
  SlideAsset $make(CopyWithData data) => SlideAsset(
      name: data.get(#name, or: $value.name),
      base64: data.get(#base64, or: $value.base64));

  @override
  SlideAssetCopyWith<$R2, SlideAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideAssetCopyWithImpl($value, $cast, t);
}
