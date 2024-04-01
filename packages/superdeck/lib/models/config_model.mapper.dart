// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'config_model.dart';

class SlideOptionsMapper extends ClassMapperBase<SlideOptions> {
  SlideOptionsMapper._();

  static SlideOptionsMapper? _instance;
  static SlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideOptionsMapper._());
      BaseSlideOptionsMapper.ensureInitialized();
      ImageSlideOptionsMapper.ensureInitialized();
      TwoColumnSlideOptionsMapper.ensureInitialized();
      TwoColumnHeaderSlideOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideOptions';

  static String? _$title(SlideOptions v) => v.title;
  static const Field<SlideOptions, String> _f$title = Field('title', _$title);
  static String? _$background(SlideOptions v) => v.background;
  static const Field<SlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static String _$content(SlideOptions v) => v.content;
  static const Field<SlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$variant(SlideOptions v) => v.variant;
  static const Field<SlideOptions, String> _f$variant =
      Field('variant', _$variant);
  static ContentAlignment _$contentAlignment(SlideOptions v) =>
      v.contentAlignment;
  static const Field<SlideOptions, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment',
          opt: true,
          def: ContentAlignment.centerLeft);

  @override
  final MappableFields<SlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #content: _f$content,
    #variant: _f$variant,
    #contentAlignment: _f$contentAlignment,
  };

  static SlideOptions _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('SlideOptions');
  }

  @override
  final Function instantiate = _instantiate;

  static SlideOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideOptions>(map);
  }

  static SlideOptions fromJson(String json) {
    return ensureInitialized().decodeJson<SlideOptions>(json);
  }
}

mixin SlideOptionsMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SlideOptionsCopyWith<SlideOptions, SlideOptions, SlideOptions> get copyWith;
}

abstract class SlideOptionsCopyWith<$R, $In extends SlideOptions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? title,
      String? background,
      String? content,
      String? variant,
      ContentAlignment? contentAlignment});
  SlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class BaseSlideOptionsMapper extends ClassMapperBase<BaseSlideOptions> {
  BaseSlideOptionsMapper._();

  static BaseSlideOptionsMapper? _instance;
  static BaseSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BaseSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BaseSlideOptions';

  static String? _$title(BaseSlideOptions v) => v.title;
  static const Field<BaseSlideOptions, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(BaseSlideOptions v) => v.background;
  static const Field<BaseSlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(BaseSlideOptions v) =>
      v.contentAlignment;
  static const Field<BaseSlideOptions, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment',
          opt: true,
          def: ContentAlignment.centerLeft);
  static String _$content(BaseSlideOptions v) => v.content;
  static const Field<BaseSlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$variant(BaseSlideOptions v) => v.variant;
  static const Field<BaseSlideOptions, String> _f$variant =
      Field('variant', _$variant, opt: true);

  @override
  final MappableFields<BaseSlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #variant: _f$variant,
  };

  static BaseSlideOptions _instantiate(DecodingData data) {
    return BaseSlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        variant: data.dec(_f$variant));
  }

  @override
  final Function instantiate = _instantiate;

  static BaseSlideOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BaseSlideOptions>(map);
  }

  static BaseSlideOptions fromJson(String json) {
    return ensureInitialized().decodeJson<BaseSlideOptions>(json);
  }
}

mixin BaseSlideOptionsMappable {
  String toJson() {
    return BaseSlideOptionsMapper.ensureInitialized()
        .encodeJson<BaseSlideOptions>(this as BaseSlideOptions);
  }

  Map<String, dynamic> toMap() {
    return BaseSlideOptionsMapper.ensureInitialized()
        .encodeMap<BaseSlideOptions>(this as BaseSlideOptions);
  }

  BaseSlideOptionsCopyWith<BaseSlideOptions, BaseSlideOptions, BaseSlideOptions>
      get copyWith => _BaseSlideOptionsCopyWithImpl(
          this as BaseSlideOptions, $identity, $identity);
  @override
  String toString() {
    return BaseSlideOptionsMapper.ensureInitialized()
        .stringifyValue(this as BaseSlideOptions);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BaseSlideOptionsMapper.ensureInitialized()
                .isValueEqual(this as BaseSlideOptions, other));
  }

  @override
  int get hashCode {
    return BaseSlideOptionsMapper.ensureInitialized()
        .hashValue(this as BaseSlideOptions);
  }
}

