// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_data.model.dart';

class SlideDataMapper extends ClassMapperBase<SlideData> {
  SlideDataMapper._();

  static SlideDataMapper? _instance;
  static SlideDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideDataMapper._());
      SlideOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideData';

  static String? _$content(SlideData v) => v.content;
  static const Field<SlideData, String> _f$content =
      Field('content', _$content, opt: true);
  static SlideOptions _$options(SlideData v) => v.options;
  static const Field<SlideData, SlideOptions> _f$options =
      Field('options', _$options, opt: true, def: const SlideOptions());

  @override
  final Map<Symbol, Field<SlideData, dynamic>> fields = const {
    #content: _f$content,
    #options: _f$options,
  };

  static SlideData _instantiate(DecodingData data) {
    return SlideData(
        content: data.dec(_f$content), options: data.dec(_f$options));
  }

  @override
  final Function instantiate = _instantiate;

  static SlideData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideData>(map);
  }

  static SlideData fromJson(String json) {
    return ensureInitialized().decodeJson<SlideData>(json);
  }
}

mixin SlideDataMappable {
  String toJson() {
    return SlideDataMapper.ensureInitialized()
        .encodeJson<SlideData>(this as SlideData);
  }

  Map<String, dynamic> toMap() {
    return SlideDataMapper.ensureInitialized()
        .encodeMap<SlideData>(this as SlideData);
  }

  SlideDataCopyWith<SlideData, SlideData, SlideData> get copyWith =>
      _SlideDataCopyWithImpl(this as SlideData, $identity, $identity);
  @override
  String toString() {
    return SlideDataMapper.ensureInitialized()
        .stringifyValue(this as SlideData);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SlideDataMapper.ensureInitialized()
                .isValueEqual(this as SlideData, other));
  }

  @override
  int get hashCode {
    return SlideDataMapper.ensureInitialized().hashValue(this as SlideData);
  }
}

extension SlideDataValueCopy<$R, $Out> on ObjectCopyWith<$R, SlideData, $Out> {
  SlideDataCopyWith<$R, SlideData, $Out> get $asSlideData =>
      $base.as((v, t, t2) => _SlideDataCopyWithImpl(v, t, t2));
}

abstract class SlideDataCopyWith<$R, $In extends SlideData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SlideOptionsCopyWith<$R, SlideOptions, SlideOptions> get options;
  $R call({String? content, SlideOptions? options});
  SlideDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SlideData, $Out>
    implements SlideDataCopyWith<$R, SlideData, $Out> {
  _SlideDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SlideData> $mapper =
      SlideDataMapper.ensureInitialized();
  @override
  SlideOptionsCopyWith<$R, SlideOptions, SlideOptions> get options =>
      $value.options.copyWith.$chain((v) => call(options: v));
  @override
  $R call({Object? content = $none, SlideOptions? options}) =>
      $apply(FieldCopyWithData({
        if (content != $none) #content: content,
        if (options != null) #options: options
      }));
  @override
  SlideData $make(CopyWithData data) => SlideData(
      content: data.get(#content, or: $value.content),
      options: data.get(#options, or: $value.options));

  @override
  SlideDataCopyWith<$R2, SlideData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideDataCopyWithImpl($value, $cast, t);
}
