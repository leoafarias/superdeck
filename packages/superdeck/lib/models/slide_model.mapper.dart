// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_model.dart';

class SlideMapper extends SubClassMapperBase<Slide> {
  SlideMapper._();

  static SlideMapper? _instance;
  static SlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideMapper._());
      BaseConfigMapper.ensureInitialized().addSubMapper(_instance!);
      SimpleSlideMapper.ensureInitialized();
      SplitSlideMapper.ensureInitialized();
      InvalidSlideMapper.ensureInitialized();
      ContentOptionsMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Slide';

  static String _$layout(Slide v) => v.layout;
  static const Field<Slide, String> _f$layout = Field('layout', _$layout);
  static String _$content(Slide v) => v.content;
  static const Field<Slide, String> _f$content = Field('content', _$content);
  static String _$key(Slide v) => v.key;
  static const Field<Slide, String> _f$key = Field('key', _$key);
  static String? _$title(Slide v) => v.title;
  static const Field<Slide, String> _f$title = Field('title', _$title);
  static ContentOptions? _$contentOptions(Slide v) => v.contentOptions;
  static const Field<Slide, ContentOptions> _f$contentOptions =
      Field('contentOptions', _$contentOptions, key: 'content_options');
  static String? _$background(Slide v) => v.background;
  static const Field<Slide, String> _f$background =
      Field('background', _$background);
  static String? _$style(Slide v) => v.style;
  static const Field<Slide, String> _f$style = Field('style', _$style);
  static TransitionOptions? _$transition(Slide v) => v.transition;
  static const Field<Slide, TransitionOptions> _f$transition =
      Field('transition', _$transition);

  @override
  final MappableFields<Slide> fields = const {
    #layout: _f$layout,
    #content: _f$content,
    #key: _f$key,
    #title: _f$title,
    #contentOptions: _f$contentOptions,
    #background: _f$background,
    #style: _f$style,
    #transition: _f$transition,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'Slide';
  @override
  late final ClassMapperBase superMapper = BaseConfigMapper.ensureInitialized();

  static Slide _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'Slide', 'layout', '${data.value['layout']}');
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
  String toJson();
  Map<String, dynamic> toMap();
  SlideCopyWith<Slide, Slide, Slide> get copyWith;
}

abstract class SlideCopyWith<$R, $In extends Slide, $Out>
    implements BaseConfigCopyWith<$R, $In, $Out> {
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>?
      get contentOptions;
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? content,
      String? key,
      String? title,
      ContentOptions? contentOptions,
      String? background,
      String? style,
      TransitionOptions? transition});
  SlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SimpleSlideMapper extends SubClassMapperBase<SimpleSlide> {
  SimpleSlideMapper._();

  static SimpleSlideMapper? _instance;
  static SimpleSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SimpleSlideMapper._());
      SlideMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SimpleSlide';

  static String? _$title(SimpleSlide v) => v.title;
  static const Field<SimpleSlide, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(SimpleSlide v) => v.background;
  static const Field<SimpleSlide, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentOptions? _$contentOptions(SimpleSlide v) => v.contentOptions;
  static const Field<SimpleSlide, ContentOptions> _f$contentOptions = Field(
      'contentOptions', _$contentOptions,
      key: 'content_options', opt: true);
  static String? _$style(SimpleSlide v) => v.style;
  static const Field<SimpleSlide, String> _f$style =
      Field('style', _$style, opt: true);
  static TransitionOptions? _$transition(SimpleSlide v) => v.transition;
  static const Field<SimpleSlide, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);
  static String _$key(SimpleSlide v) => v.key;
  static const Field<SimpleSlide, String> _f$key = Field('key', _$key);
  static String _$content(SimpleSlide v) => v.content;
  static const Field<SimpleSlide, String> _f$content =
      Field('content', _$content);
  static String _$layout(SimpleSlide v) => v.layout;
  static const Field<SimpleSlide, String> _f$layout =
      Field('layout', _$layout, mode: FieldMode.member);

  @override
  final MappableFields<SimpleSlide> fields = const {
    #title: _f$title,
    #background: _f$background,
    #contentOptions: _f$contentOptions,
    #style: _f$style,
    #transition: _f$transition,
    #key: _f$key,
    #content: _f$content,
    #layout: _f$layout,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = MappableClass.useAsDefault;
  @override
  late final ClassMapperBase superMapper = SlideMapper.ensureInitialized();

  static SimpleSlide _instantiate(DecodingData data) {
    return SimpleSlide(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        contentOptions: data.dec(_f$contentOptions),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition),
        key: data.dec(_f$key),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static SimpleSlide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SimpleSlide>(map);
  }

  static SimpleSlide fromJson(String json) {
    return ensureInitialized().decodeJson<SimpleSlide>(json);
  }
}

