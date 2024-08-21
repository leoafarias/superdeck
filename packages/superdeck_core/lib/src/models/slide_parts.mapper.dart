// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_parts.dart';

class SectionPartTypeMapper extends EnumMapper<SectionPartType> {
  SectionPartTypeMapper._();

  static SectionPartTypeMapper? _instance;
  static SectionPartTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SectionPartTypeMapper._());
    }
    return _instance!;
  }

  static SectionPartType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SectionPartType decode(dynamic value) {
    switch (value) {
      case 'root':
        return SectionPartType.root;
      case 'header':
        return SectionPartType.header;
      case 'body':
        return SectionPartType.body;
      case 'footer':
        return SectionPartType.footer;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SectionPartType self) {
    switch (self) {
      case SectionPartType.root:
        return 'root';
      case SectionPartType.header:
        return 'header';
      case SectionPartType.body:
        return 'body';
      case SectionPartType.footer:
        return 'footer';
    }
  }
}

extension SectionPartTypeMapperExtension on SectionPartType {
  String toValue() {
    SectionPartTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SectionPartType>(this) as String;
  }
}

class SubSectionPartTypeMapper extends EnumMapper<SubSectionPartType> {
  SubSectionPartTypeMapper._();

  static SubSectionPartTypeMapper? _instance;
  static SubSectionPartTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SubSectionPartTypeMapper._());
    }
    return _instance!;
  }

  static SubSectionPartType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SubSectionPartType decode(dynamic value) {
    switch (value) {
      case 'content':
        return SubSectionPartType.content;
      case 'image':
        return SubSectionPartType.image;
      case 'widget':
        return SubSectionPartType.widget;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SubSectionPartType self) {
    switch (self) {
      case SubSectionPartType.content:
        return 'content';
      case SubSectionPartType.image:
        return 'image';
      case SubSectionPartType.widget:
        return 'widget';
    }
  }
}

extension SubSectionPartTypeMapperExtension on SubSectionPartType {
  String toValue() {
    SubSectionPartTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SubSectionPartType>(this) as String;
  }
}

class SectionPartMapper extends ClassMapperBase<SectionPart> {
  SectionPartMapper._();

  static SectionPartMapper? _instance;
  static SectionPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SectionPartMapper._());
      RootLayoutPartMapper.ensureInitialized();
      HeaderLayoutPartMapper.ensureInitialized();
      BodyLayoutPartMapper.ensureInitialized();
      FooterLayoutPartMapper.ensureInitialized();
      SectionPartTypeMapper.ensureInitialized();
      ContentOptionsMapper.ensureInitialized();
      ContentSectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SectionPart';

  static SectionPartType _$type(SectionPart v) => v.type;
  static const Field<SectionPart, SectionPartType> _f$type =
      Field('type', _$type);
  static ContentOptions _$options(SectionPart v) => v.options;
  static const Field<SectionPart, ContentOptions> _f$options =
      Field('options', _$options);
  static List<ContentSectionPart<ContentOptions>> _$contentSections(
          SectionPart v) =>
      v.contentSections;
  static const Field<SectionPart, List<ContentSectionPart<ContentOptions>>>
      _f$contentSections = Field('contentSections', _$contentSections,
          key: 'content_sections', opt: true, def: const []);

  @override
  final MappableFields<SectionPart> fields = const {
    #type: _f$type,
    #options: _f$options,
    #contentSections: _f$contentSections,
  };
  @override
  final bool ignoreNull = true;

  static SectionPart _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'SectionPart', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static SectionPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SectionPart>(map);
  }

  static SectionPart fromJson(String json) {
    return ensureInitialized().decodeJson<SectionPart>(json);
  }
}

mixin SectionPartMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SectionPartCopyWith<SectionPart, SectionPart, SectionPart> get copyWith;
}

