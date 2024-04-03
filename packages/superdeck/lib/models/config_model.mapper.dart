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
      SimpleSlideOptionsMapper.ensureInitialized();
      ImageSlideOptionsMapper.ensureInitialized();
      PreviewSlideOptionsMapper.ensureInitialized();
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
  static String? _$style(SlideOptions v) => v.style;
  static const Field<SlideOptions, String> _f$style = Field('style', _$style);
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
    #style: _f$style,
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
      String? style,
      ContentAlignment? contentAlignment});
  SlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SimpleSlideOptionsMapper extends ClassMapperBase<SimpleSlideOptions> {
  SimpleSlideOptionsMapper._();

  static SimpleSlideOptionsMapper? _instance;
  static SimpleSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SimpleSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SimpleSlideOptions';

  static String? _$title(SimpleSlideOptions v) => v.title;
  static const Field<SimpleSlideOptions, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(SimpleSlideOptions v) => v.background;
  static const Field<SimpleSlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(SimpleSlideOptions v) =>
      v.contentAlignment;
  static const Field<SimpleSlideOptions, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment',
          opt: true,
          def: ContentAlignment.centerLeft);
  static String _$content(SimpleSlideOptions v) => v.content;
  static const Field<SimpleSlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$style(SimpleSlideOptions v) => v.style;
  static const Field<SimpleSlideOptions, String> _f$style =
      Field('style', _$style, opt: true);

  @override
  final MappableFields<SimpleSlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #style: _f$style,
  };

  static SimpleSlideOptions _instantiate(DecodingData data) {
    return SimpleSlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        style: data.dec(_f$style));
  }

  @override
  final Function instantiate = _instantiate;

  static SimpleSlideOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SimpleSlideOptions>(map);
  }

  static SimpleSlideOptions fromJson(String json) {
    return ensureInitialized().decodeJson<SimpleSlideOptions>(json);
  }
}

mixin SimpleSlideOptionsMappable {
  String toJson() {
    return SimpleSlideOptionsMapper.ensureInitialized()
        .encodeJson<SimpleSlideOptions>(this as SimpleSlideOptions);
  }

  Map<String, dynamic> toMap() {
    return SimpleSlideOptionsMapper.ensureInitialized()
        .encodeMap<SimpleSlideOptions>(this as SimpleSlideOptions);
  }

  SimpleSlideOptionsCopyWith<SimpleSlideOptions, SimpleSlideOptions,
          SimpleSlideOptions>
      get copyWith => _SimpleSlideOptionsCopyWithImpl(
          this as SimpleSlideOptions, $identity, $identity);
  @override
  String toString() {
    return SimpleSlideOptionsMapper.ensureInitialized()
        .stringifyValue(this as SimpleSlideOptions);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SimpleSlideOptionsMapper.ensureInitialized()
                .isValueEqual(this as SimpleSlideOptions, other));
  }

  @override
  int get hashCode {
    return SimpleSlideOptionsMapper.ensureInitialized()
        .hashValue(this as SimpleSlideOptions);
  }
}

extension SimpleSlideOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SimpleSlideOptions, $Out> {
  SimpleSlideOptionsCopyWith<$R, SimpleSlideOptions, $Out>
      get $asSimpleSlideOptions =>
          $base.as((v, t, t2) => _SimpleSlideOptionsCopyWithImpl(v, t, t2));
}

