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
      InvalidSlideOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideOptions';

  static String _$layout(SlideOptions v) => v.layout;
  static const Field<SlideOptions, String> _f$layout =
      Field('layout', _$layout);
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
  static ContentAlignment _$alignment(SlideOptions v) => v.alignment;
  static const Field<SlideOptions, ContentAlignment> _f$alignment = Field(
      'alignment', _$alignment,
      opt: true, def: ContentAlignment.centerLeft);
  static TransitionOptions? _$transition(SlideOptions v) => v.transition;
  static const Field<SlideOptions, TransitionOptions> _f$transition =
      Field('transition', _$transition);

  @override
  final MappableFields<SlideOptions> fields = const {
    #layout: _f$layout,
    #title: _f$title,
    #background: _f$background,
    #content: _f$content,
    #style: _f$style,
    #alignment: _f$alignment,
    #transition: _f$transition,
  };

  static SlideOptions _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'SlideOptions', 'layout', '${data.value['layout']}');
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  $R call(
      {String? title,
      String? background,
      String? content,
      String? style,
      ContentAlignment? alignment,
      TransitionOptions? transition});
  SlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SimpleSlideOptionsMapper extends SubClassMapperBase<SimpleSlideOptions> {
  SimpleSlideOptionsMapper._();

  static SimpleSlideOptionsMapper? _instance;
  static SimpleSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SimpleSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized().addSubMapper(_instance!);
      ContentAlignmentMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
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
  static ContentAlignment _$alignment(SimpleSlideOptions v) => v.alignment;
  static const Field<SimpleSlideOptions, ContentAlignment> _f$alignment = Field(
      'alignment', _$alignment,
      opt: true, def: ContentAlignment.centerLeft);
  static String _$content(SimpleSlideOptions v) => v.content;
  static const Field<SimpleSlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$style(SimpleSlideOptions v) => v.style;
  static const Field<SimpleSlideOptions, String> _f$style =
      Field('style', _$style, opt: true);
  static TransitionOptions? _$transition(SimpleSlideOptions v) => v.transition;
  static const Field<SimpleSlideOptions, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);
  static String _$layout(SimpleSlideOptions v) => v.layout;
  static const Field<SimpleSlideOptions, String> _f$layout =
      Field('layout', _$layout, mode: FieldMode.member);

  @override
  final MappableFields<SimpleSlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #alignment: _f$alignment,
    #content: _f$content,
    #style: _f$style,
    #transition: _f$transition,
    #layout: _f$layout,
  };

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = MappableClass.useAsDefault;
  @override
  late final ClassMapperBase superMapper =
      SlideOptionsMapper.ensureInitialized();

  static SimpleSlideOptions _instantiate(DecodingData data) {
    return SimpleSlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        alignment: data.dec(_f$alignment),
        content: data.dec(_f$content),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition));
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? alignment,
      String? content,
      String? style,
      TransitionOptions? transition});
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? title = $none,
          Object? background = $none,
          ContentAlignment? alignment,
          String? content,
          Object? style = $none,
          Object? transition = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (alignment != null) #alignment: alignment,
        if (content != null) #content: content,
        if (style != $none) #style: style,
        if (transition != $none) #transition: transition
      }));
  @override
  SimpleSlideOptions $make(CopyWithData data) => SimpleSlideOptions(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      alignment: data.get(#alignment, or: $value.alignment),
      content: data.get(#content, or: $value.content),
      style: data.get(#style, or: $value.style),
      transition: data.get(#transition, or: $value.transition));

  @override
  SimpleSlideOptionsCopyWith<$R2, SimpleSlideOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SimpleSlideOptionsCopyWithImpl($value, $cast, t);
}

class ImageSlideOptionsMapper extends SubClassMapperBase<ImageSlideOptions> {
  ImageSlideOptionsMapper._();

  static ImageSlideOptionsMapper? _instance;
  static ImageSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized().addSubMapper(_instance!);
      ImageOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
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
  static ContentAlignment _$alignment(ImageSlideOptions v) => v.alignment;
  static const Field<ImageSlideOptions, ContentAlignment> _f$alignment = Field(
      'alignment', _$alignment,
      opt: true, def: ContentAlignment.centerLeft);
  static TransitionOptions? _$transition(ImageSlideOptions v) => v.transition;
  static const Field<ImageSlideOptions, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);
  static String _$layout(ImageSlideOptions v) => v.layout;
  static const Field<ImageSlideOptions, String> _f$layout =
      Field('layout', _$layout, mode: FieldMode.member);

  @override
  final MappableFields<ImageSlideOptions> fields = const {
    #title: _f$title,
    #image: _f$image,
    #style: _f$style,
    #background: _f$background,
    #content: _f$content,
    #alignment: _f$alignment,
    #transition: _f$transition,
    #layout: _f$layout,
  };

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = LayoutTypes.image;
  @override
  late final ClassMapperBase superMapper =
      SlideOptionsMapper.ensureInitialized();

  static ImageSlideOptions _instantiate(DecodingData data) {
    return ImageSlideOptions(
        title: data.dec(_f$title),
        image: data.dec(_f$image),
        style: data.dec(_f$style),
        background: data.dec(_f$background),
        content: data.dec(_f$content),
        alignment: data.dec(_f$alignment),
        transition: data.dec(_f$transition));
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? title,
      ImageOptions? image,
      String? style,
      String? background,
      String? content,
      ContentAlignment? alignment,
      TransitionOptions? transition});
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? title = $none,
          ImageOptions? image,
          Object? style = $none,
          Object? background = $none,
          String? content,
          ContentAlignment? alignment,
          Object? transition = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (image != null) #image: image,
        if (style != $none) #style: style,
        if (background != $none) #background: background,
        if (content != null) #content: content,
        if (alignment != null) #alignment: alignment,
        if (transition != $none) #transition: transition
      }));
  @override
  ImageSlideOptions $make(CopyWithData data) => ImageSlideOptions(
      title: data.get(#title, or: $value.title),
      image: data.get(#image, or: $value.image),
      style: data.get(#style, or: $value.style),
      background: data.get(#background, or: $value.background),
      content: data.get(#content, or: $value.content),
      alignment: data.get(#alignment, or: $value.alignment),
      transition: data.get(#transition, or: $value.transition));

  @override
  ImageSlideOptionsCopyWith<$R2, ImageSlideOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageSlideOptionsCopyWithImpl($value, $cast, t);
}

class PreviewSlideOptionsMapper
    extends SubClassMapperBase<PreviewSlideOptions> {
  PreviewSlideOptionsMapper._();

  static PreviewSlideOptionsMapper? _instance;
  static PreviewSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PreviewSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized().addSubMapper(_instance!);
      PreviewOptionsMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
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
  static ContentAlignment _$alignment(PreviewSlideOptions v) => v.alignment;
  static const Field<PreviewSlideOptions, ContentAlignment> _f$alignment =
      Field('alignment', _$alignment,
          opt: true, def: ContentAlignment.centerLeft);
  static TransitionOptions? _$transition(PreviewSlideOptions v) => v.transition;
  static const Field<PreviewSlideOptions, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);
  static String _$layout(PreviewSlideOptions v) => v.layout;
  static const Field<PreviewSlideOptions, String> _f$layout =
      Field('layout', _$layout, mode: FieldMode.member);

  @override
  final MappableFields<PreviewSlideOptions> fields = const {
    #title: _f$title,
    #widget: _f$widget,
    #style: _f$style,
    #background: _f$background,
    #content: _f$content,
    #alignment: _f$alignment,
    #transition: _f$transition,
    #layout: _f$layout,
  };

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = LayoutTypes.preview;
  @override
  late final ClassMapperBase superMapper =
      SlideOptionsMapper.ensureInitialized();

  static PreviewSlideOptions _instantiate(DecodingData data) {
    return PreviewSlideOptions(
        title: data.dec(_f$title),
        widget: data.dec(_f$widget),
        style: data.dec(_f$style),
        background: data.dec(_f$background),
        content: data.dec(_f$content),
        alignment: data.dec(_f$alignment),
        transition: data.dec(_f$transition));
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? title,
      PreviewOptions? widget,
      String? style,
      String? background,
      String? content,
      ContentAlignment? alignment,
      TransitionOptions? transition});
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? title = $none,
          PreviewOptions? widget,
          Object? style = $none,
          Object? background = $none,
          String? content,
          ContentAlignment? alignment,
          Object? transition = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (widget != null) #widget: widget,
        if (style != $none) #style: style,
        if (background != $none) #background: background,
        if (content != null) #content: content,
        if (alignment != null) #alignment: alignment,
        if (transition != $none) #transition: transition
      }));
  @override
  PreviewSlideOptions $make(CopyWithData data) => PreviewSlideOptions(
      title: data.get(#title, or: $value.title),
      widget: data.get(#widget, or: $value.widget),
      style: data.get(#style, or: $value.style),
      background: data.get(#background, or: $value.background),
      content: data.get(#content, or: $value.content),
      alignment: data.get(#alignment, or: $value.alignment),
      transition: data.get(#transition, or: $value.transition));

  @override
  PreviewSlideOptionsCopyWith<$R2, PreviewSlideOptions, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PreviewSlideOptionsCopyWithImpl($value, $cast, t);
}

class TwoColumnSlideOptionsMapper
    extends SubClassMapperBase<TwoColumnSlideOptions> {
  TwoColumnSlideOptionsMapper._();

  static TwoColumnSlideOptionsMapper? _instance;
  static TwoColumnSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TwoColumnSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized().addSubMapper(_instance!);
      ContentAlignmentMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
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
  static ContentAlignment _$alignment(TwoColumnSlideOptions v) => v.alignment;
  static const Field<TwoColumnSlideOptions, ContentAlignment> _f$alignment =
      Field('alignment', _$alignment,
          opt: true, def: ContentAlignment.centerLeft);
  static String _$content(TwoColumnSlideOptions v) => v.content;
  static const Field<TwoColumnSlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$style(TwoColumnSlideOptions v) => v.style;
  static const Field<TwoColumnSlideOptions, String> _f$style =
      Field('style', _$style, opt: true);
  static TransitionOptions? _$transition(TwoColumnSlideOptions v) =>
      v.transition;
  static const Field<TwoColumnSlideOptions, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);
  static String _$layout(TwoColumnSlideOptions v) => v.layout;
  static const Field<TwoColumnSlideOptions, String> _f$layout =
      Field('layout', _$layout, mode: FieldMode.member);

  @override
  final MappableFields<TwoColumnSlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #alignment: _f$alignment,
    #content: _f$content,
    #style: _f$style,
    #transition: _f$transition,
    #layout: _f$layout,
  };

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = LayoutTypes.twoColumn;
  @override
  late final ClassMapperBase superMapper =
      SlideOptionsMapper.ensureInitialized();

  static TwoColumnSlideOptions _instantiate(DecodingData data) {
    return TwoColumnSlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        alignment: data.dec(_f$alignment),
        content: data.dec(_f$content),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition));
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? alignment,
      String? content,
      String? style,
      TransitionOptions? transition});
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? title = $none,
          Object? background = $none,
          ContentAlignment? alignment,
          String? content,
          Object? style = $none,
          Object? transition = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (alignment != null) #alignment: alignment,
        if (content != null) #content: content,
        if (style != $none) #style: style,
        if (transition != $none) #transition: transition
      }));
  @override
  TwoColumnSlideOptions $make(CopyWithData data) => TwoColumnSlideOptions(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      alignment: data.get(#alignment, or: $value.alignment),
      content: data.get(#content, or: $value.content),
      style: data.get(#style, or: $value.style),
      transition: data.get(#transition, or: $value.transition));

  @override
  TwoColumnSlideOptionsCopyWith<$R2, TwoColumnSlideOptions, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnSlideOptionsCopyWithImpl($value, $cast, t);
}

class TwoColumnHeaderSlideOptionsMapper
    extends SubClassMapperBase<TwoColumnHeaderSlideOptions> {
  TwoColumnHeaderSlideOptionsMapper._();

  static TwoColumnHeaderSlideOptionsMapper? _instance;
  static TwoColumnHeaderSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = TwoColumnHeaderSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized().addSubMapper(_instance!);
      ContentAlignmentMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
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
  static ContentAlignment _$alignment(TwoColumnHeaderSlideOptions v) =>
      v.alignment;
  static const Field<TwoColumnHeaderSlideOptions, ContentAlignment>
      _f$alignment = Field('alignment', _$alignment,
          opt: true, def: ContentAlignment.centerLeft);
  static String _$content(TwoColumnHeaderSlideOptions v) => v.content;
  static const Field<TwoColumnHeaderSlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$style(TwoColumnHeaderSlideOptions v) => v.style;
  static const Field<TwoColumnHeaderSlideOptions, String> _f$style =
      Field('style', _$style, opt: true);
  static TransitionOptions? _$transition(TwoColumnHeaderSlideOptions v) =>
      v.transition;
  static const Field<TwoColumnHeaderSlideOptions, TransitionOptions>
      _f$transition = Field('transition', _$transition, opt: true);
  static String _$layout(TwoColumnHeaderSlideOptions v) => v.layout;
  static const Field<TwoColumnHeaderSlideOptions, String> _f$layout =
      Field('layout', _$layout, mode: FieldMode.member);

  @override
  final MappableFields<TwoColumnHeaderSlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #alignment: _f$alignment,
    #content: _f$content,
    #style: _f$style,
    #transition: _f$transition,
    #layout: _f$layout,
  };

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = LayoutTypes.twoColumnHeader;
  @override
  late final ClassMapperBase superMapper =
      SlideOptionsMapper.ensureInitialized();

  static TwoColumnHeaderSlideOptions _instantiate(DecodingData data) {
    return TwoColumnHeaderSlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        alignment: data.dec(_f$alignment),
        content: data.dec(_f$content),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition));
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? alignment,
      String? content,
      String? style,
      TransitionOptions? transition});
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
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? title = $none,
          Object? background = $none,
          ContentAlignment? alignment,
          String? content,
          Object? style = $none,
          Object? transition = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (alignment != null) #alignment: alignment,
        if (content != null) #content: content,
        if (style != $none) #style: style,
        if (transition != $none) #transition: transition
      }));
  @override
  TwoColumnHeaderSlideOptions $make(CopyWithData data) =>
      TwoColumnHeaderSlideOptions(
          title: data.get(#title, or: $value.title),
          background: data.get(#background, or: $value.background),
          alignment: data.get(#alignment, or: $value.alignment),
          content: data.get(#content, or: $value.content),
          style: data.get(#style, or: $value.style),
          transition: data.get(#transition, or: $value.transition));

  @override
  TwoColumnHeaderSlideOptionsCopyWith<$R2, TwoColumnHeaderSlideOptions, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnHeaderSlideOptionsCopyWithImpl($value, $cast, t);
}

class InvalidSlideOptionsMapper
    extends SubClassMapperBase<InvalidSlideOptions> {
  InvalidSlideOptionsMapper._();

  static InvalidSlideOptionsMapper? _instance;
  static InvalidSlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InvalidSlideOptionsMapper._());
      SlideOptionsMapper.ensureInitialized().addSubMapper(_instance!);
      ContentAlignmentMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'InvalidSlideOptions';

  static String? _$title(InvalidSlideOptions v) => v.title;
  static const Field<InvalidSlideOptions, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(InvalidSlideOptions v) => v.background;
  static const Field<InvalidSlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$alignment(InvalidSlideOptions v) => v.alignment;
  static const Field<InvalidSlideOptions, ContentAlignment> _f$alignment =
      Field('alignment', _$alignment,
          opt: true, def: ContentAlignment.centerLeft);
  static String _$content(InvalidSlideOptions v) => v.content;
  static const Field<InvalidSlideOptions, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$style(InvalidSlideOptions v) => v.style;
  static const Field<InvalidSlideOptions, String> _f$style =
      Field('style', _$style, opt: true);
  static TransitionOptions? _$transition(InvalidSlideOptions v) => v.transition;
  static const Field<InvalidSlideOptions, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);
  static String _$layout(InvalidSlideOptions v) => v.layout;
  static const Field<InvalidSlideOptions, String> _f$layout =
      Field('layout', _$layout, mode: FieldMode.member);

  @override
  final MappableFields<InvalidSlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #alignment: _f$alignment,
    #content: _f$content,
    #style: _f$style,
    #transition: _f$transition,
    #layout: _f$layout,
  };

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = LayoutTypes.invalid;
  @override
  late final ClassMapperBase superMapper =
      SlideOptionsMapper.ensureInitialized();

  static InvalidSlideOptions _instantiate(DecodingData data) {
    return InvalidSlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        alignment: data.dec(_f$alignment),
        content: data.dec(_f$content),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition));
  }

  @override
  final Function instantiate = _instantiate;

  static InvalidSlideOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InvalidSlideOptions>(map);
  }

  static InvalidSlideOptions fromJson(String json) {
    return ensureInitialized().decodeJson<InvalidSlideOptions>(json);
  }
}

mixin InvalidSlideOptionsMappable {
  String toJson() {
    return InvalidSlideOptionsMapper.ensureInitialized()
        .encodeJson<InvalidSlideOptions>(this as InvalidSlideOptions);
  }

  Map<String, dynamic> toMap() {
    return InvalidSlideOptionsMapper.ensureInitialized()
        .encodeMap<InvalidSlideOptions>(this as InvalidSlideOptions);
  }

  InvalidSlideOptionsCopyWith<InvalidSlideOptions, InvalidSlideOptions,
          InvalidSlideOptions>
      get copyWith => _InvalidSlideOptionsCopyWithImpl(
          this as InvalidSlideOptions, $identity, $identity);
  @override
  String toString() {
    return InvalidSlideOptionsMapper.ensureInitialized()
        .stringifyValue(this as InvalidSlideOptions);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            InvalidSlideOptionsMapper.ensureInitialized()
                .isValueEqual(this as InvalidSlideOptions, other));
  }

  @override
  int get hashCode {
    return InvalidSlideOptionsMapper.ensureInitialized()
        .hashValue(this as InvalidSlideOptions);
  }
}

