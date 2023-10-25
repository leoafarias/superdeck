// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_model.dart';

class SlideMapper extends ClassMapperBase<Slide> {
  SlideMapper._();

  static SlideMapper? _instance;
  static SlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideMapper._());
      ImageSlideMapper.ensureInitialized();
      TwoColumnSlideMapper.ensureInitialized();
      TwoColumnHeaderSlideMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Slide';

  static String _$id(Slide v) => v.id;
  static const Field<Slide, String> _f$id = Field('id', _$id);
  static String _$layout(Slide v) => v.layout;
  static const Field<Slide, String> _f$layout =
      Field('layout', _$layout, opt: true, def: BuiltinLayout.basic);
  static ContentAlignment _$contentAlignment(Slide v) => v.contentAlignment;
  static const Field<Slide, ContentAlignment> _f$contentAlignment = Field(
      'contentAlignment', _$contentAlignment,
      opt: true, def: ContentAlignment.centerLeft);
  static String? _$background(Slide v) => v.background;
  static const Field<Slide, String> _f$background =
      Field('background', _$background, opt: true);
  static String _$content(Slide v) => v.content;
  static const Field<Slide, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final Map<Symbol, Field<Slide, dynamic>> fields = const {
    #id: _f$id,
    #layout: _f$layout,
    #contentAlignment: _f$contentAlignment,
    #background: _f$background,
    #content: _f$content,
  };

  static Slide _instantiate(DecodingData data) {
    return Slide(
        id: data.dec(_f$id),
        layout: data.dec(_f$layout),
        contentAlignment: data.dec(_f$contentAlignment),
        background: data.dec(_f$background),
        content: data.dec(_f$content));
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
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SlideMapper.ensureInitialized().isValueEqual(this as Slide, other));
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
  $R call({String? id, String? layout, String? content});
  SlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Slide, $Out>
    implements SlideCopyWith<$R, Slide, $Out> {
  _SlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Slide> $mapper = SlideMapper.ensureInitialized();
  @override
  $R call({String? id, String? layout, String? content}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (layout != null) #layout: layout,
        if (content != null) #content: content
      }));
  @override
  Slide $make(CopyWithData data) => Slide(
      id: data.get(#id, or: $value.id),
      layout: data.get(#layout, or: $value.layout),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      background: data.get(#background, or: $value.background),
      content: data.get(#content, or: $value.content));

  @override
  SlideCopyWith<$R2, Slide, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SlideCopyWithImpl($value, $cast, t);
}

class ImageSlideMapper extends ClassMapperBase<ImageSlide> {
  ImageSlideMapper._();

  static ImageSlideMapper? _instance;
  static ImageSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageSlideMapper._());
      SlideMapper.ensureInitialized();
      ImageFitMapper.ensureInitialized();
      ImagePositionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageSlide';

  static ImageFit? _$imageFit(ImageSlide v) => v.imageFit;
  static const Field<ImageSlide, ImageFit> _f$imageFit =
      Field('imageFit', _$imageFit, opt: true);
  static String _$image(ImageSlide v) => v.image;
  static const Field<ImageSlide, String> _f$image =
      Field('image', _$image, opt: true, def: '');
  static ImagePosition _$imagePosition(ImageSlide v) => v.imagePosition;
  static const Field<ImageSlide, ImagePosition> _f$imagePosition = Field(
      'imagePosition', _$imagePosition,
      opt: true, def: ImagePosition.left);
  static String? _$background(ImageSlide v) => v.background;
  static const Field<ImageSlide, String> _f$background =
      Field('background', _$background, opt: true);
  static String _$content(ImageSlide v) => v.content;
  static const Field<ImageSlide, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String _$layout(ImageSlide v) => v.layout;
  static const Field<ImageSlide, String> _f$layout =
      Field('layout', _$layout, opt: true, def: BuiltinLayout.basic);
  static String _$id(ImageSlide v) => v.id;
  static const Field<ImageSlide, String> _f$id = Field('id', _$id);
  static ContentAlignment _$contentAlignment(ImageSlide v) =>
      v.contentAlignment;
  static const Field<ImageSlide, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<ImageSlide, dynamic>> fields = const {
    #imageFit: _f$imageFit,
    #image: _f$image,
    #imagePosition: _f$imagePosition,
    #background: _f$background,
    #content: _f$content,
    #layout: _f$layout,
    #id: _f$id,
    #contentAlignment: _f$contentAlignment,
  };

  static ImageSlide _instantiate(DecodingData data) {
    return ImageSlide(
        imageFit: data.dec(_f$imageFit),
        image: data.dec(_f$image),
        imagePosition: data.dec(_f$imagePosition),
        background: data.dec(_f$background),
        content: data.dec(_f$content),
        layout: data.dec(_f$layout),
        id: data.dec(_f$id));
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
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ImageSlideMapper.ensureInitialized()
                .isValueEqual(this as ImageSlide, other));
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
    implements SlideCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {ImageFit? imageFit,
      String? image,
      ImagePosition? imagePosition,
      String? background,
      String? content,
      String? layout,
      String? id});
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
  $R call(
          {Object? imageFit = $none,
          String? image,
          ImagePosition? imagePosition,
          Object? background = $none,
          String? content,
          String? layout,
          String? id}) =>
      $apply(FieldCopyWithData({
        if (imageFit != $none) #imageFit: imageFit,
        if (image != null) #image: image,
        if (imagePosition != null) #imagePosition: imagePosition,
        if (background != $none) #background: background,
        if (content != null) #content: content,
        if (layout != null) #layout: layout,
        if (id != null) #id: id
      }));
  @override
  ImageSlide $make(CopyWithData data) => ImageSlide(
      imageFit: data.get(#imageFit, or: $value.imageFit),
      image: data.get(#image, or: $value.image),
      imagePosition: data.get(#imagePosition, or: $value.imagePosition),
      background: data.get(#background, or: $value.background),
      content: data.get(#content, or: $value.content),
      layout: data.get(#layout, or: $value.layout),
      id: data.get(#id, or: $value.id));

  @override
  ImageSlideCopyWith<$R2, ImageSlide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageSlideCopyWithImpl($value, $cast, t);
}

class TwoColumnSlideMapper extends ClassMapperBase<TwoColumnSlide> {
  TwoColumnSlideMapper._();

  static TwoColumnSlideMapper? _instance;
  static TwoColumnSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TwoColumnSlideMapper._());
      SlideMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TwoColumnSlide';

  static String _$content(TwoColumnSlide v) => v.content;
  static const Field<TwoColumnSlide, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String _$layout(TwoColumnSlide v) => v.layout;
  static const Field<TwoColumnSlide, String> _f$layout =
      Field('layout', _$layout, opt: true, def: BuiltinLayout.basic);
  static String _$id(TwoColumnSlide v) => v.id;
  static const Field<TwoColumnSlide, String> _f$id = Field('id', _$id);
  static ContentAlignment _$contentAlignment(TwoColumnSlide v) =>
      v.contentAlignment;
  static const Field<TwoColumnSlide, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment, mode: FieldMode.member);
  static String? _$background(TwoColumnSlide v) => v.background;
  static const Field<TwoColumnSlide, String> _f$background =
      Field('background', _$background, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<TwoColumnSlide, dynamic>> fields = const {
    #content: _f$content,
    #layout: _f$layout,
    #id: _f$id,
    #contentAlignment: _f$contentAlignment,
    #background: _f$background,
  };

  static TwoColumnSlide _instantiate(DecodingData data) {
    return TwoColumnSlide(
        content: data.dec(_f$content),
        layout: data.dec(_f$layout),
        id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static TwoColumnSlide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TwoColumnSlide>(map);
  }

  static TwoColumnSlide fromJson(String json) {
    return ensureInitialized().decodeJson<TwoColumnSlide>(json);
  }
}

mixin TwoColumnSlideMappable {
  String toJson() {
    return TwoColumnSlideMapper.ensureInitialized()
        .encodeJson<TwoColumnSlide>(this as TwoColumnSlide);
  }

  Map<String, dynamic> toMap() {
    return TwoColumnSlideMapper.ensureInitialized()
        .encodeMap<TwoColumnSlide>(this as TwoColumnSlide);
  }

  TwoColumnSlideCopyWith<TwoColumnSlide, TwoColumnSlide, TwoColumnSlide>
      get copyWith => _TwoColumnSlideCopyWithImpl(
          this as TwoColumnSlide, $identity, $identity);
  @override
  String toString() {
    return TwoColumnSlideMapper.ensureInitialized()
        .stringifyValue(this as TwoColumnSlide);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TwoColumnSlideMapper.ensureInitialized()
                .isValueEqual(this as TwoColumnSlide, other));
  }

  @override
  int get hashCode {
    return TwoColumnSlideMapper.ensureInitialized()
        .hashValue(this as TwoColumnSlide);
  }
}

extension TwoColumnSlideValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TwoColumnSlide, $Out> {
  TwoColumnSlideCopyWith<$R, TwoColumnSlide, $Out> get $asTwoColumnSlide =>
      $base.as((v, t, t2) => _TwoColumnSlideCopyWithImpl(v, t, t2));
}

abstract class TwoColumnSlideCopyWith<$R, $In extends TwoColumnSlide, $Out>
    implements SlideCopyWith<$R, $In, $Out> {
  @override
  $R call({String? content, String? layout, String? id});
  TwoColumnSlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TwoColumnSlideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TwoColumnSlide, $Out>
    implements TwoColumnSlideCopyWith<$R, TwoColumnSlide, $Out> {
  _TwoColumnSlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TwoColumnSlide> $mapper =
      TwoColumnSlideMapper.ensureInitialized();
  @override
  $R call({String? content, String? layout, String? id}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (layout != null) #layout: layout,
        if (id != null) #id: id
      }));
  @override
  TwoColumnSlide $make(CopyWithData data) => TwoColumnSlide(
      content: data.get(#content, or: $value.content),
      layout: data.get(#layout, or: $value.layout),
      id: data.get(#id, or: $value.id));

  @override
  TwoColumnSlideCopyWith<$R2, TwoColumnSlide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TwoColumnSlideCopyWithImpl($value, $cast, t);
}

class TwoColumnHeaderSlideMapper extends ClassMapperBase<TwoColumnHeaderSlide> {
  TwoColumnHeaderSlideMapper._();

  static TwoColumnHeaderSlideMapper? _instance;
  static TwoColumnHeaderSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TwoColumnHeaderSlideMapper._());
      SlideMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TwoColumnHeaderSlide';

  static String _$layout(TwoColumnHeaderSlide v) => v.layout;
  static const Field<TwoColumnHeaderSlide, String> _f$layout =
      Field('layout', _$layout, opt: true, def: BuiltinLayout.basic);
  static String? _$background(TwoColumnHeaderSlide v) => v.background;
  static const Field<TwoColumnHeaderSlide, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(TwoColumnHeaderSlide v) =>
      v.contentAlignment;
  static const Field<TwoColumnHeaderSlide, ContentAlignment>
      _f$contentAlignment = Field('contentAlignment', _$contentAlignment,
          opt: true, def: ContentAlignment.centerLeft);
  static String _$content(TwoColumnHeaderSlide v) => v.content;
  static const Field<TwoColumnHeaderSlide, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String _$id(TwoColumnHeaderSlide v) => v.id;
  static const Field<TwoColumnHeaderSlide, String> _f$id = Field('id', _$id);

  @override
  final Map<Symbol, Field<TwoColumnHeaderSlide, dynamic>> fields = const {
    #layout: _f$layout,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #id: _f$id,
  };

  static TwoColumnHeaderSlide _instantiate(DecodingData data) {
    return TwoColumnHeaderSlide(
        layout: data.dec(_f$layout),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static TwoColumnHeaderSlide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TwoColumnHeaderSlide>(map);
  }

  static TwoColumnHeaderSlide fromJson(String json) {
    return ensureInitialized().decodeJson<TwoColumnHeaderSlide>(json);
  }
}

mixin TwoColumnHeaderSlideMappable {
  String toJson() {
    return TwoColumnHeaderSlideMapper.ensureInitialized()
        .encodeJson<TwoColumnHeaderSlide>(this as TwoColumnHeaderSlide);
  }

  Map<String, dynamic> toMap() {
    return TwoColumnHeaderSlideMapper.ensureInitialized()
        .encodeMap<TwoColumnHeaderSlide>(this as TwoColumnHeaderSlide);
  }

  TwoColumnHeaderSlideCopyWith<TwoColumnHeaderSlide, TwoColumnHeaderSlide,
          TwoColumnHeaderSlide>
      get copyWith => _TwoColumnHeaderSlideCopyWithImpl(
          this as TwoColumnHeaderSlide, $identity, $identity);
  @override
  String toString() {
    return TwoColumnHeaderSlideMapper.ensureInitialized()
        .stringifyValue(this as TwoColumnHeaderSlide);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TwoColumnHeaderSlideMapper.ensureInitialized()
                .isValueEqual(this as TwoColumnHeaderSlide, other));
  }

  @override
  int get hashCode {
    return TwoColumnHeaderSlideMapper.ensureInitialized()
        .hashValue(this as TwoColumnHeaderSlide);
  }
}

extension TwoColumnHeaderSlideValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TwoColumnHeaderSlide, $Out> {
  TwoColumnHeaderSlideCopyWith<$R, TwoColumnHeaderSlide, $Out>
      get $asTwoColumnHeaderSlide =>
          $base.as((v, t, t2) => _TwoColumnHeaderSlideCopyWithImpl(v, t, t2));
}

abstract class TwoColumnHeaderSlideCopyWith<
    $R,
    $In extends TwoColumnHeaderSlide,
    $Out> implements SlideCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? layout,
      String? background,
      ContentAlignment? contentAlignment,
      String? content,
      String? id});
  TwoColumnHeaderSlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TwoColumnHeaderSlideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TwoColumnHeaderSlide, $Out>
    implements TwoColumnHeaderSlideCopyWith<$R, TwoColumnHeaderSlide, $Out> {
  _TwoColumnHeaderSlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TwoColumnHeaderSlide> $mapper =
      TwoColumnHeaderSlideMapper.ensureInitialized();
  @override
  $R call(
          {String? layout,
          Object? background = $none,
          ContentAlignment? contentAlignment,
          String? content,
          String? id}) =>
      $apply(FieldCopyWithData({
        if (layout != null) #layout: layout,
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content,
        if (id != null) #id: id
      }));
  @override
  TwoColumnHeaderSlide $make(CopyWithData data) => TwoColumnHeaderSlide(
      layout: data.get(#layout, or: $value.layout),
      background: data.get(#background, or: $value.background),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content),
      id: data.get(#id, or: $value.id));

  @override
  TwoColumnHeaderSlideCopyWith<$R2, TwoColumnHeaderSlide, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnHeaderSlideCopyWithImpl($value, $cast, t);
}