abstract class SimpleSlideOptionsCopyWith<$R, $In extends SimpleSlideOptions,
    $Out> implements SlideOptionsCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? contentAlignment,
      String? content,
      String? style});
  SimpleSlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SimpleSlideOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SimpleSlideOptions, $Out>
    implements SimpleSlideOptionsCopyWith<$R, SimpleSlideOptions, $Out> {
  _SimpleSlideOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SimpleSlideOptions> $mapper =
      SimpleSlideOptionsMapper.ensureInitialized();
  @override
  $R call(
          {Object? title = $none,
          Object? background = $none,
          ContentAlignment? contentAlignment,
          String? content,
          Object? style = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content,
        if (style != $none) #style: style
      }));
  @override
  SimpleSlideOptions $make(CopyWithData data) => SimpleSlideOptions(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content),
      style: data.get(#style, or: $value.style));

  @override
  SimpleSlideOptionsCopyWith<$R2, SimpleSlideOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SimpleSlideOptionsCopyWithImpl($value, $cast, t);
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
  static String? _$style(ImageSlideOptions v) => v.style;
  static const Field<ImageSlideOptions, String> _f$style =
      Field('style', _$style, opt: true);
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
    #style: _f$style,
    #background: _f$background,
    #content: _f$content,
    #contentAlignment: _f$contentAlignment,
  };

  static ImageSlideOptions _instantiate(DecodingData data) {
    return ImageSlideOptions(
        title: data.dec(_f$title),
        image: data.dec(_f$image),
        style: data.dec(_f$style),
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
      String? style,
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
          Object? style = $none,
          Object? background = $none,
          String? content,
          ContentAlignment? contentAlignment}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (image != null) #image: image,
        if (style != $none) #style: style,
        if (background != $none) #background: background,
        if (content != null) #content: content,
        if (contentAlignment != null) #contentAlignment: contentAlignment
      }));
  @override
  ImageSlideOptions $make(CopyWithData data) => ImageSlideOptions(
      title: data.get(#title, or: $value.title),
      image: data.get(#image, or: $value.image),
      style: data.get(#style, or: $value.style),
      background: data.get(#background, or: $value.background),
      content: data.get(#content, or: $value.content),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment));

  @override
  ImageSlideOptionsCopyWith<$R2, ImageSlideOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageSlideOptionsCopyWithImpl($value, $cast, t);
}

class PreviewSlideOptionsMapper extends ClassMapperBase<PreviewSlideOptions> {
  PreviewSlideOptionsMapper._();

  static PreviewSlideOptionsMapper? _instance;
  static PreviewSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PreviewSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized();
      PreviewOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PreviewSlideOptions';

  static String? _$title(PreviewSlideOptions v) => v.title;
  static const Field<PreviewSlideOptions, String> _f$title =
      Field('title', _$title, opt: true);
  static PreviewOptions _$widget(PreviewSlideOptions v) => v.widget;
  static const Field<PreviewSlideOptions, PreviewOptions> _f$widget =
      Field('widget', _$widget);
  static String? _$style(PreviewSlideOptions v) => v.style;
  static const Field<PreviewSlideOptions, String> _f$style =
      Field('style', _$style, opt: true);
  static String? _$background(PreviewSlideOptions v) => v.background;
  static const Field<PreviewSlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static String _$content(PreviewSlideOptions v) => v.content;
  static const Field<PreviewSlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static ContentAlignment _$contentAlignment(PreviewSlideOptions v) =>
      v.contentAlignment;
  static const Field<PreviewSlideOptions, ContentAlignment>
      _f$contentAlignment = Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment',
          opt: true,
          def: ContentAlignment.centerLeft);

  @override
  final MappableFields<PreviewSlideOptions> fields = const {
    #title: _f$title,
    #widget: _f$widget,
    #style: _f$style,
    #background: _f$background,
    #content: _f$content,
    #contentAlignment: _f$contentAlignment,
  };

  static PreviewSlideOptions _instantiate(DecodingData data) {
    return PreviewSlideOptions(
        title: data.dec(_f$title),
        widget: data.dec(_f$widget),
        style: data.dec(_f$style),
        background: data.dec(_f$background),
        content: data.dec(_f$content),
        contentAlignment: data.dec(_f$contentAlignment));
  }

  @override
  final Function instantiate = _instantiate;

  static PreviewSlideOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PreviewSlideOptions>(map);
  }

  static PreviewSlideOptions fromJson(String json) {
    return ensureInitialized().decodeJson<PreviewSlideOptions>(json);
  }
}

mixin PreviewSlideOptionsMappable {
  String toJson() {
    return PreviewSlideOptionsMapper.ensureInitialized()
        .encodeJson<PreviewSlideOptions>(this as PreviewSlideOptions);
  }

  Map<String, dynamic> toMap() {
    return PreviewSlideOptionsMapper.ensureInitialized()
        .encodeMap<PreviewSlideOptions>(this as PreviewSlideOptions);
  }

  PreviewSlideOptionsCopyWith<PreviewSlideOptions, PreviewSlideOptions,
          PreviewSlideOptions>
      get copyWith => _PreviewSlideOptionsCopyWithImpl(
          this as PreviewSlideOptions, $identity, $identity);
  @override
  String toString() {
    return PreviewSlideOptionsMapper.ensureInitialized()
        .stringifyValue(this as PreviewSlideOptions);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PreviewSlideOptionsMapper.ensureInitialized()
                .isValueEqual(this as PreviewSlideOptions, other));
  }

  @override
  int get hashCode {
    return PreviewSlideOptionsMapper.ensureInitialized()
        .hashValue(this as PreviewSlideOptions);
  }
}

extension PreviewSlideOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PreviewSlideOptions, $Out> {
  PreviewSlideOptionsCopyWith<$R, PreviewSlideOptions, $Out>
      get $asPreviewSlideOptions =>
          $base.as((v, t, t2) => _PreviewSlideOptionsCopyWithImpl(v, t, t2));
}

abstract class PreviewSlideOptionsCopyWith<$R, $In extends PreviewSlideOptions,
    $Out> implements SlideOptionsCopyWith<$R, $In, $Out> {
  PreviewOptionsCopyWith<$R, PreviewOptions, PreviewOptions> get widget;
  @override
  $R call(
      {String? title,
      PreviewOptions? widget,
      String? style,
      String? background,
      String? content,
      ContentAlignment? contentAlignment});
  PreviewSlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PreviewSlideOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PreviewSlideOptions, $Out>
    implements PreviewSlideOptionsCopyWith<$R, PreviewSlideOptions, $Out> {
  _PreviewSlideOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PreviewSlideOptions> $mapper =
      PreviewSlideOptionsMapper.ensureInitialized();
  @override
  PreviewOptionsCopyWith<$R, PreviewOptions, PreviewOptions> get widget =>
      $value.widget.copyWith.$chain((v) => call(widget: v));
  @override
  $R call(
          {Object? title = $none,
          PreviewOptions? widget,
          Object? style = $none,
          Object? background = $none,
          String? content,
          ContentAlignment? contentAlignment}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (widget != null) #widget: widget,
        if (style != $none) #style: style,
        if (background != $none) #background: background,
        if (content != null) #content: content,
        if (contentAlignment != null) #contentAlignment: contentAlignment
      }));
  @override
  PreviewSlideOptions $make(CopyWithData data) => PreviewSlideOptions(
      title: data.get(#title, or: $value.title),
      widget: data.get(#widget, or: $value.widget),
      style: data.get(#style, or: $value.style),
      background: data.get(#background, or: $value.background),
      content: data.get(#content, or: $value.content),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment));

  @override
  PreviewSlideOptionsCopyWith<$R2, PreviewSlideOptions, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PreviewSlideOptionsCopyWithImpl($value, $cast, t);
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
  static String? _$style(TwoColumnSlideOptions v) => v.style;
  static const Field<TwoColumnSlideOptions, String> _f$style =
      Field('style', _$style, opt: true);

  @override
  final MappableFields<TwoColumnSlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #style: _f$style,
  };

  static TwoColumnSlideOptions _instantiate(DecodingData data) {
    return TwoColumnSlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        style: data.dec(_f$style));
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
      String? style});
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
          Object? style = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content,
        if (style != $none) #style: style
      }));
  @override
  TwoColumnSlideOptions $make(CopyWithData data) => TwoColumnSlideOptions(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content),
      style: data.get(#style, or: $value.style));

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
  static String? _$style(TwoColumnHeaderSlideOptions v) => v.style;
  static const Field<TwoColumnHeaderSlideOptions, String> _f$style =
      Field('style', _$style, opt: true);

  @override
  final MappableFields<TwoColumnHeaderSlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #style: _f$style,
  };

  static TwoColumnHeaderSlideOptions _instantiate(DecodingData data) {
    return TwoColumnHeaderSlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        style: data.dec(_f$style));
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
      String? style});
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
          Object? style = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content,
        if (style != $none) #style: style
      }));
  @override
  TwoColumnHeaderSlideOptions $make(CopyWithData data) =>
      TwoColumnHeaderSlideOptions(
          title: data.get(#title, or: $value.title),
          background: data.get(#background, or: $value.background),
          contentAlignment:
              data.get(#contentAlignment, or: $value.contentAlignment),
          content: data.get(#content, or: $value.content),
          style: data.get(#style, or: $value.style));

  @override
  TwoColumnHeaderSlideOptionsCopyWith<$R2, TwoColumnHeaderSlideOptions, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnHeaderSlideOptionsCopyWithImpl($value, $cast, t);
}
