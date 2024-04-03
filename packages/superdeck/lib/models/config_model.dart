import 'package:dart_mappable/dart_mappable.dart';

import '../superdeck.dart';
import 'slide_options_model.dart';
import 'syntax_tag.dart';

part 'config_model.mapper.dart';

@MappableClass()
abstract class SlideOptions with SlideOptionsMappable {
  final String? title;
  final String? background;
  final ContentAlignment contentAlignment;
  final String content;
  final String? style;

  const SlideOptions({
    required this.title,
    this.background,
    this.content = '',
    required this.style,
    this.contentAlignment = ContentAlignment.centerLeft,
  });

  String get layoutId;

  SlideVariant get styleVariant {
    return style == null ? SlideVariant.none : SlideVariant(style!);
  }

  static const fromMap = SlideOptionsMapper.fromMap;
  static const fromJson = SlideOptionsMapper.fromJson;
}

@MappableClass()
class SimpleSlideOptions extends SlideOptions with SimpleSlideOptionsMappable {
  const SimpleSlideOptions({
    super.title,
    super.background,
    super.contentAlignment,
    super.content,
    super.style,
  });

  @override
  String get layoutId => layout;

  static const layout = 'simple';

  static const fromMap = SimpleSlideOptionsMapper.fromMap;
  static const fromJson = SimpleSlideOptionsMapper.fromJson;
}

@MappableClass()
class ImageSlideOptions extends SlideOptions with ImageSlideOptionsMappable {
  final ImageOptions image;

  const ImageSlideOptions({
    super.title,
    required this.image,
    super.style,
    super.background,
    super.content,
    super.contentAlignment,
  });

  static const fromMap = ImageSlideOptionsMapper.fromMap;
  static const fromJson = ImageSlideOptionsMapper.fromJson;

  @override
  String get layoutId => layout;

  static const layout = 'image';
}

@MappableClass()
class PreviewSlideOptions extends SlideOptions
    with PreviewSlideOptionsMappable {
  final PreviewOptions widget;

  const PreviewSlideOptions({
    super.title,
    required this.widget,
    super.style,
    super.background,
    super.content,
    super.contentAlignment,
  });

  static const fromMap = PreviewSlideOptionsMapper.fromMap;
  static const fromJson = PreviewSlideOptionsMapper.fromJson;

  @override
  String get layoutId => layout;

  static const layout = 'preview';
}

@MappableClass()
class TwoColumnSlideOptions extends SlideOptions
    with TwoColumnSlideOptionsMappable {
  late Map<String, String> _sections;

  TwoColumnSlideOptions({
    super.title,
    super.background,
    super.contentAlignment,
    super.content,
    super.style,
  }) {
    _sections = parseContentSections(content);
  }

  @override
  String get layoutId => layout;

  static const layout = 'two_column';

  String get leftContent =>
      _sections[SectionTag.left] ?? _sections[SectionTag.first] ?? '';

  String get rightContent => _sections[SectionTag.right] ?? '';

  static const fromMap = TwoColumnSlideOptionsMapper.fromMap;
  static const fromJson = TwoColumnSlideOptionsMapper.fromJson;
}

@MappableClass()
class TwoColumnHeaderSlideOptions extends SlideOptions
    with TwoColumnHeaderSlideOptionsMappable {
  late Map<String, String> _sections;
  TwoColumnHeaderSlideOptions({
    super.title,
    super.background,
    super.contentAlignment,
    super.content = '',
    super.style,
  }) {
    _sections = parseContentSections(content);
  }

  @override
  String get layoutId => layout;

  static const layout = 'two_column_header';

  String get topContent => _sections[SectionTag.first] ?? '';

  String get leftContent => _sections[SectionTag.left] ?? '';

  String get rightContent => _sections[SectionTag.right] ?? '';

  static const fromMap = TwoColumnHeaderSlideOptionsMapper.fromMap;
  static const fromJson = TwoColumnHeaderSlideOptionsMapper.fromJson;
}
