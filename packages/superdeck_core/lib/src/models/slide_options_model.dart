import 'package:dart_mappable/dart_mappable.dart';

part 'slide_options_model.mapper.dart';

class BuiltinLayout {
  BuiltinLayout._();
  static const basic = 'basic';
  static const image = 'image';
  static const twoColumn = 'twoColumn';
  static const twoColumnHeader = 'twoColumnHeader';
}

@MappableEnum()
enum ImageFit { cover, contain, fill, fitHeight, fitWidth, none, scaleDown }

@MappableEnum()
enum ImagePosition { left, right }

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
enum VerticalAlignment { top, center, bottom }

@MappableEnum()
enum HorizontalAlignment { left, center, right }
