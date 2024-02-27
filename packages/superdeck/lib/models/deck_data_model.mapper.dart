// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'deck_data_model.dart';

class DeckDataMapper extends ClassMapperBase<DeckData> {
  DeckDataMapper._();

  static DeckDataMapper? _instance;
  static DeckDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckDataMapper._());
      SlideConfigMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeckData';

  static List<SlideConfig> _$slides(DeckData v) => v.slides;
  static const Field<DeckData, List<SlideConfig>> _f$slides =
      Field('slides', _$slides, opt: true, def: const []);

  @override
  final MappableFields<DeckData> fields = const {
    #slides: _f$slides,
  };

  static DeckData _instantiate(DecodingData data) {
    return DeckData(slides: data.dec(_f$slides));
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
  $R call({List<SlideConfig>? slides});
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
  $R call({List<SlideConfig>? slides}) =>
      $apply(FieldCopyWithData({if (slides != null) #slides: slides}));
  @override
  DeckData $make(CopyWithData data) =>
      DeckData(slides: data.get(#slides, or: $value.slides));

  @override
  DeckDataCopyWith<$R2, DeckData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckDataCopyWithImpl($value, $cast, t);
}
