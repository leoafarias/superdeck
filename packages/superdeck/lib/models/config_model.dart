import 'package:dart_mappable/dart_mappable.dart';

import 'slide_options_model.dart';
import 'syntax_tag.dart';

part 'config_model.mapper.dart';

@MappableClass()
abstract class SlideConfig with SlideConfigMappable {
  final String? title;
  final String? background;
  final ContentAlignment contentAlignment;
  final String content;
  final String? variant;

  const SlideConfig({
    required this.title,
    this.background,
    this.content = '',
    this.variant,
    this.contentAlignment = ContentAlignment.centerLeft,
  });

  String get templateId;

  static const fromMap = SlideConfigMapper.fromMap;
  static const fromJson = SlideConfigMapper.fromJson;
}

@MappableClass()
class BaseSlideConfig extends SlideConfig with BaseSlideConfigMappable {
  const BaseSlideConfig({
    super.title,
    super.background,
    super.contentAlignment,
    super.content,
    super.variant,
  });

  @override
  String get templateId => template;

  static const template = 'base';

  static const fromMap = BaseSlideConfigMapper.fromMap;
  static const fromJson = BaseSlideConfigMapper.fromJson;
}

@MappableClass()
class ImageSlideConfig extends SlideConfig with ImageSlideConfigMappable {
  final ImageConfig image;

  const ImageSlideConfig({
    super.title,
    required this.image,
    super.variant,
    super.background,
    super.content,
  });

  static const fromMap = ImageSlideConfigMapper.fromMap;
  static const fromJson = ImageSlideConfigMapper.fromJson;

  @override
  String get templateId => template;

  static const template = 'image';
}

@MappableClass()
class TwoColumnSlideConfig extends SlideConfig
    with TwoColumnSlideConfigMappable {
  late Map<String, String> _tags;

  TwoColumnSlideConfig({
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

  static const fromMap = TwoColumnSlideConfigMapper.fromMap;
  static const fromJson = TwoColumnSlideConfigMapper.fromJson;
}

@MappableClass()
class TwoColumnHeaderSlideConfig extends SlideConfig
    with TwoColumnHeaderSlideConfigMappable {
  late Map<String, String> _tags;
  TwoColumnHeaderSlideConfig({
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

  static const fromMap = TwoColumnHeaderSlideConfigMapper.fromMap;
  static const fromJson = TwoColumnHeaderSlideConfigMapper.fromJson;
}

String _getTagContent(
  Map<String, String> tags,
  String tag, [
  String fallback = '',
]) {
  final tagContent = tags[tag];
  return tagContent ?? fallback;
}
