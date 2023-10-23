// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_options.model.dart';

class SlideLayoutMapper extends EnumMapper<SlideLayout> {
  SlideLayoutMapper._();

  static SlideLayoutMapper? _instance;
  static SlideLayoutMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideLayoutMapper._());
    }
    return _instance!;
  }

  static SlideLayout fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SlideLayout decode(dynamic value) {
    switch (value) {
      case 'none':
        return SlideLayout.none;
      case 'cover':
        return SlideLayout.cover;
      case 'contentLeft':
        return SlideLayout.contentLeft;
      case 'contentRight':
        return SlideLayout.contentRight;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SlideLayout self) {
    switch (self) {
      case SlideLayout.none:
        return 'none';
      case SlideLayout.cover:
        return 'cover';
      case SlideLayout.contentLeft:
        return 'contentLeft';
      case SlideLayout.contentRight:
        return 'contentRight';
    }
  }
}

extension SlideLayoutMapperExtension on SlideLayout {
  String toValue() {
    SlideLayoutMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SlideLayout>(this) as String;
  }
}

class ImageFitMapper extends EnumMapper<ImageFit> {
  ImageFitMapper._();

  static ImageFitMapper? _instance;
  static ImageFitMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageFitMapper._());
    }
    return _instance!;
  }

  static ImageFit fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ImageFit decode(dynamic value) {
    switch (value) {
      case 'cover':
        return ImageFit.cover;
      case 'contain':
        return ImageFit.contain;
      case 'fill':
        return ImageFit.fill;
      case 'fitHeight':
        return ImageFit.fitHeight;
      case 'fitWidth':
        return ImageFit.fitWidth;
      case 'none':
        return ImageFit.none;
      case 'scaleDown':
        return ImageFit.scaleDown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ImageFit self) {
    switch (self) {
      case ImageFit.cover:
        return 'cover';
      case ImageFit.contain:
        return 'contain';
      case ImageFit.fill:
        return 'fill';
      case ImageFit.fitHeight:
        return 'fitHeight';
      case ImageFit.fitWidth:
        return 'fitWidth';
      case ImageFit.none:
        return 'none';
      case ImageFit.scaleDown:
        return 'scaleDown';
    }
  }
}

extension ImageFitMapperExtension on ImageFit {
  String toValue() {
    ImageFitMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ImageFit>(this) as String;
  }
}

class VerticalAlignmentMapper extends EnumMapper<VerticalAlignment> {
  VerticalAlignmentMapper._();

  static VerticalAlignmentMapper? _instance;
  static VerticalAlignmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VerticalAlignmentMapper._());
    }
    return _instance!;
  }

  static VerticalAlignment fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  VerticalAlignment decode(dynamic value) {
    switch (value) {
      case 'top':
        return VerticalAlignment.top;
      case 'center':
        return VerticalAlignment.center;
      case 'bottom':
        return VerticalAlignment.bottom;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(VerticalAlignment self) {
    switch (self) {
      case VerticalAlignment.top:
        return 'top';
      case VerticalAlignment.center:
        return 'center';
      case VerticalAlignment.bottom:
        return 'bottom';
    }
  }
}

extension VerticalAlignmentMapperExtension on VerticalAlignment {
  String toValue() {
    VerticalAlignmentMapper.ensureInitialized();
    return MapperContainer.globals.toValue<VerticalAlignment>(this) as String;
  }
}

class ContentAlignmentMapper extends EnumMapper<ContentAlignment> {
  ContentAlignmentMapper._();

  static ContentAlignmentMapper? _instance;
  static ContentAlignmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentAlignmentMapper._());
    }
    return _instance!;
  }

  static ContentAlignment fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ContentAlignment decode(dynamic value) {
    switch (value) {
      case 'topLeft':
        return ContentAlignment.topLeft;
      case 'topCenter':
        return ContentAlignment.topCenter;
      case 'topRight':
        return ContentAlignment.topRight;
      case 'centerLeft':
        return ContentAlignment.centerLeft;
      case 'center':
        return ContentAlignment.center;
      case 'centerRight':
        return ContentAlignment.centerRight;
      case 'bottomLeft':
        return ContentAlignment.bottomLeft;
      case 'bottomCenter':
        return ContentAlignment.bottomCenter;
      case 'bottomRight':
        return ContentAlignment.bottomRight;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ContentAlignment self) {
    switch (self) {
      case ContentAlignment.topLeft:
        return 'topLeft';
      case ContentAlignment.topCenter:
        return 'topCenter';
      case ContentAlignment.topRight:
        return 'topRight';
      case ContentAlignment.centerLeft:
        return 'centerLeft';
      case ContentAlignment.center:
        return 'center';
      case ContentAlignment.centerRight:
        return 'centerRight';
      case ContentAlignment.bottomLeft:
        return 'bottomLeft';
      case ContentAlignment.bottomCenter:
        return 'bottomCenter';
      case ContentAlignment.bottomRight:
        return 'bottomRight';
    }
  }
}

extension ContentAlignmentMapperExtension on ContentAlignment {
  String toValue() {
    ContentAlignmentMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ContentAlignment>(this) as String;
  }
}

class HorizontalAlignmentMapper extends EnumMapper<HorizontalAlignment> {
  HorizontalAlignmentMapper._();

