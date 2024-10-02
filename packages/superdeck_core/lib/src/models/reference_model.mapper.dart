// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'reference_model.dart';

class ReferenceDtoMapper extends ClassMapperBase<ReferenceDto> {
  ReferenceDtoMapper._();

  static ReferenceDtoMapper? _instance;
  static ReferenceDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReferenceDtoMapper._());
      ConfigMapper.ensureInitialized();
      SlideMapper.ensureInitialized();
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

  @override
  final MappableFields<ReferenceDto> fields = const {
    #config: _f$config,
    #slides: _f$slides,
  };
  @override
  final bool ignoreNull = true;

  static ReferenceDto _instantiate(DecodingData data) {
    return ReferenceDto(
        config: data.dec(_f$config), slides: data.dec(_f$slides));
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
  $R call({Config? config, List<Slide>? slides});
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
  $R call({Config? config, List<Slide>? slides}) => $apply(FieldCopyWithData({
        if (config != null) #config: config,
        if (slides != null) #slides: slides
      }));
  @override
  ReferenceDto $make(CopyWithData data) => ReferenceDto(
      config: data.get(#config, or: $value.config),
      slides: data.get(#slides, or: $value.slides));

  @override
  ReferenceDtoCopyWith<$R2, ReferenceDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ReferenceDtoCopyWithImpl($value, $cast, t);
}
