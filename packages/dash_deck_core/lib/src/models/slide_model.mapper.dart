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
      CoverSlideMapper.ensureInitialized();
      ImageSlideMapper.ensureInitialized();
      FullSlideMapper.ensureInitialized();
      TwoColumnSlideMapper.ensureInitialized();
      TwoColumnHeaderSlideMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Slide';

  static String _$layout(Slide v) => v.layout;
  static const Field<Slide, String> _f$layout =
      Field('layout', _$layout, opt: true, def: BuiltinLayout.none);
  static ContentAlignment _$contentAlignment(Slide v) => v.contentAlignment;
  static const Field<Slide, ContentAlignment> _f$contentAlignment = Field(
      'contentAlignment', _$contentAlignment,
      opt: true, def: ContentAlignment.center);
  static String _$content(Slide v) => v.content;
  static const Field<Slide, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final Map<Symbol, Field<Slide, dynamic>> fields = const {
    #layout: _f$layout,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
  };

  static Slide _instantiate(DecodingData data) {
    return Slide(
        layout: data.dec(_f$layout),
        contentAlignment: data.dec(_f$contentAlignment),
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
  $R call({String? layout, String? content});
  SlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Slide, $Out>
    implements SlideCopyWith<$R, Slide, $Out> {
  _SlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Slide> $mapper = SlideMapper.ensureInitialized();
  @override
  $R call({String? layout, String? content}) => $apply(FieldCopyWithData({
        if (layout != null) #layout: layout,
        if (content != null) #content: content
      }));
  @override
  Slide $make(CopyWithData data) => Slide(
      layout: data.get(#layout, or: $value.layout),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content));

  @override
  SlideCopyWith<$R2, Slide, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SlideCopyWithImpl($value, $cast, t);
}

class CoverSlideMapper extends ClassMapperBase<CoverSlide> {
  CoverSlideMapper._();

  static CoverSlideMapper? _instance;
  static CoverSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CoverSlideMapper._());
      SlideMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CoverSlide';

  static String? _$background(CoverSlide v) => v.background;
  static const Field<CoverSlide, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(CoverSlide v) =>
      v.contentAlignment;
  static const Field<CoverSlide, ContentAlignment> _f$contentAlignment = Field(
      'contentAlignment', _$contentAlignment,
      opt: true, def: ContentAlignment.center);
  static String _$content(CoverSlide v) => v.content;
  static const Field<CoverSlide, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String _$layout(CoverSlide v) => v.layout;
  static const Field<CoverSlide, String> _f$layout =
      Field('layout', _$layout, opt: true, def: BuiltinLayout.none);

  @override
  final Map<Symbol, Field<CoverSlide, dynamic>> fields = const {
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
    #layout: _f$layout,
  };

  static CoverSlide _instantiate(DecodingData data) {
    return CoverSlide(
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content),
        layout: data.dec(_f$layout));
  }

  @override
  final Function instantiate = _instantiate;

  static CoverSlide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CoverSlide>(map);
  }

  static CoverSlide fromJson(String json) {
    return ensureInitialized().decodeJson<CoverSlide>(json);
  }
}

mixin CoverSlideMappable {
  String toJson() {
    return CoverSlideMapper.ensureInitialized()
        .encodeJson<CoverSlide>(this as CoverSlide);
  }

  Map<String, dynamic> toMap() {
    return CoverSlideMapper.ensureInitialized()
        .encodeMap<CoverSlide>(this as CoverSlide);
  }

  CoverSlideCopyWith<CoverSlide, CoverSlide, CoverSlide> get copyWith =>
      _CoverSlideCopyWithImpl(this as CoverSlide, $identity, $identity);
  @override
  String toString() {
    return CoverSlideMapper.ensureInitialized()
        .stringifyValue(this as CoverSlide);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            CoverSlideMapper.ensureInitialized()
                .isValueEqual(this as CoverSlide, other));
  }

  @override
  int get hashCode {
    return CoverSlideMapper.ensureInitialized().hashValue(this as CoverSlide);
  }
}

extension CoverSlideValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CoverSlide, $Out> {
  CoverSlideCopyWith<$R, CoverSlide, $Out> get $asCoverSlide =>
      $base.as((v, t, t2) => _CoverSlideCopyWithImpl(v, t, t2));
}

