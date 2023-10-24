import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_deck_core/src/models/slide_options.model.dart';
import 'package:dash_deck_core/src/syntax/tags.dart';

part 'slide_model.mapper.dart';

typedef JSON = Map<String, dynamic>;

Slide _slideBuilder(JSON data) {
  final layout = data['layout'] as String? ?? BuiltinLayout.none;
  switch (layout) {
    case BuiltinLayout.none:
      return Slide.fromMap(data);
    case BuiltinLayout.cover:
      return CoverSlide.fromMap(data);
    case BuiltinLayout.image:
      return ImageSlide.fromMap(data);
    case BuiltinLayout.full:
      return FullSlide.fromMap(data);
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
  final String layout;
  final String content;
  final ContentAlignment contentAlignment;
  const Slide({
    this.layout = BuiltinLayout.none,
    this.contentAlignment = ContentAlignment.center,
    this.content = '',
  });

  factory Slide.parse(JSON data) {
    return _slideBuilder(data);
  }

  factory Slide.parseJson(String data) {
    return _slideBuilder(jsonDecode(data));
  }

  static final fromMap = SlideMapper.fromMap;

  static final fromJson = SlideMapper.fromJson;
}

@MappableClass()
class CoverSlide extends Slide with CoverSlideMappable {
  final String? background;

  const CoverSlide({
    this.background,
    super.contentAlignment,
    super.content,
    super.layout,
  });

  static final fromMap = CoverSlideMapper.fromMap;
  static final fromJson = CoverSlideMapper.fromJson;
}

@MappableClass()
class ImageSlide extends Slide with ImageSlideMappable {
  final ImageFit? imageFit;
  final String image;
  final ImagePosition imagePosition;

  const ImageSlide({
    this.imageFit,
    this.image = '',
    this.imagePosition = ImagePosition.left,
    super.content,
    super.layout,
  });

  static final fromMap = ImageSlideMapper.fromMap;
  static final fromJson = ImageSlideMapper.fromJson;
}

@MappableClass()
class FullSlide extends Slide with FullSlideMappable {
  const FullSlide({
    super.content,
    super.layout,
  });

  static final fromMap = FullSlideMapper.fromMap;
  static final fromJson = FullSlideMapper.fromJson;
}

@MappableClass()
class TwoColumnSlide extends Slide with TwoColumnSlideMappable {
  late Map<String, List<String>> _tags;
  TwoColumnSlide({
    super.content,
    super.layout,
  }) {
    _tags = parseContentWithTags(content, [SyntaxTags.left, SyntaxTags.right]);
  }

  String get leftContent {
    final remainingContent = _tags[SyntaxTags.content] != null
        ? _tags[SyntaxTags.content]!.join('\n')
        : '';

    return _tags[SyntaxTags.left] != null
        ? _tags[SyntaxTags.left]!.join('\n')
        : remainingContent;
  }

  String get rightContent {
    return _tags[SyntaxTags.right] != null
        ? _tags[SyntaxTags.right]!.join('\n')
        : '';
  }

  static final fromMap = TwoColumnSlideMapper.fromMap;
  static final fromJson = TwoColumnSlideMapper.fromJson;
}

@MappableClass()
class TwoColumnHeaderSlide extends Slide with TwoColumnHeaderSlideMappable {
  late Map<String, List<String>> _tags;
  TwoColumnHeaderSlide({
    super.content,
    super.layout,
  }) {
    _tags = parseContentWithTags(content, [SyntaxTags.left, SyntaxTags.right]);
  }

  String get topContent {
    return _tags[SyntaxTags.content] != null
        ? _tags[SyntaxTags.content]!.join('\n')
        : '';
  }

  String get leftContent {
    return _tags[SyntaxTags.left] != null
        ? _tags[SyntaxTags.left]!.join('\n')
        : '';
  }

  String get rightContent {
    return _tags[SyntaxTags.right] != null
        ? _tags[SyntaxTags.right]!.join('\n')
        : '';
  }

  static final fromMap = TwoColumnHeaderSlideMapper.fromMap;
  static final fromJson = TwoColumnHeaderSlideMapper.fromJson;
}
