// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_model.dart';

class SlideMapper extends ClassMapperBase<Slide> {
  SlideMapper._();

  static SlideMapper? _instance;
  static SlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideMapper._());
      InvalidSlideMapper.ensureInitialized();
      SlideOptionsMapper.ensureInitialized();
      SectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Slide';

  static String _$content(Slide v) => v.content;
  static const Field<Slide, String> _f$content = Field('content', _$content);
  static String _$key(Slide v) => v.key;
  static const Field<Slide, String> _f$key = Field('key', _$key);
  static SlideOptions? _$options(Slide v) => v.options;
  static const Field<Slide, SlideOptions> _f$options =
      Field('options', _$options, opt: true);
  static List<SectionPart> _$sections(Slide v) => v.sections;
  static const Field<Slide, List<SectionPart>> _f$sections =
      Field('sections', _$sections, opt: true, def: const []);

  @override
  final MappableFields<Slide> fields = const {
    #content: _f$content,
    #key: _f$key,
    #options: _f$options,
    #sections: _f$sections,
  };
  @override
  final bool ignoreNull = true;

  static Slide _instantiate(DecodingData data) {
    return Slide(
        content: data.dec(_f$content),
        key: data.dec(_f$key),
        options: data.dec(_f$options),
        sections: data.dec(_f$sections));
  }

  @override
  final Function instantiate = _instantiate;

  static Slide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Slide>(map);
  }

  static Slide fromJson(String json) {
    return ensureInitialized().decodeJson<Slide>(json);
  }
}

mixin SlideMappable {
  String toJson() {
    return SlideMapper.ensureInitialized().encodeJson<Slide>(this as Slide);
  }

  Map<String, dynamic> toMap() {
    return SlideMapper.ensureInitialized().encodeMap<Slide>(this as Slide);
  }

  SlideCopyWith<Slide, Slide, Slide> get copyWith =>
      _SlideCopyWithImpl(this as Slide, $identity, $identity);
  @override
  String toString() {
    return SlideMapper.ensureInitialized().stringifyValue(this as Slide);
  }

  @override
  bool operator ==(Object other) {
    return SlideMapper.ensureInitialized().equalsValue(this as Slide, other);
  }

  @override
  int get hashCode {
    return SlideMapper.ensureInitialized().hashValue(this as Slide);
  }
}

extension SlideValueCopy<$R, $Out> on ObjectCopyWith<$R, Slide, $Out> {
  SlideCopyWith<$R, Slide, $Out> get $asSlide =>
      $base.as((v, t, t2) => _SlideCopyWithImpl(v, t, t2));
}

