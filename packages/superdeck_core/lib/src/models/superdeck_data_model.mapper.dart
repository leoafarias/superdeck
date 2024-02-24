// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'superdeck_data_model.dart';

class DashDeckDataMapper extends ClassMapperBase<DashDeckData> {
  DashDeckDataMapper._();

  static DashDeckDataMapper? _instance;
  static DashDeckDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DashDeckDataMapper._());
      SlideMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DashDeckData';

  static List<Slide> _$slides(DashDeckData v) => v.slides;
  static const Field<DashDeckData, List<Slide>> _f$slides =
      Field('slides', _$slides, opt: true, def: const []);

  @override
  final MappableFields<DashDeckData> fields = const {
    #slides: _f$slides,
  };

  static DashDeckData _instantiate(DecodingData data) {
    return DashDeckData(slides: data.dec(_f$slides));
  }

  @override
  final Function instantiate = _instantiate;

  static DashDeckData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DashDeckData>(map);
  }

  static DashDeckData fromJson(String json) {
    return ensureInitialized().decodeJson<DashDeckData>(json);
  }
}

mixin DashDeckDataMappable {
  String toJson() {
    return DashDeckDataMapper.ensureInitialized()
        .encodeJson<DashDeckData>(this as DashDeckData);
  }

  Map<String, dynamic> toMap() {
    return DashDeckDataMapper.ensureInitialized()
        .encodeMap<DashDeckData>(this as DashDeckData);
  }

  DashDeckDataCopyWith<DashDeckData, DashDeckData, DashDeckData> get copyWith =>
      _DashDeckDataCopyWithImpl(this as DashDeckData, $identity, $identity);
  @override
  String toString() {
    return DashDeckDataMapper.ensureInitialized()
        .stringifyValue(this as DashDeckData);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DashDeckDataMapper.ensureInitialized()
                .isValueEqual(this as DashDeckData, other));
  }

  @override
  int get hashCode {
    return DashDeckDataMapper.ensureInitialized()
        .hashValue(this as DashDeckData);
  }
}

extension DashDeckDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DashDeckData, $Out> {
  DashDeckDataCopyWith<$R, DashDeckData, $Out> get $asDashDeckData =>
      $base.as((v, t, t2) => _DashDeckDataCopyWithImpl(v, t, t2));
}

abstract class DashDeckDataCopyWith<$R, $In extends DashDeckData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Slide, SlideCopyWith<$R, Slide, Slide>> get slides;
  $R call({List<Slide>? slides});
  DashDeckDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DashDeckDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DashDeckData, $Out>
    implements DashDeckDataCopyWith<$R, DashDeckData, $Out> {
  _DashDeckDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DashDeckData> $mapper =
      DashDeckDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Slide, SlideCopyWith<$R, Slide, Slide>> get slides =>
      ListCopyWith($value.slides, (v, t) => v.copyWith.$chain(t),
          (v) => call(slides: v));
  @override
  $R call({List<Slide>? slides}) =>
      $apply(FieldCopyWithData({if (slides != null) #slides: slides}));
  @override
  DashDeckData $make(CopyWithData data) =>
      DashDeckData(slides: data.get(#slides, or: $value.slides));

  @override
  DashDeckDataCopyWith<$R2, DashDeckData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DashDeckDataCopyWithImpl($value, $cast, t);
}
