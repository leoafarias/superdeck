import 'package:dart_mappable/dart_mappable.dart';

import '../superdeck.dart';
import 'slide_options_model.dart';
import 'syntax_tag.dart';

part 'config_model.mapper.dart';

class LayoutTypes {
  LayoutTypes._();
  static const image = 'image';
  static const simple = 'simple';
  static const preview = 'preview';
  static const twoColumn = 'two_column';
  static const twoColumnHeader = 'two_column_header';
  static const invalid = 'invalid';

  static const values = [
    image,
    simple,
    preview,
    twoColumn,
    twoColumnHeader,
    invalid,
  ];
}

@MappableClass(discriminatorKey: 'layout')
abstract class SlideOptions with SlideOptionsMappable {
  final String? title;
  final String layout;
  final String? background;
  final ContentAlignment alignment;
  final String content;
  final String? style;
  final TransitionOptions? transition;

  const SlideOptions({
    required this.layout,
    required this.title,
    this.background,
    this.content = '',
    required this.style,
    this.alignment = ContentAlignment.centerLeft,
    required this.transition,
  });

  SlideVariant get styleVariant {
    return style == null ? SlideVariant.none : SlideVariant(style!);
  }

  static const fromMap = SlideOptionsMapper.fromMap;
  static const fromJson = SlideOptionsMapper.fromJson;
}

@MappableClass(discriminatorValue: MappableClass.useAsDefault)
class SimpleSlideOptions extends SlideOptions with SimpleSlideOptionsMappable {
  const SimpleSlideOptions({
    super.title,
    super.background,
    super.alignment,
    super.content,
    super.style,
    super.transition,
  }) : super(layout: LayoutTypes.simple);

  static const fromMap = SimpleSlideOptionsMapper.fromMap;
  static const fromJson = SimpleSlideOptionsMapper.fromJson;
}

@MappableClass(discriminatorValue: LayoutTypes.image)
class ImageSlideOptions extends SlideOptions with ImageSlideOptionsMappable {
  final ImageOptions image;

  const ImageSlideOptions({
    super.title,
    required this.image,
    super.style,
    super.background,
    super.content,
    super.alignment,
    super.transition,
  }) : super(layout: LayoutTypes.image);

  static const fromMap = ImageSlideOptionsMapper.fromMap;
  static const fromJson = ImageSlideOptionsMapper.fromJson;
}

@MappableClass(discriminatorValue: LayoutTypes.preview)
class PreviewSlideOptions extends SlideOptions
    with PreviewSlideOptionsMappable {
  final PreviewOptions widget;

  const PreviewSlideOptions({
    super.title,
    required this.widget,
    super.style,
    super.background,
    super.content,
    super.alignment,
    super.transition,
  }) : super(layout: LayoutTypes.preview);

  static const fromMap = PreviewSlideOptionsMapper.fromMap;
  static const fromJson = PreviewSlideOptionsMapper.fromJson;
}

@MappableClass(discriminatorValue: LayoutTypes.twoColumn)
class TwoColumnSlideOptions extends SlideOptions
    with TwoColumnSlideOptionsMappable {
  late Map<String, String> _sections;

  TwoColumnSlideOptions({
    super.title,
    super.background,
    super.alignment,
    super.content,
    super.style,
    super.transition,
  }) : super(layout: LayoutTypes.twoColumn) {
    _sections = parseContentSections(content);
  }

  String get leftContent =>
      _sections[SectionTag.left] ?? _sections[SectionTag.first] ?? '';

  String get rightContent => _sections[SectionTag.right] ?? '';

  static const fromMap = TwoColumnSlideOptionsMapper.fromMap;
  static const fromJson = TwoColumnSlideOptionsMapper.fromJson;
}

@MappableClass(discriminatorValue: LayoutTypes.twoColumnHeader)
class TwoColumnHeaderSlideOptions extends SlideOptions
    with TwoColumnHeaderSlideOptionsMappable {
  late Map<String, String> _sections;
  TwoColumnHeaderSlideOptions({
    super.title,
    super.background,
    super.alignment,
    super.content = '',
    super.style,
    super.transition,
  }) : super(layout: LayoutTypes.twoColumnHeader) {
    _sections = parseContentSections(content);
  }

  String get topContent => _sections[SectionTag.first] ?? '';

  String get leftContent => _sections[SectionTag.left] ?? '';

  String get rightContent => _sections[SectionTag.right] ?? '';

  static const fromMap = TwoColumnHeaderSlideOptionsMapper.fromMap;
  static const fromJson = TwoColumnHeaderSlideOptionsMapper.fromJson;
}

@MappableClass(discriminatorValue: LayoutTypes.invalid)
class InvalidSlideOptions extends SlideOptions
    with InvalidSlideOptionsMappable {
  const InvalidSlideOptions({
    super.title,
    super.background,
    super.alignment,
    super.content,
    super.style,
    super.transition,
  }) : super(layout: LayoutTypes.invalid);

  static const fromMap = InvalidSlideOptionsMapper.fromMap;
  static const fromJson = InvalidSlideOptionsMapper.fromJson;
}
