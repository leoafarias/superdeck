// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'config_model.dart';

class SlideConfigMapper extends ClassMapperBase<SlideConfig> {
  SlideConfigMapper._();

  static SlideConfigMapper? _instance;
  static SlideConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideConfigMapper._());
      BaseSlideConfigMapper.ensureInitialized();
      ImageSlideConfigMapper.ensureInitialized();
      TwoColumnSlideConfigMapper.ensureInitialized();
      TwoColumnHeaderSlideConfigMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideConfig';

  static String? _$title(SlideConfig v) => v.title;
  static const Field<SlideConfig, String> _f$title = Field('title', _$title);
  static String? _$background(SlideConfig v) => v.background;
  static const Field<SlideConfig, String> _f$background =
      Field('background', _$background, opt: true);
  static String _$content(SlideConfig v) => v.content;
  static const Field<SlideConfig, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$variant(SlideConfig v) => v.variant;
  static const Field<SlideConfig, String> _f$variant =
      Field('variant', _$variant, opt: true);
  static ContentAlignment _$contentAlignment(SlideConfig v) =>
      v.contentAlignment;
  static const Field<SlideConfig, ContentAlignment> _f$contentAlignment = Field(
      'contentAlignment', _$contentAlignment,
      key: 'content_alignment', opt: true, def: ContentAlignment.centerLeft);

  @override
  final MappableFields<SlideConfig> fields = const {
    #title: _f$title,
    #background: _f$background,
    #content: _f$content,
    #variant: _f$variant,
    #contentAlignment: _f$contentAlignment,
  };

  static SlideConfig _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('SlideConfig');
  }

  @override
  final Function instantiate = _instantiate;

  static SlideConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideConfig>(map);
  }

  static SlideConfig fromJson(String json) {
    return ensureInitialized().decodeJson<SlideConfig>(json);
  }
}

mixin SlideConfigMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SlideConfigCopyWith<SlideConfig, SlideConfig, SlideConfig> get copyWith;
}

abstract class SlideConfigCopyWith<$R, $In extends SlideConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? title, String? background, String? content, String? variant});
  SlideConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class BaseSlideConfigMapper extends ClassMapperBase<BaseSlideConfig> {
  BaseSlideConfigMapper._();

  static BaseSlideConfigMapper? _instance;
  static BaseSlideConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BaseSlideConfigMapper._());
      SlideConfigMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BaseSlideConfig';

  static String? _$title(BaseSlideConfig v) => v.title;
  static const Field<BaseSlideConfig, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(BaseSlideConfig v) => v.background;
  static const Field<BaseSlideConfig, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(BaseSlideConfig v) =>
      v.contentAlignment;
  static const Field<BaseSlideConfig, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment',
          opt: true,
          def: ContentAlignment.centerLeft);
  static String _$content(BaseSlideConfig v) => v.content;
  static const Field<BaseSlideConfig, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$variant(BaseSlideConfig v) => v.variant;
  static const Field<BaseSlideConfig, String> _f$variant =
      Field('variant', _$variant, opt: true);

  @override
  final MappableFields<BaseSlideConfig> fields = const {
    #title: _f$title,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #variant: _f$variant,
  };

  static BaseSlideConfig _instantiate(DecodingData data) {
    return BaseSlideConfig(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        variant: data.dec(_f$variant));
  }

  @override
  final Function instantiate = _instantiate;

  static BaseSlideConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BaseSlideConfig>(map);
  }

  static BaseSlideConfig fromJson(String json) {
    return ensureInitialized().decodeJson<BaseSlideConfig>(json);
  }
}