abstract class SectionPartCopyWith<$R, $In extends SectionPart, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections;
  $R call(
      {ContentOptions? options,
      List<ContentSectionPart<ContentOptions>>? contentSections});
  SectionPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ContentSectionPartMapper extends ClassMapperBase<ContentSectionPart> {
  ContentSectionPartMapper._();

  static ContentSectionPartMapper? _instance;
  static ContentSectionPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentSectionPartMapper._());
      ContentPartMapper.ensureInitialized();
      WidgetPartMapper.ensureInitialized();
      ImagePartMapper.ensureInitialized();
      SubSectionPartTypeMapper.ensureInitialized();
      ContentOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContentSectionPart';
  @override
  Function get typeFactory =>
      <T extends ContentOptions>(f) => f<ContentSectionPart<T>>();

  static SubSectionPartType _$type(ContentSectionPart v) => v.type;
  static const Field<ContentSectionPart, SubSectionPartType> _f$type =
      Field('type', _$type);
  static String _$content(ContentSectionPart v) => v.content;
  static const Field<ContentSectionPart, String> _f$content =
      Field('content', _$content);
  static ContentOptions _$options(ContentSectionPart v) => v.options;
  static dynamic _arg$options<T extends ContentOptions>(f) => f<T>();
  static const Field<ContentSectionPart, ContentOptions> _f$options =
      Field('options', _$options, arg: _arg$options);

  @override
  final MappableFields<ContentSectionPart> fields = const {
    #type: _f$type,
    #content: _f$content,
    #options: _f$options,
  };
  @override
  final bool ignoreNull = true;

  static ContentSectionPart<T> _instantiate<T extends ContentOptions>(
      DecodingData data) {
    throw MapperException.missingSubclass(
        'ContentSectionPart', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static ContentSectionPart<T> fromMap<T extends ContentOptions>(
      Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContentSectionPart<T>>(map);
  }

  static ContentSectionPart<T> fromJson<T extends ContentOptions>(String json) {
    return ensureInitialized().decodeJson<ContentSectionPart<T>>(json);
  }
}

mixin ContentSectionPartMappable<T extends ContentOptions> {
  String toJson();
  Map<String, dynamic> toMap();
  ContentSectionPartCopyWith<ContentSectionPart<T>, ContentSectionPart<T>,
      ContentSectionPart<T>, T> get copyWith;
}

abstract class ContentSectionPartCopyWith<$R, $In extends ContentSectionPart<T>,
    $Out, T extends ContentOptions> implements ClassCopyWith<$R, $In, $Out> {
  ContentOptionsCopyWith<$R, ContentOptions, T> get options;
  $R call({String? content, T? options});
  ContentSectionPartCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class ContentPartMapper extends SubClassMapperBase<ContentPart> {
  ContentPartMapper._();

  static ContentPartMapper? _instance;
  static ContentPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentPartMapper._());
      ContentSectionPartMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContentPart';

  static String _$content(ContentPart v) => v.content;
  static const Field<ContentPart, String> _f$content =
      Field('content', _$content);
  static ContentOptions _$options(ContentPart v) => v.options;
  static const Field<ContentPart, ContentOptions> _f$options =
      Field('options', _$options);
  static SubSectionPartType _$type(ContentPart v) => v.type;
  static const Field<ContentPart, SubSectionPartType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<ContentPart> fields = const {
    #content: _f$content,
    #options: _f$options,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'content';
  @override
  late final ClassMapperBase superMapper =
      ContentSectionPartMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static ContentPart _instantiate(DecodingData data) {
    return ContentPart(
        content: data.dec(_f$content), options: data.dec(_f$options));
  }

  @override
  final Function instantiate = _instantiate;

  static ContentPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContentPart>(map);
  }

  static ContentPart fromJson(String json) {
    return ensureInitialized().decodeJson<ContentPart>(json);
  }
}

mixin ContentPartMappable {
  String toJson() {
    return ContentPartMapper.ensureInitialized()
        .encodeJson<ContentPart>(this as ContentPart);
  }

  Map<String, dynamic> toMap() {
    return ContentPartMapper.ensureInitialized()
        .encodeMap<ContentPart>(this as ContentPart);
  }

  ContentPartCopyWith<ContentPart, ContentPart, ContentPart> get copyWith =>
      _ContentPartCopyWithImpl(this as ContentPart, $identity, $identity);
  @override
  String toString() {
    return ContentPartMapper.ensureInitialized()
        .stringifyValue(this as ContentPart);
  }

  @override
  bool operator ==(Object other) {
    return ContentPartMapper.ensureInitialized()
        .equalsValue(this as ContentPart, other);
  }

  @override
  int get hashCode {
    return ContentPartMapper.ensureInitialized().hashValue(this as ContentPart);
  }
}

extension ContentPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContentPart, $Out> {
  ContentPartCopyWith<$R, ContentPart, $Out> get $asContentPart =>
      $base.as((v, t, t2) => _ContentPartCopyWithImpl(v, t, t2));
}

abstract class ContentPartCopyWith<$R, $In extends ContentPart, $Out>
    implements ContentSectionPartCopyWith<$R, $In, $Out, ContentOptions> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  @override
  $R call({String? content, ContentOptions? options});
  ContentPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ContentPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContentPart, $Out>
    implements ContentPartCopyWith<$R, ContentPart, $Out> {
  _ContentPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContentPart> $mapper =
      ContentPartMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options =>
      ($value.options as ContentOptions)
          .copyWith
          .$chain((v) => call(options: v));
  @override
  $R call({String? content, ContentOptions? options}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (options != null) #options: options
      }));
  @override
  ContentPart $make(CopyWithData data) => ContentPart(
      content: data.get(#content, or: $value.content),
      options: data.get(#options, or: $value.options));

  @override
  ContentPartCopyWith<$R2, ContentPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ContentPartCopyWithImpl($value, $cast, t);
}

class WidgetPartMapper extends SubClassMapperBase<WidgetPart> {
  WidgetPartMapper._();

  static WidgetPartMapper? _instance;
  static WidgetPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetPartMapper._());
      ContentSectionPartMapper.ensureInitialized().addSubMapper(_instance!);
      WidgetOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WidgetPart';

  static WidgetOptions _$options(WidgetPart v) => v.options;
  static const Field<WidgetPart, WidgetOptions> _f$options =
      Field('options', _$options);
  static String _$content(WidgetPart v) => v.content;
  static const Field<WidgetPart, String> _f$content =
      Field('content', _$content);
  static SubSectionPartType _$type(WidgetPart v) => v.type;
  static const Field<WidgetPart, SubSectionPartType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<WidgetPart> fields = const {
    #options: _f$options,
    #content: _f$content,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'widget';
  @override
  late final ClassMapperBase superMapper =
      ContentSectionPartMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static WidgetPart _instantiate(DecodingData data) {
    return WidgetPart(
        options: data.dec(_f$options), content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static WidgetPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WidgetPart>(map);
  }

  static WidgetPart fromJson(String json) {
    return ensureInitialized().decodeJson<WidgetPart>(json);
  }
}

mixin WidgetPartMappable {
  String toJson() {
    return WidgetPartMapper.ensureInitialized()
        .encodeJson<WidgetPart>(this as WidgetPart);
  }

  Map<String, dynamic> toMap() {
    return WidgetPartMapper.ensureInitialized()
        .encodeMap<WidgetPart>(this as WidgetPart);
  }

  WidgetPartCopyWith<WidgetPart, WidgetPart, WidgetPart> get copyWith =>
      _WidgetPartCopyWithImpl(this as WidgetPart, $identity, $identity);
  @override
  String toString() {
    return WidgetPartMapper.ensureInitialized()
        .stringifyValue(this as WidgetPart);
  }

  @override
  bool operator ==(Object other) {
    return WidgetPartMapper.ensureInitialized()
        .equalsValue(this as WidgetPart, other);
  }

  @override
  int get hashCode {
    return WidgetPartMapper.ensureInitialized().hashValue(this as WidgetPart);
  }
}

extension WidgetPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WidgetPart, $Out> {
  WidgetPartCopyWith<$R, WidgetPart, $Out> get $asWidgetPart =>
      $base.as((v, t, t2) => _WidgetPartCopyWithImpl(v, t, t2));
}

abstract class WidgetPartCopyWith<$R, $In extends WidgetPart, $Out>
    implements ContentSectionPartCopyWith<$R, $In, $Out, WidgetOptions> {
  @override
  WidgetOptionsCopyWith<$R, WidgetOptions, WidgetOptions> get options;
  @override
  $R call({WidgetOptions? options, String? content});
  WidgetPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WidgetPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WidgetPart, $Out>
    implements WidgetPartCopyWith<$R, WidgetPart, $Out> {
  _WidgetPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WidgetPart> $mapper =
      WidgetPartMapper.ensureInitialized();
  @override
  WidgetOptionsCopyWith<$R, WidgetOptions, WidgetOptions> get options =>
      ($value.options as WidgetOptions)
          .copyWith
          .$chain((v) => call(options: v));
  @override
  $R call({WidgetOptions? options, String? content}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (content != null) #content: content
      }));
  @override
  WidgetPart $make(CopyWithData data) => WidgetPart(
      options: data.get(#options, or: $value.options),
      content: data.get(#content, or: $value.content));

  @override
  WidgetPartCopyWith<$R2, WidgetPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WidgetPartCopyWithImpl($value, $cast, t);
}

class ImagePartMapper extends SubClassMapperBase<ImagePart> {
  ImagePartMapper._();

  static ImagePartMapper? _instance;
  static ImagePartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImagePartMapper._());
      ContentSectionPartMapper.ensureInitialized().addSubMapper(_instance!);
      ImageOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImagePart';

  static ImageOptions _$options(ImagePart v) => v.options;
  static const Field<ImagePart, ImageOptions> _f$options =
      Field('options', _$options);
  static String _$content(ImagePart v) => v.content;
  static const Field<ImagePart, String> _f$content =
      Field('content', _$content);
  static SubSectionPartType _$type(ImagePart v) => v.type;
  static const Field<ImagePart, SubSectionPartType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<ImagePart> fields = const {
    #options: _f$options,
    #content: _f$content,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'image';
  @override
  late final ClassMapperBase superMapper =
      ContentSectionPartMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static ImagePart _instantiate(DecodingData data) {
    return ImagePart(
        options: data.dec(_f$options), content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static ImagePart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImagePart>(map);
  }

  static ImagePart fromJson(String json) {
    return ensureInitialized().decodeJson<ImagePart>(json);
  }
}

mixin ImagePartMappable {
  String toJson() {
    return ImagePartMapper.ensureInitialized()
        .encodeJson<ImagePart>(this as ImagePart);
  }

  Map<String, dynamic> toMap() {
    return ImagePartMapper.ensureInitialized()
        .encodeMap<ImagePart>(this as ImagePart);
  }

  ImagePartCopyWith<ImagePart, ImagePart, ImagePart> get copyWith =>
      _ImagePartCopyWithImpl(this as ImagePart, $identity, $identity);
  @override
  String toString() {
    return ImagePartMapper.ensureInitialized()
        .stringifyValue(this as ImagePart);
  }

  @override
  bool operator ==(Object other) {
    return ImagePartMapper.ensureInitialized()
        .equalsValue(this as ImagePart, other);
  }

  @override
  int get hashCode {
    return ImagePartMapper.ensureInitialized().hashValue(this as ImagePart);
  }
}

extension ImagePartValueCopy<$R, $Out> on ObjectCopyWith<$R, ImagePart, $Out> {
  ImagePartCopyWith<$R, ImagePart, $Out> get $asImagePart =>
      $base.as((v, t, t2) => _ImagePartCopyWithImpl(v, t, t2));
}

abstract class ImagePartCopyWith<$R, $In extends ImagePart, $Out>
    implements ContentSectionPartCopyWith<$R, $In, $Out, ImageOptions> {
  @override
  ImageOptionsCopyWith<$R, ImageOptions, ImageOptions> get options;
  @override
  $R call({ImageOptions? options, String? content});
  ImagePartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImagePartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImagePart, $Out>
    implements ImagePartCopyWith<$R, ImagePart, $Out> {
  _ImagePartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImagePart> $mapper =
      ImagePartMapper.ensureInitialized();
  @override
  ImageOptionsCopyWith<$R, ImageOptions, ImageOptions> get options =>
      ($value.options as ImageOptions).copyWith.$chain((v) => call(options: v));
  @override
  $R call({ImageOptions? options, String? content}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (content != null) #content: content
      }));
  @override
  ImagePart $make(CopyWithData data) => ImagePart(
      options: data.get(#options, or: $value.options),
      content: data.get(#content, or: $value.content));

  @override
  ImagePartCopyWith<$R2, ImagePart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImagePartCopyWithImpl($value, $cast, t);
}

class RootLayoutPartMapper extends SubClassMapperBase<RootLayoutPart> {
  RootLayoutPartMapper._();

  static RootLayoutPartMapper? _instance;
  static RootLayoutPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RootLayoutPartMapper._());
      SectionPartMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      ContentSectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RootLayoutPart';

  static ContentOptions _$options(RootLayoutPart v) => v.options;
  static const Field<RootLayoutPart, ContentOptions> _f$options =
      Field('options', _$options);
  static List<ContentSectionPart<ContentOptions>> _$contentSections(
          RootLayoutPart v) =>
      v.contentSections;
  static const Field<RootLayoutPart, List<ContentSectionPart<ContentOptions>>>
      _f$contentSections = Field('contentSections', _$contentSections,
          key: 'content_sections', opt: true, def: const []);
  static SectionPartType _$type(RootLayoutPart v) => v.type;
  static const Field<RootLayoutPart, SectionPartType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<RootLayoutPart> fields = const {
    #options: _f$options,
    #contentSections: _f$contentSections,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'root';
  @override
  late final ClassMapperBase superMapper =
      SectionPartMapper.ensureInitialized();

  static RootLayoutPart _instantiate(DecodingData data) {
    return RootLayoutPart(
        options: data.dec(_f$options),
        contentSections: data.dec(_f$contentSections));
  }

  @override
  final Function instantiate = _instantiate;

  static RootLayoutPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RootLayoutPart>(map);
  }

  static RootLayoutPart fromJson(String json) {
    return ensureInitialized().decodeJson<RootLayoutPart>(json);
  }
}

mixin RootLayoutPartMappable {
  String toJson() {
    return RootLayoutPartMapper.ensureInitialized()
        .encodeJson<RootLayoutPart>(this as RootLayoutPart);
  }

  Map<String, dynamic> toMap() {
    return RootLayoutPartMapper.ensureInitialized()
        .encodeMap<RootLayoutPart>(this as RootLayoutPart);
  }

  RootLayoutPartCopyWith<RootLayoutPart, RootLayoutPart, RootLayoutPart>
      get copyWith => _RootLayoutPartCopyWithImpl(
          this as RootLayoutPart, $identity, $identity);
  @override
  String toString() {
    return RootLayoutPartMapper.ensureInitialized()
        .stringifyValue(this as RootLayoutPart);
  }

  @override
  bool operator ==(Object other) {
    return RootLayoutPartMapper.ensureInitialized()
        .equalsValue(this as RootLayoutPart, other);
  }

  @override
  int get hashCode {
    return RootLayoutPartMapper.ensureInitialized()
        .hashValue(this as RootLayoutPart);
  }
}

extension RootLayoutPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RootLayoutPart, $Out> {
  RootLayoutPartCopyWith<$R, RootLayoutPart, $Out> get $asRootLayoutPart =>
      $base.as((v, t, t2) => _RootLayoutPartCopyWithImpl(v, t, t2));
}

abstract class RootLayoutPartCopyWith<$R, $In extends RootLayoutPart, $Out>
    implements SectionPartCopyWith<$R, $In, $Out> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections;
  @override
  $R call(
      {ContentOptions? options,
      List<ContentSectionPart<ContentOptions>>? contentSections});
  RootLayoutPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RootLayoutPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RootLayoutPart, $Out>
    implements RootLayoutPartCopyWith<$R, RootLayoutPart, $Out> {
  _RootLayoutPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RootLayoutPart> $mapper =
      RootLayoutPartMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options =>
      $value.options.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections => ListCopyWith(
      $value.contentSections,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(contentSections: v));
  @override
  $R call(
          {ContentOptions? options,
          List<ContentSectionPart<ContentOptions>>? contentSections}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (contentSections != null) #contentSections: contentSections
      }));
  @override
  RootLayoutPart $make(CopyWithData data) => RootLayoutPart(
      options: data.get(#options, or: $value.options),
      contentSections: data.get(#contentSections, or: $value.contentSections));

  @override
  RootLayoutPartCopyWith<$R2, RootLayoutPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RootLayoutPartCopyWithImpl($value, $cast, t);
}

class HeaderLayoutPartMapper extends SubClassMapperBase<HeaderLayoutPart> {
  HeaderLayoutPartMapper._();

  static HeaderLayoutPartMapper? _instance;
  static HeaderLayoutPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HeaderLayoutPartMapper._());
      SectionPartMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      ContentSectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HeaderLayoutPart';

  static ContentOptions _$options(HeaderLayoutPart v) => v.options;
  static const Field<HeaderLayoutPart, ContentOptions> _f$options =
      Field('options', _$options);
  static List<ContentSectionPart<ContentOptions>> _$contentSections(
          HeaderLayoutPart v) =>
      v.contentSections;
  static const Field<HeaderLayoutPart, List<ContentSectionPart<ContentOptions>>>
      _f$contentSections = Field('contentSections', _$contentSections,
          key: 'content_sections', opt: true, def: const []);
  static SectionPartType _$type(HeaderLayoutPart v) => v.type;
  static const Field<HeaderLayoutPart, SectionPartType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<HeaderLayoutPart> fields = const {
    #options: _f$options,
    #contentSections: _f$contentSections,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'header';
  @override
  late final ClassMapperBase superMapper =
      SectionPartMapper.ensureInitialized();

  static HeaderLayoutPart _instantiate(DecodingData data) {
    return HeaderLayoutPart(
        options: data.dec(_f$options),
        contentSections: data.dec(_f$contentSections));
  }

  @override
  final Function instantiate = _instantiate;

  static HeaderLayoutPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HeaderLayoutPart>(map);
  }

  static HeaderLayoutPart fromJson(String json) {
    return ensureInitialized().decodeJson<HeaderLayoutPart>(json);
  }
}

mixin HeaderLayoutPartMappable {
  String toJson() {
    return HeaderLayoutPartMapper.ensureInitialized()
        .encodeJson<HeaderLayoutPart>(this as HeaderLayoutPart);
  }

  Map<String, dynamic> toMap() {
    return HeaderLayoutPartMapper.ensureInitialized()
        .encodeMap<HeaderLayoutPart>(this as HeaderLayoutPart);
  }

  HeaderLayoutPartCopyWith<HeaderLayoutPart, HeaderLayoutPart, HeaderLayoutPart>
      get copyWith => _HeaderLayoutPartCopyWithImpl(
          this as HeaderLayoutPart, $identity, $identity);
  @override
  String toString() {
    return HeaderLayoutPartMapper.ensureInitialized()
        .stringifyValue(this as HeaderLayoutPart);
  }

  @override
  bool operator ==(Object other) {
    return HeaderLayoutPartMapper.ensureInitialized()
        .equalsValue(this as HeaderLayoutPart, other);
  }

  @override
  int get hashCode {
    return HeaderLayoutPartMapper.ensureInitialized()
        .hashValue(this as HeaderLayoutPart);
  }
}

extension HeaderLayoutPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HeaderLayoutPart, $Out> {
  HeaderLayoutPartCopyWith<$R, HeaderLayoutPart, $Out>
      get $asHeaderLayoutPart =>
          $base.as((v, t, t2) => _HeaderLayoutPartCopyWithImpl(v, t, t2));
}

abstract class HeaderLayoutPartCopyWith<$R, $In extends HeaderLayoutPart, $Out>
    implements SectionPartCopyWith<$R, $In, $Out> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections;
  @override
  $R call(
      {ContentOptions? options,
      List<ContentSectionPart<ContentOptions>>? contentSections});
  HeaderLayoutPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _HeaderLayoutPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HeaderLayoutPart, $Out>
    implements HeaderLayoutPartCopyWith<$R, HeaderLayoutPart, $Out> {
  _HeaderLayoutPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HeaderLayoutPart> $mapper =
      HeaderLayoutPartMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options =>
      $value.options.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections => ListCopyWith(
      $value.contentSections,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(contentSections: v));
  @override
  $R call(
          {ContentOptions? options,
          List<ContentSectionPart<ContentOptions>>? contentSections}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (contentSections != null) #contentSections: contentSections
      }));
  @override
  HeaderLayoutPart $make(CopyWithData data) => HeaderLayoutPart(
      options: data.get(#options, or: $value.options),
      contentSections: data.get(#contentSections, or: $value.contentSections));

  @override
  HeaderLayoutPartCopyWith<$R2, HeaderLayoutPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HeaderLayoutPartCopyWithImpl($value, $cast, t);
}

class BodyLayoutPartMapper extends SubClassMapperBase<BodyLayoutPart> {
  BodyLayoutPartMapper._();

  static BodyLayoutPartMapper? _instance;
  static BodyLayoutPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BodyLayoutPartMapper._());
      SectionPartMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      ContentSectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BodyLayoutPart';

  static ContentOptions _$options(BodyLayoutPart v) => v.options;
  static const Field<BodyLayoutPart, ContentOptions> _f$options =
      Field('options', _$options);
  static List<ContentSectionPart<ContentOptions>> _$contentSections(
          BodyLayoutPart v) =>
      v.contentSections;
  static const Field<BodyLayoutPart, List<ContentSectionPart<ContentOptions>>>
      _f$contentSections = Field('contentSections', _$contentSections,
          key: 'content_sections', opt: true, def: const []);
  static SectionPartType _$type(BodyLayoutPart v) => v.type;
  static const Field<BodyLayoutPart, SectionPartType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<BodyLayoutPart> fields = const {
    #options: _f$options,
    #contentSections: _f$contentSections,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'body';
  @override
  late final ClassMapperBase superMapper =
      SectionPartMapper.ensureInitialized();

  static BodyLayoutPart _instantiate(DecodingData data) {
    return BodyLayoutPart(
        options: data.dec(_f$options),
        contentSections: data.dec(_f$contentSections));
  }

  @override
  final Function instantiate = _instantiate;

  static BodyLayoutPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BodyLayoutPart>(map);
  }

  static BodyLayoutPart fromJson(String json) {
    return ensureInitialized().decodeJson<BodyLayoutPart>(json);
  }
}

mixin BodyLayoutPartMappable {
  String toJson() {
    return BodyLayoutPartMapper.ensureInitialized()
        .encodeJson<BodyLayoutPart>(this as BodyLayoutPart);
  }

  Map<String, dynamic> toMap() {
    return BodyLayoutPartMapper.ensureInitialized()
        .encodeMap<BodyLayoutPart>(this as BodyLayoutPart);
  }

  BodyLayoutPartCopyWith<BodyLayoutPart, BodyLayoutPart, BodyLayoutPart>
      get copyWith => _BodyLayoutPartCopyWithImpl(
          this as BodyLayoutPart, $identity, $identity);
  @override
  String toString() {
    return BodyLayoutPartMapper.ensureInitialized()
        .stringifyValue(this as BodyLayoutPart);
  }

  @override
  bool operator ==(Object other) {
    return BodyLayoutPartMapper.ensureInitialized()
        .equalsValue(this as BodyLayoutPart, other);
  }

  @override
  int get hashCode {
    return BodyLayoutPartMapper.ensureInitialized()
        .hashValue(this as BodyLayoutPart);
  }
}

extension BodyLayoutPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BodyLayoutPart, $Out> {
  BodyLayoutPartCopyWith<$R, BodyLayoutPart, $Out> get $asBodyLayoutPart =>
      $base.as((v, t, t2) => _BodyLayoutPartCopyWithImpl(v, t, t2));
}

abstract class BodyLayoutPartCopyWith<$R, $In extends BodyLayoutPart, $Out>
    implements SectionPartCopyWith<$R, $In, $Out> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections;
  @override
  $R call(
      {ContentOptions? options,
      List<ContentSectionPart<ContentOptions>>? contentSections});
  BodyLayoutPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BodyLayoutPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BodyLayoutPart, $Out>
    implements BodyLayoutPartCopyWith<$R, BodyLayoutPart, $Out> {
  _BodyLayoutPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BodyLayoutPart> $mapper =
      BodyLayoutPartMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options =>
      $value.options.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections => ListCopyWith(
      $value.contentSections,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(contentSections: v));
  @override
  $R call(
          {ContentOptions? options,
          List<ContentSectionPart<ContentOptions>>? contentSections}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (contentSections != null) #contentSections: contentSections
      }));
  @override
  BodyLayoutPart $make(CopyWithData data) => BodyLayoutPart(
      options: data.get(#options, or: $value.options),
      contentSections: data.get(#contentSections, or: $value.contentSections));

  @override
  BodyLayoutPartCopyWith<$R2, BodyLayoutPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BodyLayoutPartCopyWithImpl($value, $cast, t);
}

class FooterLayoutPartMapper extends SubClassMapperBase<FooterLayoutPart> {
  FooterLayoutPartMapper._();

  static FooterLayoutPartMapper? _instance;
  static FooterLayoutPartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FooterLayoutPartMapper._());
      SectionPartMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      ContentSectionPartMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FooterLayoutPart';

  static ContentOptions _$options(FooterLayoutPart v) => v.options;
  static const Field<FooterLayoutPart, ContentOptions> _f$options =
      Field('options', _$options);
  static List<ContentSectionPart<ContentOptions>> _$contentSections(
          FooterLayoutPart v) =>
      v.contentSections;
  static const Field<FooterLayoutPart, List<ContentSectionPart<ContentOptions>>>
      _f$contentSections = Field('contentSections', _$contentSections,
          key: 'content_sections', opt: true, def: const []);
  static SectionPartType _$type(FooterLayoutPart v) => v.type;
  static const Field<FooterLayoutPart, SectionPartType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<FooterLayoutPart> fields = const {
    #options: _f$options,
    #contentSections: _f$contentSections,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'footer';
  @override
  late final ClassMapperBase superMapper =
      SectionPartMapper.ensureInitialized();

  static FooterLayoutPart _instantiate(DecodingData data) {
    return FooterLayoutPart(
        options: data.dec(_f$options),
        contentSections: data.dec(_f$contentSections));
  }

  @override
  final Function instantiate = _instantiate;

  static FooterLayoutPart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FooterLayoutPart>(map);
  }

  static FooterLayoutPart fromJson(String json) {
    return ensureInitialized().decodeJson<FooterLayoutPart>(json);
  }
}

mixin FooterLayoutPartMappable {
  String toJson() {
    return FooterLayoutPartMapper.ensureInitialized()
        .encodeJson<FooterLayoutPart>(this as FooterLayoutPart);
  }

  Map<String, dynamic> toMap() {
    return FooterLayoutPartMapper.ensureInitialized()
        .encodeMap<FooterLayoutPart>(this as FooterLayoutPart);
  }

  FooterLayoutPartCopyWith<FooterLayoutPart, FooterLayoutPart, FooterLayoutPart>
      get copyWith => _FooterLayoutPartCopyWithImpl(
          this as FooterLayoutPart, $identity, $identity);
  @override
  String toString() {
    return FooterLayoutPartMapper.ensureInitialized()
        .stringifyValue(this as FooterLayoutPart);
  }

  @override
  bool operator ==(Object other) {
    return FooterLayoutPartMapper.ensureInitialized()
        .equalsValue(this as FooterLayoutPart, other);
  }

  @override
  int get hashCode {
    return FooterLayoutPartMapper.ensureInitialized()
        .hashValue(this as FooterLayoutPart);
  }
}

extension FooterLayoutPartValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FooterLayoutPart, $Out> {
  FooterLayoutPartCopyWith<$R, FooterLayoutPart, $Out>
      get $asFooterLayoutPart =>
          $base.as((v, t, t2) => _FooterLayoutPartCopyWithImpl(v, t, t2));
}

abstract class FooterLayoutPartCopyWith<$R, $In extends FooterLayoutPart, $Out>
    implements SectionPartCopyWith<$R, $In, $Out> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options;
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections;
  @override
  $R call(
      {ContentOptions? options,
      List<ContentSectionPart<ContentOptions>>? contentSections});
  FooterLayoutPartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FooterLayoutPartCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FooterLayoutPart, $Out>
    implements FooterLayoutPartCopyWith<$R, FooterLayoutPart, $Out> {
  _FooterLayoutPartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FooterLayoutPart> $mapper =
      FooterLayoutPartMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions> get options =>
      $value.options.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<
      $R,
      ContentSectionPart<ContentOptions>,
      ContentSectionPartCopyWith<
          $R,
          ContentSectionPart<ContentOptions>,
          ContentSectionPart<ContentOptions>,
          ContentOptions>> get contentSections => ListCopyWith(
      $value.contentSections,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(contentSections: v));
  @override
  $R call(
          {ContentOptions? options,
          List<ContentSectionPart<ContentOptions>>? contentSections}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (contentSections != null) #contentSections: contentSections
      }));
  @override
  FooterLayoutPart $make(CopyWithData data) => FooterLayoutPart(
      options: data.get(#options, or: $value.options),
      contentSections: data.get(#contentSections, or: $value.contentSections));

  @override
  FooterLayoutPartCopyWith<$R2, FooterLayoutPart, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FooterLayoutPartCopyWithImpl($value, $cast, t);
}