abstract class CoverSlideCopyWith<$R, $In extends CoverSlide, $Out>
    implements SlideCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? background,
      ContentAlignment? contentAlignment,
      String? content,
      String? layout});
  CoverSlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CoverSlideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CoverSlide, $Out>
    implements CoverSlideCopyWith<$R, CoverSlide, $Out> {
  _CoverSlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CoverSlide> $mapper =
      CoverSlideMapper.ensureInitialized();
  @override
  $R call(
          {Object? background = $none,
          ContentAlignment? contentAlignment,
          String? content,
          String? layout}) =>
      $apply(FieldCopyWithData({
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content,
        if (layout != null) #layout: layout
      }));
  @override
  CoverSlide $make(CopyWithData data) => CoverSlide(
      background: data.get(#background, or: $value.background),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content),
      layout: data.get(#layout, or: $value.layout));

  @override
  CoverSlideCopyWith<$R2, CoverSlide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CoverSlideCopyWithImpl($value, $cast, t);
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
  static String _$content(ImageSlide v) => v.content;
  static const Field<ImageSlide, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String _$layout(ImageSlide v) => v.layout;
  static const Field<ImageSlide, String> _f$layout =
      Field('layout', _$layout, opt: true, def: BuiltinLayout.none);
  static ContentAlignment _$contentAlignment(ImageSlide v) =>
      v.contentAlignment;
  static const Field<ImageSlide, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<ImageSlide, dynamic>> fields = const {
    #imageFit: _f$imageFit,
    #image: _f$image,
    #imagePosition: _f$imagePosition,
    #content: _f$content,
    #layout: _f$layout,
    #contentAlignment: _f$contentAlignment,
  };

  static ImageSlide _instantiate(DecodingData data) {
    return ImageSlide(
        imageFit: data.dec(_f$imageFit),
        image: data.dec(_f$image),
        imagePosition: data.dec(_f$imagePosition),
        content: data.dec(_f$content),
        layout: data.dec(_f$layout));
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
      String? content,
      String? layout});
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
          String? content,
          String? layout}) =>
      $apply(FieldCopyWithData({
        if (imageFit != $none) #imageFit: imageFit,
        if (image != null) #image: image,
        if (imagePosition != null) #imagePosition: imagePosition,
        if (content != null) #content: content,
        if (layout != null) #layout: layout
      }));
  @override
  ImageSlide $make(CopyWithData data) => ImageSlide(
      imageFit: data.get(#imageFit, or: $value.imageFit),
      image: data.get(#image, or: $value.image),
      imagePosition: data.get(#imagePosition, or: $value.imagePosition),
      content: data.get(#content, or: $value.content),
      layout: data.get(#layout, or: $value.layout));

  @override
  ImageSlideCopyWith<$R2, ImageSlide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageSlideCopyWithImpl($value, $cast, t);
}

class FullSlideMapper extends ClassMapperBase<FullSlide> {
  FullSlideMapper._();

  static FullSlideMapper? _instance;
  static FullSlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FullSlideMapper._());
      SlideMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FullSlide';

  static String _$content(FullSlide v) => v.content;
  static const Field<FullSlide, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String _$layout(FullSlide v) => v.layout;
  static const Field<FullSlide, String> _f$layout =
      Field('layout', _$layout, opt: true, def: BuiltinLayout.none);
  static ContentAlignment _$contentAlignment(FullSlide v) => v.contentAlignment;
  static const Field<FullSlide, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<FullSlide, dynamic>> fields = const {
    #content: _f$content,
    #layout: _f$layout,
    #contentAlignment: _f$contentAlignment,
  };

  static FullSlide _instantiate(DecodingData data) {
    return FullSlide(
        content: data.dec(_f$content), layout: data.dec(_f$layout));
  }

  @override
  final Function instantiate = _instantiate;

  static FullSlide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FullSlide>(map);
  }

  static FullSlide fromJson(String json) {
    return ensureInitialized().decodeJson<FullSlide>(json);
  }
}

mixin FullSlideMappable {
  String toJson() {
    return FullSlideMapper.ensureInitialized()
        .encodeJson<FullSlide>(this as FullSlide);
  }

  Map<String, dynamic> toMap() {
    return FullSlideMapper.ensureInitialized()
        .encodeMap<FullSlide>(this as FullSlide);
  }

  FullSlideCopyWith<FullSlide, FullSlide, FullSlide> get copyWith =>
      _FullSlideCopyWithImpl(this as FullSlide, $identity, $identity);
  @override
  String toString() {
    return FullSlideMapper.ensureInitialized()
        .stringifyValue(this as FullSlide);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            FullSlideMapper.ensureInitialized()
                .isValueEqual(this as FullSlide, other));
  }

  @override
  int get hashCode {
    return FullSlideMapper.ensureInitialized().hashValue(this as FullSlide);
  }
}

extension FullSlideValueCopy<$R, $Out> on ObjectCopyWith<$R, FullSlide, $Out> {
  FullSlideCopyWith<$R, FullSlide, $Out> get $asFullSlide =>
      $base.as((v, t, t2) => _FullSlideCopyWithImpl(v, t, t2));
}

abstract class FullSlideCopyWith<$R, $In extends FullSlide, $Out>
    implements SlideCopyWith<$R, $In, $Out> {
  @override
  $R call({String? content, String? layout});
  FullSlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FullSlideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FullSlide, $Out>
    implements FullSlideCopyWith<$R, FullSlide, $Out> {
  _FullSlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FullSlide> $mapper =
      FullSlideMapper.ensureInitialized();
  @override
  $R call({String? content, String? layout}) => $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (layout != null) #layout: layout
      }));
  @override
  FullSlide $make(CopyWithData data) => FullSlide(
      content: data.get(#content, or: $value.content),
      layout: data.get(#layout, or: $value.layout));

  @override
  FullSlideCopyWith<$R2, FullSlide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FullSlideCopyWithImpl($value, $cast, t);
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
      Field('layout', _$layout, opt: true, def: BuiltinLayout.none);
  static ContentAlignment _$contentAlignment(TwoColumnSlide v) =>
      v.contentAlignment;
  static const Field<TwoColumnSlide, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<TwoColumnSlide, dynamic>> fields = const {
    #content: _f$content,
    #layout: _f$layout,
    #contentAlignment: _f$contentAlignment,
  };

  static TwoColumnSlide _instantiate(DecodingData data) {
    return TwoColumnSlide(
        content: data.dec(_f$content), layout: data.dec(_f$layout));
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
  $R call({String? content, String? layout});
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
  $R call({String? content, String? layout}) => $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (layout != null) #layout: layout
      }));
  @override
  TwoColumnSlide $make(CopyWithData data) => TwoColumnSlide(
      content: data.get(#content, or: $value.content),
      layout: data.get(#layout, or: $value.layout));

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
    }
    return _instance!;
  }

  @override
  final String id = 'TwoColumnHeaderSlide';

  static String _$content(TwoColumnHeaderSlide v) => v.content;
  static const Field<TwoColumnHeaderSlide, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static String _$layout(TwoColumnHeaderSlide v) => v.layout;
  static const Field<TwoColumnHeaderSlide, String> _f$layout =
      Field('layout', _$layout, opt: true, def: BuiltinLayout.none);
  static ContentAlignment _$contentAlignment(TwoColumnHeaderSlide v) =>
      v.contentAlignment;
  static const Field<TwoColumnHeaderSlide, ContentAlignment>
      _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<TwoColumnHeaderSlide, dynamic>> fields = const {
    #content: _f$content,
    #layout: _f$layout,
    #contentAlignment: _f$contentAlignment,
  };

  static TwoColumnHeaderSlide _instantiate(DecodingData data) {
    return TwoColumnHeaderSlide(
        content: data.dec(_f$content), layout: data.dec(_f$layout));
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
  $R call({String? content, String? layout});
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
  $R call({String? content, String? layout}) => $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (layout != null) #layout: layout
      }));
  @override
  TwoColumnHeaderSlide $make(CopyWithData data) => TwoColumnHeaderSlide(
      content: data.get(#content, or: $value.content),
      layout: data.get(#layout, or: $value.layout));

  @override
  TwoColumnHeaderSlideCopyWith<$R2, TwoColumnHeaderSlide, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnHeaderSlideCopyWithImpl($value, $cast, t);
}