abstract class SlideCopyWith<$R, $In extends Slide, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? content});
  SlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Slide, $Out>
    implements SlideCopyWith<$R, Slide, $Out> {
  _SlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Slide> $mapper = SlideMapper.ensureInitialized();
  @override
  $R call({String? content}) =>
      $apply(FieldCopyWithData({if (content != null) #content: content}));
  @override
  Slide $make(CopyWithData data) => Slide(
      content: data.get(#content, or: $value.content),
      key: data.get(#key, or: $value.key),
      options: data.get(#options, or: $value.options),
      sections: data.get(#sections, or: $value.sections));

  @override
  SlideCopyWith<$R2, Slide, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SlideCopyWithImpl($value, $cast, t);
}

class InvalidSlideMapper extends SubClassMapperBase<InvalidSlide> {
  InvalidSlideMapper._();

  static InvalidSlideMapper? _instance;
  static InvalidSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InvalidSlideMapper._());
      SlideMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'InvalidSlide';

  static String _$content(InvalidSlide v) => v.content;
  static const Field<InvalidSlide, String> _f$content =
      Field('content', _$content, key: 'message');
  static String _$key(InvalidSlide v) => v.key;
  static const Field<InvalidSlide, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);
  static List<SectionPart> _$sections(InvalidSlide v) => v.sections;
  static const Field<InvalidSlide, List<SectionPart>> _f$sections =
      Field('sections', _$sections, mode: FieldMode.member);
  static SlideOptions? _$options(InvalidSlide v) => v.options;
  static const Field<InvalidSlide, SlideOptions> _f$options =
      Field('options', _$options, mode: FieldMode.member);

  @override
  final MappableFields<InvalidSlide> fields = const {
    #content: _f$content,
    #key: _f$key,
    #sections: _f$sections,
    #options: _f$options,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'InvalidSlide';
  @override
  late final ClassMapperBase superMapper = SlideMapper.ensureInitialized();

  static InvalidSlide _instantiate(DecodingData data) {
    return InvalidSlide(data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static InvalidSlide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InvalidSlide>(map);
  }

  static InvalidSlide fromJson(String json) {
    return ensureInitialized().decodeJson<InvalidSlide>(json);
  }
}

mixin InvalidSlideMappable {
  String toJson() {
    return InvalidSlideMapper.ensureInitialized()
        .encodeJson<InvalidSlide>(this as InvalidSlide);
  }

  Map<String, dynamic> toMap() {
    return InvalidSlideMapper.ensureInitialized()
        .encodeMap<InvalidSlide>(this as InvalidSlide);
  }

  InvalidSlideCopyWith<InvalidSlide, InvalidSlide, InvalidSlide> get copyWith =>
      _InvalidSlideCopyWithImpl(this as InvalidSlide, $identity, $identity);
  @override
  String toString() {
    return InvalidSlideMapper.ensureInitialized()
        .stringifyValue(this as InvalidSlide);
  }

  @override
  bool operator ==(Object other) {
    return InvalidSlideMapper.ensureInitialized()
        .equalsValue(this as InvalidSlide, other);
  }

  @override
  int get hashCode {
    return InvalidSlideMapper.ensureInitialized()
        .hashValue(this as InvalidSlide);
  }
}

extension InvalidSlideValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InvalidSlide, $Out> {
  InvalidSlideCopyWith<$R, InvalidSlide, $Out> get $asInvalidSlide =>
      $base.as((v, t, t2) => _InvalidSlideCopyWithImpl(v, t, t2));
}

abstract class InvalidSlideCopyWith<$R, $In extends InvalidSlide, $Out>
    implements SlideCopyWith<$R, $In, $Out> {
  @override
  $R call({String? content});
  InvalidSlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _InvalidSlideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InvalidSlide, $Out>
    implements InvalidSlideCopyWith<$R, InvalidSlide, $Out> {
  _InvalidSlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InvalidSlide> $mapper =
      InvalidSlideMapper.ensureInitialized();
  @override
  $R call({String? content}) =>
      $apply(FieldCopyWithData({if (content != null) #content: content}));
  @override
  InvalidSlide $make(CopyWithData data) =>
      InvalidSlide(data.get(#content, or: $value.content));

  @override
  InvalidSlideCopyWith<$R2, InvalidSlide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _InvalidSlideCopyWithImpl($value, $cast, t);
}

class SectionDataMapper extends RecordMapperBase<SectionData> {
  static SectionDataMapper? _instance;
  SectionDataMapper._();

  static SectionDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SectionDataMapper._());
      MapperBase.addType(<A, B>(f) => f<({A content, B options})>());
    }
    return _instance!;
  }

  static String _$content(SectionData v) => v.content;
  static const Field<SectionData, String> _f$content =
      Field('content', _$content);
  static ContentOptions? _$options(SectionData v) => v.options;
  static const Field<SectionData, ContentOptions> _f$options =
      Field('options', _$options);

  @override
  final MappableFields<SectionData> fields = const {
    #content: _f$content,
    #options: _f$options,
  };

  @override
  Function get typeFactory => (f) => f<SectionData>();

  @override
  List<Type> apply(MappingContext context) {
    return [];
  }

  static SectionData _instantiate(DecodingData<SectionData> data) {
    return (content: data.dec(_f$content), options: data.dec(_f$options));
  }

  @override
  final Function instantiate = _instantiate;

  static SectionData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SectionData>(map);
  }

  static SectionData fromJson(String json) {
    return ensureInitialized().decodeJson<SectionData>(json);
  }
}

extension SectionDataMappable on SectionData {
  Map<String, dynamic> toMap() {
    return SectionDataMapper.ensureInitialized().encodeMap(this);
  }

  String toJson() {
    return SectionDataMapper.ensureInitialized().encodeJson(this);
  }

  SectionDataCopyWith<SectionData> get copyWith =>
      _SectionDataCopyWithImpl(this, $identity, $identity);
}

extension SectionDataValueCopy<$R>
    on ObjectCopyWith<$R, SectionData, SectionData> {
  SectionDataCopyWith<$R> get $asSectionData =>
      $base.as((v, t, t2) => _SectionDataCopyWithImpl(v, t, t2));
}

abstract class SectionDataCopyWith<$R>
    implements RecordCopyWith<$R, SectionData> {
  $R call({String? content, ContentOptions? options});
  SectionDataCopyWith<$R2> $chain<$R2>(Then<SectionData, $R2> t);
}

class _SectionDataCopyWithImpl<$R> extends RecordCopyWithBase<$R, SectionData>
    implements SectionDataCopyWith<$R> {
  _SectionDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final RecordMapperBase<SectionData> $mapper =
      SectionDataMapper.ensureInitialized();
  @override
  $R call({String? content, Object? options = $none}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (options != $none) #options: options
      }));
  @override
  SectionData $make(CopyWithData data) => (
        content: data.get(#content, or: $value.content),
        options: data.get(#options, or: $value.options)
      );

  @override
  SectionDataCopyWith<$R2> $chain<$R2>(Then<SectionData, $R2> t) =>
      _SectionDataCopyWithImpl($value, $cast, t);
}
