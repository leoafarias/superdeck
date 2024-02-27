import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'slide_options_model.dart';
import '../syntax/tags.dart';

part 'slide_model.mapper.dart';

typedef JSON = Map<String, dynamic>;

Slide _slideBuilder(JSON data) {
  final layout = data['layout'] as String? ?? BuiltinLayout.basic;
  switch (layout) {
    case BuiltinLayout.basic:
      return Slide.fromMap(data);
    case BuiltinLayout.image:
      return ImageSlide.fromMap(data);
    case BuiltinLayout.twoColumn:
      return TwoColumnSlide.fromMap(data);
    case BuiltinLayout.twoColumnHeader:
      return TwoColumnHeaderSlide.fromMap(data);
    default:
      throw Exception('Unknown layout: $layout');
  }
}

@MappableClass()
class Slide with SlideMappable {
  final String id;
  final String layout;
  final String content;
  final ContentAlignment contentAlignment;
  final String? background;
  const Slide({
    required this.id,
    this.layout = BuiltinLayout.basic,
    this.contentAlignment = ContentAlignment.centerLeft,
    this.background,
    this.content = '',
  });

  factory Slide.parse(JSON data) => _slideBuilder(data);

  factory Slide.parseJson(String data) {
    return Slide.parse(jsonDecode(data));
  }

  static final fromMap = SlideMapper.fromMap;

  static final fromJson = SlideMapper.fromJson;
}

@MappableClass()
abstract class SlideTemplate extends Slide with SlideTemplateMappable {
  const SlideTemplate({
    require super.id,
    super.layout = BuiltinLayout.basic,
    super.contentAlignment = ContentAlignment.centerLeft,
    super.background,
    super.content = '',
  });
  

  @override
  Widget build(BuildContext context);
}

@MappableClass()
class ImageSlide extends SlideTemplate with ImageSlideMappable {
  final ImageFit? imageFit;
  final String image;
  final ImagePosition imagePosition;

  const ImageSlide({
    this.imageFit,
    this.image = '',
    this.imagePosition = ImagePosition.left,
    super.background,
    super.content,
    super.layout,
    required super.id,
  });

  static final fromMap = ImageSlideMapper.fromMap;
  static final fromJson = ImageSlideMapper.fromJson;

  @override
  Widget build(BuildContext context) {
   final imageUrl = slide.image;
    final imageFit = slide.imageFit;
    final boxFit = imageFit == null ? BoxFit.cover : imageFit.boxFit;

    Widget imageWidget = const SizedBox(
      height: 0,
      width: 0,
    );

    imageWidget = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: boxFit,
        ),
      ),
    );

    List<Widget> children = [
      Expanded(child: imageWidget),
      Expanded(child: SlideContent(slide.content)),
    ];

    if (slide.imagePosition == ImagePosition.right) {
      children = children.reversed.toList();
    }

    return Row(
      children: children
    );
  }
}

@MappableClass()
class TwoColumnSlide extends Slide with TwoColumnSlideMappable {
  late Map<String, List<String>> _tags;

  TwoColumnSlide({
    super.content,
    super.layout,
    required super.id,
  }) {
    _tags = parseContentWithTags(content, [SyntaxTags.left, SyntaxTags.right]);
  }

  String get leftContent {
    return _getTagContent(
        _tags,
        SyntaxTags.left,
        _getTagContent(
          _tags,
          SyntaxTags.content,
        ));
  }

  String get rightContent {
    return _getTagContent(_tags, SyntaxTags.right);
  }

  static final fromMap = TwoColumnSlideMapper.fromMap;
  static final fromJson = TwoColumnSlideMapper.fromJson;
}

@MappableClass()
class TwoColumnHeaderSlide extends Slide with TwoColumnHeaderSlideMappable {
  late Map<String, List<String>> _tags;
  TwoColumnHeaderSlide({
    super.layout,
    super.background,
    super.contentAlignment,
    super.content,
    required super.id,
  }) {
    _tags = parseContentWithTags(content, [SyntaxTags.left, SyntaxTags.right]);
  }

  String get topContent {
    return _getTagContent(_tags, SyntaxTags.right);
  }

  String get leftContent {
    return _getTagContent(_tags, SyntaxTags.left);
  }

  String get rightContent {
    return _getTagContent(_tags, SyntaxTags.right);
  }

  static final fromMap = TwoColumnHeaderSlideMapper.fromMap;
  static final fromJson = TwoColumnHeaderSlideMapper.fromJson;
}

String _getTagContent(
  Map<String, List<String>> tags,
  String tag, [
  String fallback = '',
]) {
  return tags[tag] != null ? tags[tag]!.join('\n') : fallback;
}
