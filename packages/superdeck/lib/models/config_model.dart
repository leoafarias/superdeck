import 'package:dart_mappable/dart_mappable.dart';

import 'slide_options_model.dart';
import 'syntax_tag.dart';

part 'config_model.mapper.dart';

@MappableClass()
abstract class SlideOptions with SlideOptionsMappable {
  final String? title;
  final String? background;
  final ContentAlignment contentAlignment;
  final String content;
  final String? variant;

  const SlideOptions({
    required this.title,
    this.background,
    this.content = '',
    required this.variant,
    this.contentAlignment = ContentAlignment.centerLeft,
  });

  String get templateId;

  static const fromMap = SlideOptionsMapper.fromMap;
  static const fromJson = SlideOptionsMapper.fromJson;
}

@MappableClass()
class BaseSlideOptions extends SlideOptions with BaseSlideOptionsMappable {
  const BaseSlideOptions({
    super.title,
    super.background,
    super.contentAlignment,
    super.content,
    super.variant,
  });

  @override
  String get templateId => template;

  static const template = 'base';

  static const fromMap = BaseSlideOptionsMapper.fromMap;
  static const fromJson = BaseSlideOptionsMapper.fromJson;
}

@MappableClass()
class ImageSlideOptions extends SlideOptions with ImageSlideOptionsMappable {
  final ImageOptions image;

  const ImageSlideOptions({
    super.title,
    required this.image,
    super.variant,
    super.background,
    super.content,
    super.contentAlignment,
  });

  static const fromMap = ImageSlideOptionsMapper.fromMap;
  static const fromJson = ImageSlideOptionsMapper.fromJson;

  @override
  String get templateId => template;

  static const template = 'image';
}

@MappableClass()
class TwoColumnSlideOptions extends SlideOptions
    with TwoColumnSlideOptionsMappable {
  late Map<String, String> _tags;

  TwoColumnSlideOptions({
    super.title,
    super.background,
    super.contentAlignment,
    super.content,
    super.variant,
  }) {
    _tags = parseContentWithTags(content, [SyntaxTag.left, SyntaxTag.right]);
  }

  @override
  String get templateId => template;

  static const template = 'two_column';

  String get leftContent {
    return _getTagContent(
        _tags,
        SyntaxTag.left,
        _getTagContent(
          _tags,
          SyntaxTag.content,
        ));
  }

  String get rightContent {
    return _getTagContent(_tags, SyntaxTag.right);
  }

  static const fromMap = TwoColumnSlideOptionsMapper.fromMap;
  static const fromJson = TwoColumnSlideOptionsMapper.fromJson;
}

@MappableClass()
class TwoColumnHeaderSlideOptions extends SlideOptions
    with TwoColumnHeaderSlideOptionsMappable {
  late Map<String, String> _tags;
  TwoColumnHeaderSlideOptions({
    super.title,
    super.background,
    super.contentAlignment,
    super.content = '',
    super.variant,
  }) {
    _tags = parseContentWithTags(content, [SyntaxTag.left, SyntaxTag.right]);
  }

  @override
  String get templateId => template;

  static const template = 'two_column_header';

  String get topContent => _getTagContent(_tags, SyntaxTag.content);

  String get leftContent => _getTagContent(_tags, SyntaxTag.left);

  String get rightContent => _getTagContent(_tags, SyntaxTag.right);

  static const fromMap = TwoColumnHeaderSlideOptionsMapper.fromMap;
  static const fromJson = TwoColumnHeaderSlideOptionsMapper.fromJson;
}

String _getTagContent(
  Map<String, String> tags,
  String tag, [
  String fallback = '',
]) {
  final tagContent = tags[tag];
  return tagContent ?? fallback;
}
