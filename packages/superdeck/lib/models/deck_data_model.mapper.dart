// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'deck_data_model.dart';

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

class DeckDataMapper extends ClassMapperBase<DeckData> {
  DeckDataMapper._();

  static DeckDataMapper? _instance;
  static DeckDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckDataMapper._());
      SlideConfigMapper.ensureInitialized();
      SlideAssetMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeckData';

  static List<SlideConfig> _$slides(DeckData v) => v.slides;
  static const Field<DeckData, List<SlideConfig>> _f$slides =
      Field('slides', _$slides, opt: true, def: const []);
  static List<SlideAsset> _$assets(DeckData v) => v.assets;
  static const Field<DeckData, List<SlideAsset>> _f$assets =
      Field('assets', _$assets, opt: true, def: const []);

  @override
  final MappableFields<DeckData> fields = const {
    #slides: _f$slides,
    #assets: _f$assets,
  };

  static DeckData _instantiate(DecodingData data) {
    return DeckData(slides: data.dec(_f$slides), assets: data.dec(_f$assets));
  }

  @override
  final Function instantiate = _instantiate;

  static DeckData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeckData>(map);
  }

  static DeckData fromJson(String json) {
    return ensureInitialized().decodeJson<DeckData>(json);
  }
}

mixin DeckDataMappable {
  String toJson() {
    return DeckDataMapper.ensureInitialized()
        .encodeJson<DeckData>(this as DeckData);
  }

  Map<String, dynamic> toMap() {
    return DeckDataMapper.ensureInitialized()
        .encodeMap<DeckData>(this as DeckData);
  }

  DeckDataCopyWith<DeckData, DeckData, DeckData> get copyWith =>
      _DeckDataCopyWithImpl(this as DeckData, $identity, $identity);
  @override
  String toString() {
    return DeckDataMapper.ensureInitialized().stringifyValue(this as DeckData);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DeckDataMapper.ensureInitialized()
                .isValueEqual(this as DeckData, other));
  }

  @override
  int get hashCode {
    return DeckDataMapper.ensureInitialized().hashValue(this as DeckData);
  }
}

extension DeckDataValueCopy<$R, $Out> on ObjectCopyWith<$R, DeckData, $Out> {
  DeckDataCopyWith<$R, DeckData, $Out> get $asDeckData =>
      $base.as((v, t, t2) => _DeckDataCopyWithImpl(v, t, t2));
}

abstract class DeckDataCopyWith<$R, $In extends DeckData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SlideConfig, ObjectCopyWith<$R, SlideConfig, SlideConfig>>
      get slides;
  ListCopyWith<$R, SlideAsset, SlideAssetCopyWith<$R, SlideAsset, SlideAsset>>
      get assets;
  $R call({List<SlideConfig>? slides, List<SlideAsset>? assets});
  DeckDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DeckDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeckData, $Out>
    implements DeckDataCopyWith<$R, DeckData, $Out> {
  _DeckDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeckData> $mapper =
      DeckDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SlideConfig, ObjectCopyWith<$R, SlideConfig, SlideConfig>>
      get slides => ListCopyWith($value.slides,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(slides: v));
  @override
  ListCopyWith<$R, SlideAsset, SlideAssetCopyWith<$R, SlideAsset, SlideAsset>>
      get assets => ListCopyWith($value.assets, (v, t) => v.copyWith.$chain(t),
          (v) => call(assets: v));
  @override
  $R call({List<SlideConfig>? slides, List<SlideAsset>? assets}) =>
      $apply(FieldCopyWithData({
        if (slides != null) #slides: slides,
        if (assets != null) #assets: assets
      }));
  @override
  DeckData $make(CopyWithData data) => DeckData(
      slides: data.get(#slides, or: $value.slides),
      assets: data.get(#assets, or: $value.assets));

  @override
  DeckDataCopyWith<$R2, DeckData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckDataCopyWithImpl($value, $cast, t);
}
