// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'deck_reference_model.dart';

class DeckReferenceMapper extends ClassMapperBase<DeckReference> {
  DeckReferenceMapper._();

  static DeckReferenceMapper? _instance;
  static DeckReferenceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckReferenceMapper._());
      ConfigMapper.ensureInitialized();
      SlideMapper.ensureInitialized();
      SlideAssetMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeckReference';

  static Config _$config(DeckReference v) => v.config;
  static const Field<DeckReference, Config> _f$config =
      Field('config', _$config);
  static List<Slide> _$slides(DeckReference v) => v.slides;
  static const Field<DeckReference, List<Slide>> _f$slides =
      Field('slides', _$slides);
  static List<SlideAsset> _$assets(DeckReference v) => v.assets;
  static const Field<DeckReference, List<SlideAsset>> _f$assets =
      Field('assets', _$assets);

  @override
  final MappableFields<DeckReference> fields = const {
    #config: _f$config,
    #slides: _f$slides,
    #assets: _f$assets,
  };
  @override
  final bool ignoreNull = true;

  static DeckReference _instantiate(DecodingData data) {
    return DeckReference(
        config: data.dec(_f$config),
        slides: data.dec(_f$slides),
        assets: data.dec(_f$assets));
  }

  @override
  final Function instantiate = _instantiate;

  static DeckReference fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeckReference>(map);
  }

  static DeckReference fromJson(String json) {
    return ensureInitialized().decodeJson<DeckReference>(json);
  }
}

mixin DeckReferenceMappable {
  String toJson() {
    return DeckReferenceMapper.ensureInitialized()
        .encodeJson<DeckReference>(this as DeckReference);
  }

  Map<String, dynamic> toMap() {
    return DeckReferenceMapper.ensureInitialized()
        .encodeMap<DeckReference>(this as DeckReference);
  }

  DeckReferenceCopyWith<DeckReference, DeckReference, DeckReference>
      get copyWith => _DeckReferenceCopyWithImpl(
          this as DeckReference, $identity, $identity);
  @override
  String toString() {
    return DeckReferenceMapper.ensureInitialized()
        .stringifyValue(this as DeckReference);
  }

  @override
  bool operator ==(Object other) {
    return DeckReferenceMapper.ensureInitialized()
        .equalsValue(this as DeckReference, other);
  }

  @override
  int get hashCode {
    return DeckReferenceMapper.ensureInitialized()
        .hashValue(this as DeckReference);
  }
}

extension DeckReferenceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeckReference, $Out> {
  DeckReferenceCopyWith<$R, DeckReference, $Out> get $asDeckReference =>
      $base.as((v, t, t2) => _DeckReferenceCopyWithImpl(v, t, t2));
}

abstract class DeckReferenceCopyWith<$R, $In extends DeckReference, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ConfigCopyWith<$R, Config, Config> get config;
  ListCopyWith<$R, Slide, SlideCopyWith<$R, Slide, Slide>> get slides;
  ListCopyWith<$R, SlideAsset, SlideAssetCopyWith<$R, SlideAsset, SlideAsset>>
      get assets;
  $R call({Config? config, List<Slide>? slides, List<SlideAsset>? assets});
  DeckReferenceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DeckReferenceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeckReference, $Out>
    implements DeckReferenceCopyWith<$R, DeckReference, $Out> {
  _DeckReferenceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeckReference> $mapper =
      DeckReferenceMapper.ensureInitialized();
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
  DeckReference $make(CopyWithData data) => DeckReference(
      config: data.get(#config, or: $value.config),
      slides: data.get(#slides, or: $value.slides),
      assets: data.get(#assets, or: $value.assets));

  @override
  DeckReferenceCopyWith<$R2, DeckReference, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckReferenceCopyWithImpl($value, $cast, t);
}
