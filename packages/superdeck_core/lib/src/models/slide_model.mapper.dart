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
      SlideOptionsMapper.ensureInitialized();
      SectionBlockMapper.ensureInitialized();
      SlideNoteMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Slide';

  static String _$key(Slide v) => v.key;
  static const Field<Slide, String> _f$key = Field('key', _$key);
  static SlideOptions? _$options(Slide v) => v.options;
  static const Field<Slide, SlideOptions> _f$options =
      Field('options', _$options, opt: true);
  static String _$markdown(Slide v) => v.markdown;
  static const Field<Slide, String> _f$markdown = Field('markdown', _$markdown);
  static List<SectionBlock> _$sections(Slide v) => v.sections;
  static const Field<Slide, List<SectionBlock>> _f$sections =
      Field('sections', _$sections, opt: true, def: const []);
  static List<SlideNote> _$notes(Slide v) => v.notes;
  static const Field<Slide, List<SlideNote>> _f$notes =
      Field('notes', _$notes, opt: true, def: const []);

  @override
  final MappableFields<Slide> fields = const {
    #key: _f$key,
    #options: _f$options,
    #markdown: _f$markdown,
    #sections: _f$sections,
    #notes: _f$notes,
  };
  @override
  final bool ignoreNull = true;

  static Slide _instantiate(DecodingData data) {
    return Slide(
        key: data.dec(_f$key),
        options: data.dec(_f$options),
        markdown: data.dec(_f$markdown),
        sections: data.dec(_f$sections),
        notes: data.dec(_f$notes));
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
  SlideOptionsCopyWith<$R, SlideOptions, SlideOptions>? get options;
  ListCopyWith<$R, SectionBlock,
      SectionBlockCopyWith<$R, SectionBlock, SectionBlock>> get sections;
  ListCopyWith<$R, SlideNote, SlideNoteCopyWith<$R, SlideNote, SlideNote>>
      get notes;
  $R call(
      {String? key,
      SlideOptions? options,
      String? markdown,
      List<SectionBlock>? sections,
      List<SlideNote>? notes});
  SlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Slide, $Out>
    implements SlideCopyWith<$R, Slide, $Out> {
  _SlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Slide> $mapper = SlideMapper.ensureInitialized();
  @override
  SlideOptionsCopyWith<$R, SlideOptions, SlideOptions>? get options =>
      $value.options?.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<$R, SectionBlock,
          SectionBlockCopyWith<$R, SectionBlock, SectionBlock>>
      get sections => ListCopyWith($value.sections,
          (v, t) => v.copyWith.$chain(t), (v) => call(sections: v));
  @override
  ListCopyWith<$R, SlideNote, SlideNoteCopyWith<$R, SlideNote, SlideNote>>
      get notes => ListCopyWith(
          $value.notes, (v, t) => v.copyWith.$chain(t), (v) => call(notes: v));
  @override
  $R call(
          {String? key,
          Object? options = $none,
          String? markdown,
          List<SectionBlock>? sections,
          List<SlideNote>? notes}) =>
      $apply(FieldCopyWithData({
        if (key != null) #key: key,
        if (options != $none) #options: options,
        if (markdown != null) #markdown: markdown,
        if (sections != null) #sections: sections,
        if (notes != null) #notes: notes
      }));
  @override
  Slide $make(CopyWithData data) => Slide(
      key: data.get(#key, or: $value.key),
      options: data.get(#options, or: $value.options),
      markdown: data.get(#markdown, or: $value.markdown),
      sections: data.get(#sections, or: $value.sections),
      notes: data.get(#notes, or: $value.notes));

  @override
  SlideCopyWith<$R2, Slide, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SlideCopyWithImpl($value, $cast, t);
}

class SlideNoteMapper extends ClassMapperBase<SlideNote> {
  SlideNoteMapper._();

  static SlideNoteMapper? _instance;
  static SlideNoteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideNoteMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SlideNote';

  static String _$content(SlideNote v) => v.content;
  static const Field<SlideNote, String> _f$content =
      Field('content', _$content);

  @override
  final MappableFields<SlideNote> fields = const {
    #content: _f$content,
  };
  @override
  final bool ignoreNull = true;

  static SlideNote _instantiate(DecodingData data) {
    return SlideNote(content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static SlideNote fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideNote>(map);
  }

  static SlideNote fromJson(String json) {
    return ensureInitialized().decodeJson<SlideNote>(json);
  }
}

mixin SlideNoteMappable {
  String toJson() {
    return SlideNoteMapper.ensureInitialized()
        .encodeJson<SlideNote>(this as SlideNote);
  }

  Map<String, dynamic> toMap() {
    return SlideNoteMapper.ensureInitialized()
        .encodeMap<SlideNote>(this as SlideNote);
  }

  SlideNoteCopyWith<SlideNote, SlideNote, SlideNote> get copyWith =>
      _SlideNoteCopyWithImpl(this as SlideNote, $identity, $identity);
  @override
  String toString() {
    return SlideNoteMapper.ensureInitialized()
        .stringifyValue(this as SlideNote);
  }

  @override
  bool operator ==(Object other) {
    return SlideNoteMapper.ensureInitialized()
        .equalsValue(this as SlideNote, other);
  }

  @override
  int get hashCode {
    return SlideNoteMapper.ensureInitialized().hashValue(this as SlideNote);
  }
}

extension SlideNoteValueCopy<$R, $Out> on ObjectCopyWith<$R, SlideNote, $Out> {
  SlideNoteCopyWith<$R, SlideNote, $Out> get $asSlideNote =>
      $base.as((v, t, t2) => _SlideNoteCopyWithImpl(v, t, t2));
}

abstract class SlideNoteCopyWith<$R, $In extends SlideNote, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? content});
  SlideNoteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideNoteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SlideNote, $Out>
    implements SlideNoteCopyWith<$R, SlideNote, $Out> {
  _SlideNoteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SlideNote> $mapper =
      SlideNoteMapper.ensureInitialized();
  @override
  $R call({String? content}) =>
      $apply(FieldCopyWithData({if (content != null) #content: content}));
  @override
  SlideNote $make(CopyWithData data) =>
      SlideNote(content: data.get(#content, or: $value.content));

  @override
  SlideNoteCopyWith<$R2, SlideNote, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideNoteCopyWithImpl($value, $cast, t);
}
