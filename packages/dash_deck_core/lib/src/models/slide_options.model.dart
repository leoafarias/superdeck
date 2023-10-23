import 'package:dart_mappable/dart_mappable.dart';

part 'slide_options.model.mapper.dart';

@MappableEnum()
enum SlideLayout { none, cover, contentLeft, contentRight }

@MappableEnum()
enum ImageFit { cover, contain, fill, fitHeight, fitWidth, none, scaleDown }

@MappableEnum()
enum VerticalAlignment { top, center, bottom }

@MappableEnum()
enum ContentAlignment {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight
}

@MappableEnum()
enum HorizontalAlignment { left, center, right }

@MappableClass()
class SlideOptions with SlideOptionsMappable {
  final bool scrollable;
  final SlideLayout layout;
  final String? background;
  final ImageFit backgroundFit;
  final ContentAlignment contentAlignment;
  final String? styles;

  const SlideOptions({
    this.scrollable = false,
    this.layout = SlideLayout.none,
    this.background,
    this.backgroundFit = ImageFit.cover,
    this.contentAlignment = ContentAlignment.center,
    this.styles,
  });

  static final fromMap = SlideOptionsMapper.fromMap;
  static final fromJson = SlideOptionsMapper.fromJson;

  static List<String> get availableOptions => [
        'scrollable',
        'layout',
        'background',
        'backgroundFit',
        'contentAlignment',
        'styles',
      ];
}