mixin BaseSlideConfigMappable {
  String toJson() {
    return BaseSlideConfigMapper.ensureInitialized()
        .encodeJson<BaseSlideConfig>(this as BaseSlideConfig);
  }

  Map<String, dynamic> toMap() {
    return BaseSlideConfigMapper.ensureInitialized()
        .encodeMap<BaseSlideConfig>(this as BaseSlideConfig);
  }

  BaseSlideConfigCopyWith<BaseSlideConfig, BaseSlideConfig, BaseSlideConfig>
      get copyWith => _BaseSlideConfigCopyWithImpl(
          this as BaseSlideConfig, $identity, $identity);
  @override
  String toString() {
    return BaseSlideConfigMapper.ensureInitialized()
        .stringifyValue(this as BaseSlideConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BaseSlideConfigMapper.ensureInitialized()
                .isValueEqual(this as BaseSlideConfig, other));
  }

  @override
  int get hashCode {
    return BaseSlideConfigMapper.ensureInitialized()
        .hashValue(this as BaseSlideConfig);
  }
}

extension BaseSlideConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BaseSlideConfig, $Out> {
  BaseSlideConfigCopyWith<$R, BaseSlideConfig, $Out> get $asBaseSlideConfig =>
      $base.as((v, t, t2) => _BaseSlideConfigCopyWithImpl(v, t, t2));
}