extension BaseSlideOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BaseSlideOptions, $Out> {
  BaseSlideOptionsCopyWith<$R, BaseSlideOptions, $Out>
      get $asBaseSlideOptions =>
          $base.as((v, t, t2) => _BaseSlideOptionsCopyWithImpl(v, t, t2));
}

abstract class BaseSlideOptionsCopyWith<$R, $In extends BaseSlideOptions, $Out>
    implements SlideOptionsCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? contentAlignment,
      String? content,
      String? variant});
  BaseSlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BaseSlideOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BaseSlideOptions, $Out>
    implements BaseSlideOptionsCopyWith<$R, BaseSlideOptions, $Out> {
  _BaseSlideOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BaseSlideOptions> $mapper =
      BaseSlideOptionsMapper.ensureInitialized();
  @override
  $R call(
          {Object? title = $none,
          Object? background = $none,
          ContentAlignment? contentAlignment,
          String? content,
          Object? variant = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content,
        if (variant != $none) #variant: variant
      }));
  @override
  BaseSlideOptions $make(CopyWithData data) => BaseSlideOptions(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content),
      variant: data.get(#variant, or: $value.variant));

  @override
  BaseSlideOptionsCopyWith<$R2, BaseSlideOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BaseSlideOptionsCopyWithImpl($value, $cast, t);
}

class ImageSlideOptionsMapper extends ClassMapperBase<ImageSlideOptions> {
  ImageSlideOptionsMapper._();

  static ImageSlideOptionsMapper? _instance;
  static ImageSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized();
      ImageOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageSlideOptions';

  static String? _$title(ImageSlideOptions v) => v.title;
  static const Field<ImageSlideOptions, String> _f$title =
      Field('title', _$title, opt: true);
  static ImageOptions _$image(ImageSlideOptions v) => v.image;
  static const Field<ImageSlideOptions, ImageOptions> _f$image =
      Field('image', _$image);
  static String? _$variant(ImageSlideOptions v) => v.variant;
  static const Field<ImageSlideOptions, String> _f$variant =
      Field('variant', _$variant, opt: true);
  static String? _$background(ImageSlideOptions v) => v.background;
  static const Field<ImageSlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static String _$content(ImageSlideOptions v) => v.content;
  static const Field<ImageSlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static ContentAlignment _$contentAlignment(ImageSlideOptions v) =>
      v.contentAlignment;
  static const Field<ImageSlideOptions, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment',
          opt: true,
          def: ContentAlignment.centerLeft);

  @override
  final MappableFields<ImageSlideOptions> fields = const {
    #title: _f$title,
    #image: _f$image,
    #variant: _f$variant,
    #background: _f$background,
    #content: _f$content,
    #contentAlignment: _f$contentAlignment,
  };

  static ImageSlideOptions _instantiate(DecodingData data) {
    return ImageSlideOptions(
        title: data.dec(_f$title),
        image: data.dec(_f$image),
        variant: data.dec(_f$variant),
        background: data.dec(_f$background),
        content: data.dec(_f$content),
        contentAlignment: data.dec(_f$contentAlignment));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageSlideOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageSlideOptions>(map);
  }

  static ImageSlideOptions fromJson(String json) {
    return ensureInitialized().decodeJson<ImageSlideOptions>(json);
  }
}

