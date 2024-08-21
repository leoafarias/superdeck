// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'reference_model.dart';

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