extension InvalidSlideOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InvalidSlideOptions, $Out> {
  InvalidSlideOptionsCopyWith<$R, InvalidSlideOptions, $Out>
      get $asInvalidSlideOptions =>
          $base.as((v, t, t2) => _InvalidSlideOptionsCopyWithImpl(v, t, t2));
}

abstract class InvalidSlideOptionsCopyWith<$R, $In extends InvalidSlideOptions,
    $Out> implements SlideOptionsCopyWith<$R, $In, $Out> {
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? alignment,
      String? content,
      String? style,
      TransitionOptions? transition});
  InvalidSlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _InvalidSlideOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InvalidSlideOptions, $Out>
    implements InvalidSlideOptionsCopyWith<$R, InvalidSlideOptions, $Out> {
  _InvalidSlideOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InvalidSlideOptions> $mapper =
      InvalidSlideOptionsMapper.ensureInitialized();
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? title = $none,
          Object? background = $none,
          ContentAlignment? alignment,
          String? content,
          Object? style = $none,
          Object? transition = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (alignment != null) #alignment: alignment,
        if (content != null) #content: content,
        if (style != $none) #style: style,
        if (transition != $none) #transition: transition
      }));
  @override
  InvalidSlideOptions $make(CopyWithData data) => InvalidSlideOptions(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      alignment: data.get(#alignment, or: $value.alignment),
      content: data.get(#content, or: $value.content),
      style: data.get(#style, or: $value.style),
      transition: data.get(#transition, or: $value.transition));

  @override
  InvalidSlideOptionsCopyWith<$R2, InvalidSlideOptions, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _InvalidSlideOptionsCopyWithImpl($value, $cast, t);
}
