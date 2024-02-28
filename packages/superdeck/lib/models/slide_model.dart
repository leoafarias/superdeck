import 'package:dart_mappable/dart_mappable.dart';

import 'slide_options_model.dart';
import 'syntax_tag.dart';

part 'slide_model.mapper.dart';

typedef JSON = Map<String, dynamic>;

@MappableClass()
abstract class SlideConfig with SlideConfigMappable {
  final String? title;
  final String? background;
  final ContentAlignment contentAlignment;
  final String content;

  const SlideConfig({
    required this.title,
    this.background,
    this.content = '',
    this.contentAlignment = ContentAlignment.centerLeft,
  });
  String get templateId;

  static const fromMap = SlideConfigMapper.fromMap;
  static const fromJson = SlideConfigMapper.fromJson;
}

@MappableClass()
class SimpleSlideConfig extends SlideConfig with SimpleSlideConfigMappable {
  const SimpleSlideConfig({
    super.title,
    super.background,
    super.contentAlignment,
    super.content,
  });

  @override
  String get templateId => 'simple';

  static const fromMap = SimpleSlideConfigMapper.fromMap;
  static const fromJson = SimpleSlideConfigMapper.fromJson;
}

@MappableClass()
class ImageSlideConfig extends SlideConfig with ImageSlideConfigMappable {
  final ImageFit imageFit;
  final String image;
  final ImagePosition imagePosition;

  const ImageSlideConfig({
    super.title,
    this.imageFit = ImageFit.cover,
    this.image = '',
    this.imagePosition = ImagePosition.left,
    super.background,
    super.content,
  });

  static const fromMap = ImageSlideConfigMapper.fromMap;
  static const fromJson = ImageSlideConfigMapper.fromJson;

  @override
  String get templateId => 'image';
}

@MappableClass()
class TwoColumnSlideConfig extends SlideConfig
    with TwoColumnSlideConfigMappable {
  late Map<String, List<String>> _tags;

  TwoColumnSlideConfig({
    super.title,
    super.background,
    super.contentAlignment,
    super.content,
  }) {
    _tags = parseContentWithTags(content, [SyntaxTag.left, SyntaxTag.right]);
  }

  @override
  String get templateId => 'two-column';

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
  late Map<String, List<String>> _tags;
  TwoColumnHeaderSlideConfig({
    super.title,
    super.background,
    super.contentAlignment,
    super.content = '',
  }) {
    _tags = parseContentWithTags(content, [SyntaxTag.left, SyntaxTag.right]);
  }

  @override
  String get templateId => 'two-column-header';

  String get topContent {
    return _getTagContent(_tags, SyntaxTag.right);
  }

  String get leftContent {
    return _getTagContent(_tags, SyntaxTag.left);
  }

  String get rightContent {
    return _getTagContent(_tags, SyntaxTag.right);
  }

  static const fromMap = TwoColumnHeaderSlideConfigMapper.fromMap;
  static const fromJson = TwoColumnHeaderSlideConfigMapper.fromJson;
}

String _getTagContent(
  Map<String, List<String>> tags,
  SyntaxTag tag, [
  String fallback = '',
]) {
  return tags[tag] != null ? tags[tag.name]!.join('\n') : fallback;
}