abstract class BaseSlideConfigCopyWith<$R, $In extends BaseSlideConfig, $Out>
    implements SlideConfigCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? contentAlignment,
      String? content,
      String? variant});
  BaseSlideConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BaseSlideConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BaseSlideConfig, $Out>
    implements BaseSlideConfigCopyWith<$R, BaseSlideConfig, $Out> {
  _BaseSlideConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BaseSlideConfig> $mapper =
      BaseSlideConfigMapper.ensureInitialized();
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
  BaseSlideConfig $make(CopyWithData data) => BaseSlideConfig(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content),
      variant: data.get(#variant, or: $value.variant));

  @override
  BaseSlideConfigCopyWith<$R2, BaseSlideConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BaseSlideConfigCopyWithImpl($value, $cast, t);
}

class ImageSlideConfigMapper extends ClassMapperBase<ImageSlideConfig> {
  ImageSlideConfigMapper._();

  static ImageSlideConfigMapper? _instance;
  static ImageSlideConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageSlideConfigMapper._());
      SlideConfigMapper.ensureInitialized();
      ImageConfigMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageSlideConfig';

  static String? _$title(ImageSlideConfig v) => v.title;
  static const Field<ImageSlideConfig, String> _f$title =
      Field('title', _$title, opt: true);
  static ImageConfig _$image(ImageSlideConfig v) => v.image;
  static const Field<ImageSlideConfig, ImageConfig> _f$image =
      Field('image', _$image);
  static String? _$variant(ImageSlideConfig v) => v.variant;
  static const Field<ImageSlideConfig, String> _f$variant =
      Field('variant', _$variant, opt: true);
  static String? _$background(ImageSlideConfig v) => v.background;
  static const Field<ImageSlideConfig, String> _f$background =
      Field('background', _$background, opt: true);
  static String _$content(ImageSlideConfig v) => v.content;
  static const Field<ImageSlideConfig, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static ContentAlignment _$contentAlignment(ImageSlideConfig v) =>
      v.contentAlignment;
  static const Field<ImageSlideConfig, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment', mode: FieldMode.member);

  @override
  final MappableFields<ImageSlideConfig> fields = const {
    #title: _f$title,
    #image: _f$image,
    #variant: _f$variant,
    #background: _f$background,
    #content: _f$content,
    #contentAlignment: _f$contentAlignment,
  };

  static ImageSlideConfig _instantiate(DecodingData data) {
    return ImageSlideConfig(
        title: data.dec(_f$title),
        image: data.dec(_f$image),
        variant: data.dec(_f$variant),
        background: data.dec(_f$background),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageSlideConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageSlideConfig>(map);
  }

  static ImageSlideConfig fromJson(String json) {
    return ensureInitialized().decodeJson<ImageSlideConfig>(json);
  }
}

mixin ImageSlideConfigMappable {
  String toJson() {
    return ImageSlideConfigMapper.ensureInitialized()
        .encodeJson<ImageSlideConfig>(this as ImageSlideConfig);
  }

  Map<String, dynamic> toMap() {
    return ImageSlideConfigMapper.ensureInitialized()
        .encodeMap<ImageSlideConfig>(this as ImageSlideConfig);
  }

  ImageSlideConfigCopyWith<ImageSlideConfig, ImageSlideConfig, ImageSlideConfig>
      get copyWith => _ImageSlideConfigCopyWithImpl(
          this as ImageSlideConfig, $identity, $identity);
  @override
  String toString() {
    return ImageSlideConfigMapper.ensureInitialized()
        .stringifyValue(this as ImageSlideConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ImageSlideConfigMapper.ensureInitialized()
                .isValueEqual(this as ImageSlideConfig, other));
  }

  @override
  int get hashCode {
    return ImageSlideConfigMapper.ensureInitialized()
        .hashValue(this as ImageSlideConfig);
  }
}

extension ImageSlideConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageSlideConfig, $Out> {
  ImageSlideConfigCopyWith<$R, ImageSlideConfig, $Out>
      get $asImageSlideConfig =>
          $base.as((v, t, t2) => _ImageSlideConfigCopyWithImpl(v, t, t2));
}

abstract class ImageSlideConfigCopyWith<$R, $In extends ImageSlideConfig, $Out>
    implements SlideConfigCopyWith<$R, $In, $Out> {
  ImageConfigCopyWith<$R, ImageConfig, ImageConfig> get image;
  @override
  $R call(
      {String? title,
      ImageConfig? image,
      String? variant,
      String? background,
      String? content});
  ImageSlideConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ImageSlideConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageSlideConfig, $Out>
    implements ImageSlideConfigCopyWith<$R, ImageSlideConfig, $Out> {
  _ImageSlideConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageSlideConfig> $mapper =
      ImageSlideConfigMapper.ensureInitialized();
  @override
  ImageConfigCopyWith<$R, ImageConfig, ImageConfig> get image =>
      $value.image.copyWith.$chain((v) => call(image: v));
  @override
  $R call(
          {Object? title = $none,
          ImageConfig? image,
          Object? variant = $none,
          Object? background = $none,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (image != null) #image: image,
        if (variant != $none) #variant: variant,
        if (background != $none) #background: background,
        if (content != null) #content: content
      }));
  @override
  ImageSlideConfig $make(CopyWithData data) => ImageSlideConfig(
      title: data.get(#title, or: $value.title),
      image: data.get(#image, or: $value.image),
      variant: data.get(#variant, or: $value.variant),
      background: data.get(#background, or: $value.background),
      content: data.get(#content, or: $value.content));

  @override
  ImageSlideConfigCopyWith<$R2, ImageSlideConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageSlideConfigCopyWithImpl($value, $cast, t);
}

class TwoColumnSlideConfigMapper extends ClassMapperBase<TwoColumnSlideConfig> {
  TwoColumnSlideConfigMapper._();

  static TwoColumnSlideConfigMapper? _instance;
  static TwoColumnSlideConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TwoColumnSlideConfigMapper._());
      SlideConfigMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TwoColumnSlideConfig';

  static String? _$title(TwoColumnSlideConfig v) => v.title;
  static const Field<TwoColumnSlideConfig, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(TwoColumnSlideConfig v) => v.background;
  static const Field<TwoColumnSlideConfig, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(TwoColumnSlideConfig v) =>
      v.contentAlignment;
  static const Field<TwoColumnSlideConfig, ContentAlignment>
      _f$contentAlignment = Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment',
          opt: true,
          def: ContentAlignment.centerLeft);
  static String _$content(TwoColumnSlideConfig v) => v.content;
  static const Field<TwoColumnSlideConfig, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$variant(TwoColumnSlideConfig v) => v.variant;
  static const Field<TwoColumnSlideConfig, String> _f$variant =
      Field('variant', _$variant, opt: true);

  @override
  final MappableFields<TwoColumnSlideConfig> fields = const {
    #title: _f$title,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #variant: _f$variant,
  };

  static TwoColumnSlideConfig _instantiate(DecodingData data) {
    return TwoColumnSlideConfig(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        variant: data.dec(_f$variant));
  }

  @override
  final Function instantiate = _instantiate;

  static TwoColumnSlideConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TwoColumnSlideConfig>(map);
  }

  static TwoColumnSlideConfig fromJson(String json) {
    return ensureInitialized().decodeJson<TwoColumnSlideConfig>(json);
  }
}

mixin TwoColumnSlideConfigMappable {
  String toJson() {
    return TwoColumnSlideConfigMapper.ensureInitialized()
        .encodeJson<TwoColumnSlideConfig>(this as TwoColumnSlideConfig);
  }

  Map<String, dynamic> toMap() {
    return TwoColumnSlideConfigMapper.ensureInitialized()
        .encodeMap<TwoColumnSlideConfig>(this as TwoColumnSlideConfig);
  }

  TwoColumnSlideConfigCopyWith<TwoColumnSlideConfig, TwoColumnSlideConfig,
          TwoColumnSlideConfig>
      get copyWith => _TwoColumnSlideConfigCopyWithImpl(
          this as TwoColumnSlideConfig, $identity, $identity);
  @override
  String toString() {
    return TwoColumnSlideConfigMapper.ensureInitialized()
        .stringifyValue(this as TwoColumnSlideConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TwoColumnSlideConfigMapper.ensureInitialized()
                .isValueEqual(this as TwoColumnSlideConfig, other));
  }

  @override
  int get hashCode {
    return TwoColumnSlideConfigMapper.ensureInitialized()
        .hashValue(this as TwoColumnSlideConfig);
  }
}

extension TwoColumnSlideConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TwoColumnSlideConfig, $Out> {
  TwoColumnSlideConfigCopyWith<$R, TwoColumnSlideConfig, $Out>
      get $asTwoColumnSlideConfig =>
          $base.as((v, t, t2) => _TwoColumnSlideConfigCopyWithImpl(v, t, t2));
}

abstract class TwoColumnSlideConfigCopyWith<
    $R,
    $In extends TwoColumnSlideConfig,
    $Out> implements SlideConfigCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? contentAlignment,
      String? content,
      String? variant});
  TwoColumnSlideConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TwoColumnSlideConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TwoColumnSlideConfig, $Out>
    implements TwoColumnSlideConfigCopyWith<$R, TwoColumnSlideConfig, $Out> {
  _TwoColumnSlideConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TwoColumnSlideConfig> $mapper =
      TwoColumnSlideConfigMapper.ensureInitialized();
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
  TwoColumnSlideConfig $make(CopyWithData data) => TwoColumnSlideConfig(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content),
      variant: data.get(#variant, or: $value.variant));

  @override
  TwoColumnSlideConfigCopyWith<$R2, TwoColumnSlideConfig, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnSlideConfigCopyWithImpl($value, $cast, t);
}

class TwoColumnHeaderSlideConfigMapper
    extends ClassMapperBase<TwoColumnHeaderSlideConfig> {
  TwoColumnHeaderSlideConfigMapper._();

  static TwoColumnHeaderSlideConfigMapper? _instance;
  static TwoColumnHeaderSlideConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = TwoColumnHeaderSlideConfigMapper._());
      SlideConfigMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TwoColumnHeaderSlideConfig';

  static String? _$title(TwoColumnHeaderSlideConfig v) => v.title;
  static const Field<TwoColumnHeaderSlideConfig, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(TwoColumnHeaderSlideConfig v) => v.background;
  static const Field<TwoColumnHeaderSlideConfig, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(TwoColumnHeaderSlideConfig v) =>
      v.contentAlignment;
  static const Field<TwoColumnHeaderSlideConfig, ContentAlignment>
      _f$contentAlignment = Field('contentAlignment', _$contentAlignment,
          key: 'content_alignment',
          opt: true,
          def: ContentAlignment.centerLeft);
  static String _$content(TwoColumnHeaderSlideConfig v) => v.content;
  static const Field<TwoColumnHeaderSlideConfig, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String? _$variant(TwoColumnHeaderSlideConfig v) => v.variant;
  static const Field<TwoColumnHeaderSlideConfig, String> _f$variant =
      Field('variant', _$variant, opt: true);

  @override
  final MappableFields<TwoColumnHeaderSlideConfig> fields = const {
    #title: _f$title,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #variant: _f$variant,
  };

  static TwoColumnHeaderSlideConfig _instantiate(DecodingData data) {
    return TwoColumnHeaderSlideConfig(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        variant: data.dec(_f$variant));
  }

  @override
  final Function instantiate = _instantiate;

  static TwoColumnHeaderSlideConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TwoColumnHeaderSlideConfig>(map);
  }

  static TwoColumnHeaderSlideConfig fromJson(String json) {
    return ensureInitialized().decodeJson<TwoColumnHeaderSlideConfig>(json);
  }
}

mixin TwoColumnHeaderSlideConfigMappable {
  String toJson() {
    return TwoColumnHeaderSlideConfigMapper.ensureInitialized()
        .encodeJson<TwoColumnHeaderSlideConfig>(
            this as TwoColumnHeaderSlideConfig);
  }

  Map<String, dynamic> toMap() {
    return TwoColumnHeaderSlideConfigMapper.ensureInitialized()
        .encodeMap<TwoColumnHeaderSlideConfig>(
            this as TwoColumnHeaderSlideConfig);
  }

  TwoColumnHeaderSlideConfigCopyWith<TwoColumnHeaderSlideConfig,
          TwoColumnHeaderSlideConfig, TwoColumnHeaderSlideConfig>
      get copyWith => _TwoColumnHeaderSlideConfigCopyWithImpl(
          this as TwoColumnHeaderSlideConfig, $identity, $identity);
  @override
  String toString() {
    return TwoColumnHeaderSlideConfigMapper.ensureInitialized()
        .stringifyValue(this as TwoColumnHeaderSlideConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TwoColumnHeaderSlideConfigMapper.ensureInitialized()
                .isValueEqual(this as TwoColumnHeaderSlideConfig, other));
  }

  @override
  int get hashCode {
    return TwoColumnHeaderSlideConfigMapper.ensureInitialized()
        .hashValue(this as TwoColumnHeaderSlideConfig);
  }
}

extension TwoColumnHeaderSlideConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TwoColumnHeaderSlideConfig, $Out> {
  TwoColumnHeaderSlideConfigCopyWith<$R, TwoColumnHeaderSlideConfig, $Out>
      get $asTwoColumnHeaderSlideConfig => $base
          .as((v, t, t2) => _TwoColumnHeaderSlideConfigCopyWithImpl(v, t, t2));
}

abstract class TwoColumnHeaderSlideConfigCopyWith<
    $R,
    $In extends TwoColumnHeaderSlideConfig,
    $Out> implements SlideConfigCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? title,
      String? background,
      ContentAlignment? contentAlignment,
      String? content,
      String? variant});
  TwoColumnHeaderSlideConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TwoColumnHeaderSlideConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TwoColumnHeaderSlideConfig, $Out>
    implements
        TwoColumnHeaderSlideConfigCopyWith<$R, TwoColumnHeaderSlideConfig,
            $Out> {
  _TwoColumnHeaderSlideConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TwoColumnHeaderSlideConfig> $mapper =
      TwoColumnHeaderSlideConfigMapper.ensureInitialized();
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
  TwoColumnHeaderSlideConfig $make(
          CopyWithData data) =>
      TwoColumnHeaderSlideConfig(
          title: data.get(#title, or: $value.title),
          background: data.get(#background, or: $value.background),
          contentAlignment:
              data.get(#contentAlignment, or: $value.contentAlignment),
          content: data.get(#content, or: $value.content),
          variant: data.get(#variant, or: $value.variant));

  @override
  TwoColumnHeaderSlideConfigCopyWith<$R2, TwoColumnHeaderSlideConfig, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnHeaderSlideConfigCopyWithImpl($value, $cast, t);
}