mixin ImageSlideOptionsMappable {
  String toJson() {
    return ImageSlideOptionsMapper.ensureInitialized()
        .encodeJson<ImageSlideOptions>(this as ImageSlideOptions);
  }

  Map<String, dynamic> toMap() {
    return ImageSlideOptionsMapper.ensureInitialized()
        .encodeMap<ImageSlideOptions>(this as ImageSlideOptions);
  }

  ImageSlideOptionsCopyWith<ImageSlideOptions, ImageSlideOptions,
          ImageSlideOptions>
      get copyWith => _ImageSlideOptionsCopyWithImpl(
          this as ImageSlideOptions, $identity, $identity);
  @override
  String toString() {
    return ImageSlideOptionsMapper.ensureInitialized()
        .stringifyValue(this as ImageSlideOptions);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ImageSlideOptionsMapper.ensureInitialized()
                .isValueEqual(this as ImageSlideOptions, other));
  }

  @override
  int get hashCode {
    return ImageSlideOptionsMapper.ensureInitialized()
        .hashValue(this as ImageSlideOptions);
  }
}

extension ImageSlideOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageSlideOptions, $Out> {
  ImageSlideOptionsCopyWith<$R, ImageSlideOptions, $Out>
      get $asImageSlideOptions =>
          $base.as((v, t, t2) => _ImageSlideOptionsCopyWithImpl(v, t, t2));
}

abstract class ImageSlideOptionsCopyWith<$R, $In extends ImageSlideOptions,
    $Out> implements SlideOptionsCopyWith<$R, $In, $Out> {
  ImageOptionsCopyWith<$R, ImageOptions, ImageOptions> get image;
  @override
  $R call(
      {String? title,
      ImageOptions? image,
      String? variant,
      String? background,
      String? content,
      ContentAlignment? contentAlignment});
  ImageSlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ImageSlideOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageSlideOptions, $Out>
    implements ImageSlideOptionsCopyWith<$R, ImageSlideOptions, $Out> {
  _ImageSlideOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageSlideOptions> $mapper =
      ImageSlideOptionsMapper.ensureInitialized();
  @override
  ImageOptionsCopyWith<$R, ImageOptions, ImageOptions> get image =>
      $value.image.copyWith.$chain((v) => call(image: v));
  @override
  $R call(
          {Object? title = $none,
          ImageOptions? image,
          Object? variant = $none,
          Object? background = $none,
          String? content,
          ContentAlignment? contentAlignment}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (image != null) #image: image,
        if (variant != $none) #variant: variant,
        if (background != $none) #background: background,
        if (content != null) #content: content,
        if (contentAlignment != null) #contentAlignment: contentAlignment
      }));
  @override
  ImageSlideOptions $make(CopyWithData data) => ImageSlideOptions(
      title: data.get(#title, or: $value.title),
      image: data.get(#image, or: $value.image),
      variant: data.get(#variant, or: $value.variant),
      background: data.get(#background, or: $value.background),
      content: data.get(#content, or: $value.content),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment));

  @override
  ImageSlideOptionsCopyWith<$R2, ImageSlideOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageSlideOptionsCopyWithImpl($value, $cast, t);
}

class TwoColumnSlideOptionsMapper
    extends ClassMapperBase<TwoColumnSlideOptions> {
  TwoColumnSlideOptionsMapper._();

  static TwoColumnSlideOptionsMapper? _instance;
  static TwoColumnSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TwoColumnSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TwoColumnSlideOptions';

  static String? _$title(TwoColumnSlideOptions v) => v.title;
  static const Field<TwoColumnSlideOptions, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(TwoColumnSlideOptions v) => v.background;
  static const Field<TwoColumnSlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(TwoColumnSlideOptions v) =>
      v.contentAlignment;
  static const Field<TwoColumnSlideOptions, ContentAlignment>
      _f$contentAlignment = Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment',
          opt: true,
          def: ContentAlignment.centerLeft);
  static String _$content(TwoColumnSlideOptions v) => v.content;
  static const Field<TwoColumnSlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$variant(TwoColumnSlideOptions v) => v.variant;
  static const Field<TwoColumnSlideOptions, String> _f$variant =
      Field('variant', _$variant, opt: true);

  @override
  final MappableFields<TwoColumnSlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #variant: _f$variant,
  };

  static TwoColumnSlideOptions _instantiate(DecodingData data) {
    return TwoColumnSlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        variant: data.dec(_f$variant));
  }

  @override
  final Function instantiate = _instantiate;

  static TwoColumnSlideOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TwoColumnSlideOptions>(map);
  }

  static TwoColumnSlideOptions fromJson(String json) {
    return ensureInitialized().decodeJson<TwoColumnSlideOptions>(json);
  }
}

mixin TwoColumnSlideOptionsMappable {
  String toJson() {
    return TwoColumnSlideOptionsMapper.ensureInitialized()
        .encodeJson<TwoColumnSlideOptions>(this as TwoColumnSlideOptions);
  }

  Map<String, dynamic> toMap() {
    return TwoColumnSlideOptionsMapper.ensureInitialized()
        .encodeMap<TwoColumnSlideOptions>(this as TwoColumnSlideOptions);
  }

  TwoColumnSlideOptionsCopyWith<TwoColumnSlideOptions, TwoColumnSlideOptions,
          TwoColumnSlideOptions>
      get copyWith => _TwoColumnSlideOptionsCopyWithImpl(
          this as TwoColumnSlideOptions, $identity, $identity);
  @override
  String toString() {
    return TwoColumnSlideOptionsMapper.ensureInitialized()
        .stringifyValue(this as TwoColumnSlideOptions);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TwoColumnSlideOptionsMapper.ensureInitialized()
                .isValueEqual(this as TwoColumnSlideOptions, other));
  }

  @override
  int get hashCode {
    return TwoColumnSlideOptionsMapper.ensureInitialized()
        .hashValue(this as TwoColumnSlideOptions);
  }
}