mixin SimpleSlideMappable {
  String toJson() {
    return SimpleSlideMapper.ensureInitialized()
        .encodeJson<SimpleSlide>(this as SimpleSlide);
  }

  Map<String, dynamic> toMap() {
    return SimpleSlideMapper.ensureInitialized()
        .encodeMap<SimpleSlide>(this as SimpleSlide);
  }

  SimpleSlideCopyWith<SimpleSlide, SimpleSlide, SimpleSlide> get copyWith =>
      _SimpleSlideCopyWithImpl(this as SimpleSlide, $identity, $identity);
  @override
  String toString() {
    return SimpleSlideMapper.ensureInitialized()
        .stringifyValue(this as SimpleSlide);
  }

  @override
  bool operator ==(Object other) {
    return SimpleSlideMapper.ensureInitialized()
        .equalsValue(this as SimpleSlide, other);
  }

  @override
  int get hashCode {
    return SimpleSlideMapper.ensureInitialized().hashValue(this as SimpleSlide);
  }
}

extension SimpleSlideValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SimpleSlide, $Out> {
  SimpleSlideCopyWith<$R, SimpleSlide, $Out> get $asSimpleSlide =>
      $base.as((v, t, t2) => _SimpleSlideCopyWithImpl(v, t, t2));
}