  static HorizontalAlignmentMapper? _instance;
  static HorizontalAlignmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HorizontalAlignmentMapper._());
    }
    return _instance!;
  }

  static HorizontalAlignment fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  HorizontalAlignment decode(dynamic value) {
    switch (value) {
      case 'left':
        return HorizontalAlignment.left;
      case 'center':
        return HorizontalAlignment.center;
      case 'right':
        return HorizontalAlignment.right;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(HorizontalAlignment self) {
    switch (self) {
      case HorizontalAlignment.left:
        return 'left';
      case HorizontalAlignment.center:
        return 'center';
      case HorizontalAlignment.right:
        return 'right';
    }
  }
}

extension HorizontalAlignmentMapperExtension on HorizontalAlignment {
  String toValue() {
    HorizontalAlignmentMapper.ensureInitialized();
    return MapperContainer.globals.toValue<HorizontalAlignment>(this) as String;
  }
}

class SlideOptionsMapper extends ClassMapperBase<SlideOptions> {
  SlideOptionsMapper._();

  static SlideOptionsMapper? _instance;
  static SlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideOptionsMapper._());
      SlideLayoutMapper.ensureInitialized();
      ImageFitMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideOptions';

  static bool _$scrollable(SlideOptions v) => v.scrollable;
  static const Field<SlideOptions, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static SlideLayout _$layout(SlideOptions v) => v.layout;
  static const Field<SlideOptions, SlideLayout> _f$layout =
      Field('layout', _$layout, opt: true, def: SlideLayout.none);
  static String? _$background(SlideOptions v) => v.background;
  static const Field<SlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static ImageFit _$backgroundFit(SlideOptions v) => v.backgroundFit;
  static const Field<SlideOptions, ImageFit> _f$backgroundFit =
      Field('backgroundFit', _$backgroundFit, opt: true, def: ImageFit.cover);
  static ContentAlignment _$contentAlignment(SlideOptions v) =>
      v.contentAlignment;
  static const Field<SlideOptions, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment,
          opt: true, def: ContentAlignment.center);
  static String? _$styles(SlideOptions v) => v.styles;
  static const Field<SlideOptions, String> _f$styles =
      Field('styles', _$styles, opt: true);

  @override
  final Map<Symbol, Field<SlideOptions, dynamic>> fields = const {
    #scrollable: _f$scrollable,
    #layout: _f$layout,
    #background: _f$background,
    #backgroundFit: _f$backgroundFit,
    #contentAlignment: _f$contentAlignment,
    #styles: _f$styles,
  };

  static SlideOptions _instantiate(DecodingData data) {
    return SlideOptions(
        scrollable: data.dec(_f$scrollable),
        layout: data.dec(_f$layout),
        background: data.dec(_f$background),
        backgroundFit: data.dec(_f$backgroundFit),
        contentAlignment: data.dec(_f$contentAlignment),
        styles: data.dec(_f$styles));
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
  String toJson() {
    return SlideOptionsMapper.ensureInitialized()
        .encodeJson<SlideOptions>(this as SlideOptions);
  }

  Map<String, dynamic> toMap() {
    return SlideOptionsMapper.ensureInitialized()
        .encodeMap<SlideOptions>(this as SlideOptions);
  }

  SlideOptionsCopyWith<SlideOptions, SlideOptions, SlideOptions> get copyWith =>
      _SlideOptionsCopyWithImpl(this as SlideOptions, $identity, $identity);
  @override
  String toString() {
    return SlideOptionsMapper.ensureInitialized()
        .stringifyValue(this as SlideOptions);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SlideOptionsMapper.ensureInitialized()
                .isValueEqual(this as SlideOptions, other));
  }

  @override
  int get hashCode {
    return SlideOptionsMapper.ensureInitialized()
        .hashValue(this as SlideOptions);
  }
}

extension SlideOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SlideOptions, $Out> {
  SlideOptionsCopyWith<$R, SlideOptions, $Out> get $asSlideOptions =>
      $base.as((v, t, t2) => _SlideOptionsCopyWithImpl(v, t, t2));
}

abstract class SlideOptionsCopyWith<$R, $In extends SlideOptions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {bool? scrollable,
      SlideLayout? layout,
      String? background,
      ImageFit? backgroundFit,
      ContentAlignment? contentAlignment,
      String? styles});
  SlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SlideOptions, $Out>
    implements SlideOptionsCopyWith<$R, SlideOptions, $Out> {
  _SlideOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SlideOptions> $mapper =
      SlideOptionsMapper.ensureInitialized();
  @override
  $R call(
          {bool? scrollable,
          SlideLayout? layout,
          Object? background = $none,
          ImageFit? backgroundFit,
          ContentAlignment? contentAlignment,
          Object? styles = $none}) =>
      $apply(FieldCopyWithData({
        if (scrollable != null) #scrollable: scrollable,
        if (layout != null) #layout: layout,
        if (background != $none) #background: background,
        if (backgroundFit != null) #backgroundFit: backgroundFit,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (styles != $none) #styles: styles
      }));
  @override
  SlideOptions $make(CopyWithData data) => SlideOptions(
      scrollable: data.get(#scrollable, or: $value.scrollable),
      layout: data.get(#layout, or: $value.layout),
      background: data.get(#background, or: $value.background),
      backgroundFit: data.get(#backgroundFit, or: $value.backgroundFit),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      styles: data.get(#styles, or: $value.styles));

  @override
  SlideOptionsCopyWith<$R2, SlideOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideOptionsCopyWithImpl($value, $cast, t);
}