extension TwoColumnSlideOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TwoColumnSlideOptions, $Out> {
  TwoColumnSlideOptionsCopyWith<$R, TwoColumnSlideOptions, $Out>
      get $asTwoColumnSlideOptions =>
          $base.as((v, t, t2) => _TwoColumnSlideOptionsCopyWithImpl(v, t, t2));
}

abstract class TwoColumnSlideOptionsCopyWith<
    $R,
    $In extends TwoColumnSlideOptions,
    $Out> implements SlideOptionsCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? contentAlignment,
      String? content,
      String? variant});
  TwoColumnSlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TwoColumnSlideOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TwoColumnSlideOptions, $Out>
    implements TwoColumnSlideOptionsCopyWith<$R, TwoColumnSlideOptions, $Out> {
  _TwoColumnSlideOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TwoColumnSlideOptions> $mapper =
      TwoColumnSlideOptionsMapper.ensureInitialized();
  @override
  $R call(
          {Object? title = $none,
          Object? background = $none,
          ContentAlignment? contentAlignment,
          String? content,
          Object? variant = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content,
        if (variant != $none) #variant: variant
      }));
  @override
  TwoColumnSlideOptions $make(CopyWithData data) => TwoColumnSlideOptions(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content),
      variant: data.get(#variant, or: $value.variant));

  @override
  TwoColumnSlideOptionsCopyWith<$R2, TwoColumnSlideOptions, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnSlideOptionsCopyWithImpl($value, $cast, t);
}

class TwoColumnHeaderSlideOptionsMapper
    extends ClassMapperBase<TwoColumnHeaderSlideOptions> {
  TwoColumnHeaderSlideOptionsMapper._();

  static TwoColumnHeaderSlideOptionsMapper? _instance;
  static TwoColumnHeaderSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = TwoColumnHeaderSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TwoColumnHeaderSlideOptions';

  static String? _$title(TwoColumnHeaderSlideOptions v) => v.title;
  static const Field<TwoColumnHeaderSlideOptions, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(TwoColumnHeaderSlideOptions v) => v.background;
  static const Field<TwoColumnHeaderSlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(TwoColumnHeaderSlideOptions v) =>
      v.contentAlignment;
  static const Field<TwoColumnHeaderSlideOptions, ContentAlignment>
      _f$contentAlignment = Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment',
          opt: true,
          def: ContentAlignment.centerLeft);
  static String _$content(TwoColumnHeaderSlideOptions v) => v.content;
  static const Field<TwoColumnHeaderSlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$variant(TwoColumnHeaderSlideOptions v) => v.variant;
  static const Field<TwoColumnHeaderSlideOptions, String> _f$variant =
      Field('variant', _$variant, opt: true);

  @override
  final MappableFields<TwoColumnHeaderSlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #variant: _f$variant,
  };

  static TwoColumnHeaderSlideOptions _instantiate(DecodingData data) {
    return TwoColumnHeaderSlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        variant: data.dec(_f$variant));
  }

  @override
  final Function instantiate = _instantiate;

  static TwoColumnHeaderSlideOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TwoColumnHeaderSlideOptions>(map);
  }

  static TwoColumnHeaderSlideOptions fromJson(String json) {
    return ensureInitialized().decodeJson<TwoColumnHeaderSlideOptions>(json);
  }
}