abstract class SimpleSlideCopyWith<$R, $In extends SimpleSlide, $Out>
    implements SlideCopyWith<$R, $In, $Out> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>?
      get contentOptions;
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? title,
      String? background,
      ContentOptions? contentOptions,
      String? style,
      TransitionOptions? transition,
      String? key,
      String? content});
  SimpleSlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SimpleSlideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SimpleSlide, $Out>
    implements SimpleSlideCopyWith<$R, SimpleSlide, $Out> {
  _SimpleSlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SimpleSlide> $mapper =
      SimpleSlideMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>?
      get contentOptions => $value.contentOptions?.copyWith
          .$chain((v) => call(contentOptions: v));
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? title = $none,
          Object? background = $none,
          Object? contentOptions = $none,
          Object? style = $none,
          Object? transition = $none,
          String? key,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (contentOptions != $none) #contentOptions: contentOptions,
        if (style != $none) #style: style,
        if (transition != $none) #transition: transition,
        if (key != null) #key: key,
        if (content != null) #content: content
      }));
  @override
  SimpleSlide $make(CopyWithData data) => SimpleSlide(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      contentOptions: data.get(#contentOptions, or: $value.contentOptions),
      style: data.get(#style, or: $value.style),
      transition: data.get(#transition, or: $value.transition),
      key: data.get(#key, or: $value.key),
      content: data.get(#content, or: $value.content));

  @override
  SimpleSlideCopyWith<$R2, SimpleSlide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SimpleSlideCopyWithImpl($value, $cast, t);
}

class SplitSlideMapper extends SubClassMapperBase<SplitSlide> {
  SplitSlideMapper._();

  static SplitSlideMapper? _instance;
  static SplitSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SplitSlideMapper._());
      SlideMapper.ensureInitialized().addSubMapper(_instance!);
      ImageSlideMapper.ensureInitialized();
      WidgetSlideMapper.ensureInitialized();
      ContentOptionsMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
      SplitOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SplitSlide';
  @override
  Function get typeFactory => <T extends SplitOptions>(f) => f<SplitSlide<T>>();

  static SplitOptions _$options(SplitSlide v) => v.options;
  static dynamic _arg$options<T extends SplitOptions>(f) => f<T>();
  static const Field<SplitSlide, SplitOptions> _f$options =
      Field('options', _$options, arg: _arg$options);
  static String? _$title(SplitSlide v) => v.title;
  static const Field<SplitSlide, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(SplitSlide v) => v.background;
  static const Field<SplitSlide, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentOptions? _$contentOptions(SplitSlide v) => v.contentOptions;
  static const Field<SplitSlide, ContentOptions> _f$contentOptions =
      Field('contentOptions', _$contentOptions, key: 'content_options');
  static String? _$style(SplitSlide v) => v.style;
  static const Field<SplitSlide, String> _f$style =
      Field('style', _$style, opt: true);
  static TransitionOptions? _$transition(SplitSlide v) => v.transition;
  static const Field<SplitSlide, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);
  static String _$content(SplitSlide v) => v.content;
  static const Field<SplitSlide, String> _f$content =
      Field('content', _$content);
  static String _$layout(SplitSlide v) => v.layout;
  static const Field<SplitSlide, String> _f$layout = Field('layout', _$layout);
  static String _$key(SplitSlide v) => v.key;
  static const Field<SplitSlide, String> _f$key = Field('key', _$key);

  @override
  final MappableFields<SplitSlide> fields = const {
    #options: _f$options,
    #title: _f$title,
    #background: _f$background,
    #contentOptions: _f$contentOptions,
    #style: _f$style,
    #transition: _f$transition,
    #content: _f$content,
    #layout: _f$layout,
    #key: _f$key,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = 'SplitSlide';
  @override
  late final ClassMapperBase superMapper = SlideMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => [SplitOptions]);
  }

  static SplitSlide<T> _instantiate<T extends SplitOptions>(DecodingData data) {
    throw MapperException.missingSubclass(
        'SplitSlide', 'layout', '${data.value['layout']}');
  }

  @override
  final Function instantiate = _instantiate;

  static SplitSlide<T> fromMap<T extends SplitOptions>(
      Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SplitSlide<T>>(map);
  }

  static SplitSlide<T> fromJson<T extends SplitOptions>(String json) {
    return ensureInitialized().decodeJson<SplitSlide<T>>(json);
  }
}

mixin SplitSlideMappable<T extends SplitOptions> {
  String toJson();
  Map<String, dynamic> toMap();
  SplitSlideCopyWith<SplitSlide<T>, SplitSlide<T>, SplitSlide<T>, T>
      get copyWith;
}

abstract class SplitSlideCopyWith<$R, $In extends SplitSlide<T>, $Out,
    T extends SplitOptions> implements SlideCopyWith<$R, $In, $Out> {
  SplitOptionsCopyWith<$R, SplitOptions, T> get options;
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>?
      get contentOptions;
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {T? options,
      String? title,
      String? background,
      ContentOptions? contentOptions,
      String? style,
      TransitionOptions? transition,
      String? content,
      String? key});
  SplitSlideCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ImageSlideMapper extends SubClassMapperBase<ImageSlide> {
  ImageSlideMapper._();

  static ImageSlideMapper? _instance;
  static ImageSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageSlideMapper._());
      SplitSlideMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
      ImageOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageSlide';

  static String? _$title(ImageSlide v) => v.title;
  static const Field<ImageSlide, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$style(ImageSlide v) => v.style;
  static const Field<ImageSlide, String> _f$style =
      Field('style', _$style, opt: true);
  static String? _$background(ImageSlide v) => v.background;
  static const Field<ImageSlide, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentOptions? _$contentOptions(ImageSlide v) => v.contentOptions;
  static const Field<ImageSlide, ContentOptions> _f$contentOptions =
      Field('contentOptions', _$contentOptions, key: 'content_options');
  static TransitionOptions? _$transition(ImageSlide v) => v.transition;
  static const Field<ImageSlide, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);
  static String _$content(ImageSlide v) => v.content;
  static const Field<ImageSlide, String> _f$content =
      Field('content', _$content);
  static ImageOptions _$options(ImageSlide v) => v.options;
  static const Field<ImageSlide, ImageOptions> _f$options =
      Field('options', _$options);
  static String _$key(ImageSlide v) => v.key;
  static const Field<ImageSlide, String> _f$key = Field('key', _$key);
  static String _$layout(ImageSlide v) => v.layout;
  static const Field<ImageSlide, String> _f$layout =
      Field('layout', _$layout, mode: FieldMode.member);

  @override
  final MappableFields<ImageSlide> fields = const {
    #title: _f$title,
    #style: _f$style,
    #background: _f$background,
    #contentOptions: _f$contentOptions,
    #transition: _f$transition,
    #content: _f$content,
    #options: _f$options,
    #key: _f$key,
    #layout: _f$layout,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = LayoutType.image;
  @override
  late final ClassMapperBase superMapper = SplitSlideMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static ImageSlide _instantiate(DecodingData data) {
    return ImageSlide(
        title: data.dec(_f$title),
        style: data.dec(_f$style),
        background: data.dec(_f$background),
        contentOptions: data.dec(_f$contentOptions),
        transition: data.dec(_f$transition),
        content: data.dec(_f$content),
        options: data.dec(_f$options),
        key: data.dec(_f$key));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageSlide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageSlide>(map);
  }

  static ImageSlide fromJson(String json) {
    return ensureInitialized().decodeJson<ImageSlide>(json);
  }
}

mixin ImageSlideMappable {
  String toJson() {
    return ImageSlideMapper.ensureInitialized()
        .encodeJson<ImageSlide>(this as ImageSlide);
  }

  Map<String, dynamic> toMap() {
    return ImageSlideMapper.ensureInitialized()
        .encodeMap<ImageSlide>(this as ImageSlide);
  }

  ImageSlideCopyWith<ImageSlide, ImageSlide, ImageSlide> get copyWith =>
      _ImageSlideCopyWithImpl(this as ImageSlide, $identity, $identity);
  @override
  String toString() {
    return ImageSlideMapper.ensureInitialized()
        .stringifyValue(this as ImageSlide);
  }

  @override
  bool operator ==(Object other) {
    return ImageSlideMapper.ensureInitialized()
        .equalsValue(this as ImageSlide, other);
  }

  @override
  int get hashCode {
    return ImageSlideMapper.ensureInitialized().hashValue(this as ImageSlide);
  }
}

extension ImageSlideValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageSlide, $Out> {
  ImageSlideCopyWith<$R, ImageSlide, $Out> get $asImageSlide =>
      $base.as((v, t, t2) => _ImageSlideCopyWithImpl(v, t, t2));
}

abstract class ImageSlideCopyWith<$R, $In extends ImageSlide, $Out>
    implements SplitSlideCopyWith<$R, $In, $Out, ImageOptions> {
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>?
      get contentOptions;
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  ImageOptionsCopyWith<$R, ImageOptions, ImageOptions> get options;
  @override
  $R call(
      {String? title,
      String? style,
      String? background,
      ContentOptions? contentOptions,
      TransitionOptions? transition,
      String? content,
      ImageOptions? options,
      String? key});
  ImageSlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageSlideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageSlide, $Out>
    implements ImageSlideCopyWith<$R, ImageSlide, $Out> {
  _ImageSlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageSlide> $mapper =
      ImageSlideMapper.ensureInitialized();
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>?
      get contentOptions => $value.contentOptions?.copyWith
          .$chain((v) => call(contentOptions: v));
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  ImageOptionsCopyWith<$R, ImageOptions, ImageOptions> get options =>
      ($value.options as ImageOptions).copyWith.$chain((v) => call(options: v));
  @override
  $R call(
          {Object? title = $none,
          Object? style = $none,
          Object? background = $none,
          Object? contentOptions = $none,
          Object? transition = $none,
          String? content,
          ImageOptions? options,
          String? key}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (style != $none) #style: style,
        if (background != $none) #background: background,
        if (contentOptions != $none) #contentOptions: contentOptions,
        if (transition != $none) #transition: transition,
        if (content != null) #content: content,
        if (options != null) #options: options,
        if (key != null) #key: key
      }));
  @override
  ImageSlide $make(CopyWithData data) => ImageSlide(
      title: data.get(#title, or: $value.title),
      style: data.get(#style, or: $value.style),
      background: data.get(#background, or: $value.background),
      contentOptions: data.get(#contentOptions, or: $value.contentOptions),
      transition: data.get(#transition, or: $value.transition),
      content: data.get(#content, or: $value.content),
      options: data.get(#options, or: $value.options),
      key: data.get(#key, or: $value.key));

  @override
  ImageSlideCopyWith<$R2, ImageSlide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageSlideCopyWithImpl($value, $cast, t);
}

class WidgetSlideMapper extends SubClassMapperBase<WidgetSlide> {
  WidgetSlideMapper._();

  static WidgetSlideMapper? _instance;
  static WidgetSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetSlideMapper._());
      SplitSlideMapper.ensureInitialized().addSubMapper(_instance!);
      WidgetOptionsMapper.ensureInitialized();
      ContentOptionsMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WidgetSlide';

  static String? _$title(WidgetSlide v) => v.title;
  static const Field<WidgetSlide, String> _f$title =
      Field('title', _$title, opt: true);
  static WidgetOptions _$options(WidgetSlide v) => v.options;
  static const Field<WidgetSlide, WidgetOptions> _f$options =
      Field('options', _$options);
  static String? _$style(WidgetSlide v) => v.style;
  static const Field<WidgetSlide, String> _f$style =
      Field('style', _$style, opt: true);
  static String? _$background(WidgetSlide v) => v.background;
  static const Field<WidgetSlide, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentOptions? _$contentOptions(WidgetSlide v) => v.contentOptions;
  static const Field<WidgetSlide, ContentOptions> _f$contentOptions =
      Field('contentOptions', _$contentOptions, key: 'content_options');
  static TransitionOptions? _$transition(WidgetSlide v) => v.transition;
  static const Field<WidgetSlide, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);
  static String _$content(WidgetSlide v) => v.content;
  static const Field<WidgetSlide, String> _f$content =
      Field('content', _$content);
  static String _$key(WidgetSlide v) => v.key;
  static const Field<WidgetSlide, String> _f$key = Field('key', _$key);
  static String _$layout(WidgetSlide v) => v.layout;
  static const Field<WidgetSlide, String> _f$layout =
      Field('layout', _$layout, mode: FieldMode.member);

  @override
  final MappableFields<WidgetSlide> fields = const {
    #title: _f$title,
    #options: _f$options,
    #style: _f$style,
    #background: _f$background,
    #contentOptions: _f$contentOptions,
    #transition: _f$transition,
    #content: _f$content,
    #key: _f$key,
    #layout: _f$layout,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = LayoutType.widget;
  @override
  late final ClassMapperBase superMapper = SplitSlideMapper.ensureInitialized();

  @override
  DecodingContext inherit(DecodingContext context) {
    return context.inherit(args: () => []);
  }

  static WidgetSlide _instantiate(DecodingData data) {
    return WidgetSlide(
        title: data.dec(_f$title),
        options: data.dec(_f$options),
        style: data.dec(_f$style),
        background: data.dec(_f$background),
        contentOptions: data.dec(_f$contentOptions),
        transition: data.dec(_f$transition),
        content: data.dec(_f$content),
        key: data.dec(_f$key));
  }

  @override
  final Function instantiate = _instantiate;

  static WidgetSlide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WidgetSlide>(map);
  }

  static WidgetSlide fromJson(String json) {
    return ensureInitialized().decodeJson<WidgetSlide>(json);
  }
}

mixin WidgetSlideMappable {
  String toJson() {
    return WidgetSlideMapper.ensureInitialized()
        .encodeJson<WidgetSlide>(this as WidgetSlide);
  }

  Map<String, dynamic> toMap() {
    return WidgetSlideMapper.ensureInitialized()
        .encodeMap<WidgetSlide>(this as WidgetSlide);
  }

  WidgetSlideCopyWith<WidgetSlide, WidgetSlide, WidgetSlide> get copyWith =>
      _WidgetSlideCopyWithImpl(this as WidgetSlide, $identity, $identity);
  @override
  String toString() {
    return WidgetSlideMapper.ensureInitialized()
        .stringifyValue(this as WidgetSlide);
  }

  @override
  bool operator ==(Object other) {
    return WidgetSlideMapper.ensureInitialized()
        .equalsValue(this as WidgetSlide, other);
  }

  @override
  int get hashCode {
    return WidgetSlideMapper.ensureInitialized().hashValue(this as WidgetSlide);
  }
}

extension WidgetSlideValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WidgetSlide, $Out> {
  WidgetSlideCopyWith<$R, WidgetSlide, $Out> get $asWidgetSlide =>
      $base.as((v, t, t2) => _WidgetSlideCopyWithImpl(v, t, t2));
}

abstract class WidgetSlideCopyWith<$R, $In extends WidgetSlide, $Out>
    implements SplitSlideCopyWith<$R, $In, $Out, WidgetOptions> {
  @override
  WidgetOptionsCopyWith<$R, WidgetOptions, WidgetOptions> get options;
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>?
      get contentOptions;
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? title,
      WidgetOptions? options,
      String? style,
      String? background,
      ContentOptions? contentOptions,
      TransitionOptions? transition,
      String? content,
      String? key});
  WidgetSlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WidgetSlideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WidgetSlide, $Out>
    implements WidgetSlideCopyWith<$R, WidgetSlide, $Out> {
  _WidgetSlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WidgetSlide> $mapper =
      WidgetSlideMapper.ensureInitialized();
  @override
  WidgetOptionsCopyWith<$R, WidgetOptions, WidgetOptions> get options =>
      ($value.options as WidgetOptions)
          .copyWith
          .$chain((v) => call(options: v));
  @override
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>?
      get contentOptions => $value.contentOptions?.copyWith
          .$chain((v) => call(contentOptions: v));
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? title = $none,
          WidgetOptions? options,
          Object? style = $none,
          Object? background = $none,
          Object? contentOptions = $none,
          Object? transition = $none,
          String? content,
          String? key}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (options != null) #options: options,
        if (style != $none) #style: style,
        if (background != $none) #background: background,
        if (contentOptions != $none) #contentOptions: contentOptions,
        if (transition != $none) #transition: transition,
        if (content != null) #content: content,
        if (key != null) #key: key
      }));
  @override
  WidgetSlide $make(CopyWithData data) => WidgetSlide(
      title: data.get(#title, or: $value.title),
      options: data.get(#options, or: $value.options),
      style: data.get(#style, or: $value.style),
      background: data.get(#background, or: $value.background),
      contentOptions: data.get(#contentOptions, or: $value.contentOptions),
      transition: data.get(#transition, or: $value.transition),
      content: data.get(#content, or: $value.content),
      key: data.get(#key, or: $value.key));

  @override
  WidgetSlideCopyWith<$R2, WidgetSlide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WidgetSlideCopyWithImpl($value, $cast, t);
}

class InvalidSlideMapper extends SubClassMapperBase<InvalidSlide> {
  InvalidSlideMapper._();

  static InvalidSlideMapper? _instance;
  static InvalidSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InvalidSlideMapper._());
      SlideMapper.ensureInitialized().addSubMapper(_instance!);
      ContentOptionsMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'InvalidSlide';

  static ContentOptions? _$contentOptions(InvalidSlide v) => v.contentOptions;
  static const Field<InvalidSlide, ContentOptions> _f$contentOptions =
      Field('contentOptions', _$contentOptions, key: 'content_options');
  static String? _$title(InvalidSlide v) => v.title;
  static const Field<InvalidSlide, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(InvalidSlide v) => v.background;
  static const Field<InvalidSlide, String> _f$background =
      Field('background', _$background, opt: true);
  static String? _$style(InvalidSlide v) => v.style;
  static const Field<InvalidSlide, String> _f$style =
      Field('style', _$style, opt: true);
  static TransitionOptions? _$transition(InvalidSlide v) => v.transition;
  static const Field<InvalidSlide, TransitionOptions> _f$transition =
      Field('transition', _$transition, opt: true);
  static String _$content(InvalidSlide v) => v.content;
  static const Field<InvalidSlide, String> _f$content =
      Field('content', _$content);
  static String _$key(InvalidSlide v) => v.key;
  static const Field<InvalidSlide, String> _f$key = Field('key', _$key);
  static String _$layout(InvalidSlide v) => v.layout;
  static const Field<InvalidSlide, String> _f$layout =
      Field('layout', _$layout, mode: FieldMode.member);

  @override
  final MappableFields<InvalidSlide> fields = const {
    #contentOptions: _f$contentOptions,
    #title: _f$title,
    #background: _f$background,
    #style: _f$style,
    #transition: _f$transition,
    #content: _f$content,
    #key: _f$key,
    #layout: _f$layout,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'layout';
  @override
  final dynamic discriminatorValue = LayoutType.invalid;
  @override
  late final ClassMapperBase superMapper = SlideMapper.ensureInitialized();

  static InvalidSlide _instantiate(DecodingData data) {
    return InvalidSlide(
        contentOptions: data.dec(_f$contentOptions),
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition),
        content: data.dec(_f$content),
        key: data.dec(_f$key));
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
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>?
      get contentOptions;
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {ContentOptions? contentOptions,
      String? title,
      String? background,
      String? style,
      TransitionOptions? transition,
      String? content,
      String? key});
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
  ContentOptionsCopyWith<$R, ContentOptions, ContentOptions>?
      get contentOptions => $value.contentOptions?.copyWith
          .$chain((v) => call(contentOptions: v));
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? contentOptions = $none,
          Object? title = $none,
          Object? background = $none,
          Object? style = $none,
          Object? transition = $none,
          String? content,
          String? key}) =>
      $apply(FieldCopyWithData({
        if (contentOptions != $none) #contentOptions: contentOptions,
        if (title != $none) #title: title,
        if (background != $none) #background: background,
        if (style != $none) #style: style,
        if (transition != $none) #transition: transition,
        if (content != null) #content: content,
        if (key != null) #key: key
      }));
  @override
  InvalidSlide $make(CopyWithData data) => InvalidSlide(
      contentOptions: data.get(#contentOptions, or: $value.contentOptions),
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      style: data.get(#style, or: $value.style),
      transition: data.get(#transition, or: $value.transition),
      content: data.get(#content, or: $value.content),
      key: data.get(#key, or: $value.key));

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