mixin TwoColumnHeaderSlideOptionsMappable {
  String toJson() {
    return TwoColumnHeaderSlideOptionsMapper.ensureInitialized()
        .encodeJson<TwoColumnHeaderSlideOptions>(
            this as TwoColumnHeaderSlideOptions);
  }

  Map<String, dynamic> toMap() {
    return TwoColumnHeaderSlideOptionsMapper.ensureInitialized()
        .encodeMap<TwoColumnHeaderSlideOptions>(
            this as TwoColumnHeaderSlideOptions);
  }

  TwoColumnHeaderSlideOptionsCopyWith<TwoColumnHeaderSlideOptions,
          TwoColumnHeaderSlideOptions, TwoColumnHeaderSlideOptions>
      get copyWith => _TwoColumnHeaderSlideOptionsCopyWithImpl(
          this as TwoColumnHeaderSlideOptions, $identity, $identity);
  @override
  String toString() {
    return TwoColumnHeaderSlideOptionsMapper.ensureInitialized()
        .stringifyValue(this as TwoColumnHeaderSlideOptions);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TwoColumnHeaderSlideOptionsMapper.ensureInitialized()
                .isValueEqual(this as TwoColumnHeaderSlideOptions, other));
  }

  @override
  int get hashCode {
    return TwoColumnHeaderSlideOptionsMapper.ensureInitialized()
        .hashValue(this as TwoColumnHeaderSlideOptions);
  }
}

extension TwoColumnHeaderSlideOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TwoColumnHeaderSlideOptions, $Out> {
  TwoColumnHeaderSlideOptionsCopyWith<$R, TwoColumnHeaderSlideOptions, $Out>
      get $asTwoColumnHeaderSlideOptions => $base
          .as((v, t, t2) => _TwoColumnHeaderSlideOptionsCopyWithImpl(v, t, t2));
}

abstract class TwoColumnHeaderSlideOptionsCopyWith<
    $R,
    $In extends TwoColumnHeaderSlideOptions,
    $Out> implements SlideOptionsCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? contentAlignment,
      String? content,
      String? variant});
  TwoColumnHeaderSlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TwoColumnHeaderSlideOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TwoColumnHeaderSlideOptions, $Out>
    implements
        TwoColumnHeaderSlideOptionsCopyWith<$R, TwoColumnHeaderSlideOptions,
            $Out> {
  _TwoColumnHeaderSlideOptionsCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TwoColumnHeaderSlideOptions> $mapper =
      TwoColumnHeaderSlideOptionsMapper.ensureInitialized();
  @override
  $R call(
          {Object? title = $none,
          Object? background = $none,
          ContentAlignment? contentAlignment,
          String? content,
          Object? variant = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content,
        if (variant != $none) #variant: variant
      }));
  @override
  TwoColumnHeaderSlideOptions $make(CopyWithData data) =>
      TwoColumnHeaderSlideOptions(
          title: data.get(#title, or: $value.title),
          background: data.get(#background, or: $value.background),
          contentAlignment:
              data.get(#contentAlignment, or: $value.contentAlignment),
          content: data.get(#content, or: $value.content),
          variant: data.get(#variant, or: $value.variant));

  @override
  TwoColumnHeaderSlideOptionsCopyWith<$R2, TwoColumnHeaderSlideOptions, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnHeaderSlideOptionsCopyWithImpl($value, $cast, t);
}
