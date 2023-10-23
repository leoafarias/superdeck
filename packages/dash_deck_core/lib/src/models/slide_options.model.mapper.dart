// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_options.model.dart';

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

class ImagePositionMapper extends EnumMapper<ImagePosition> {
  ImagePositionMapper._();

  static ImagePositionMapper? _instance;
  static ImagePositionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImagePositionMapper._());
    }
    return _instance!;
  }

  static ImagePosition fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ImagePosition decode(dynamic value) {
    switch (value) {
      case 'left':
        return ImagePosition.left;
      case 'right':
        return ImagePosition.right;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ImagePosition self) {
    switch (self) {
      case ImagePosition.left:
        return 'left';
      case ImagePosition.right:
        return 'right';
    }
  }
}

extension ImagePositionMapperExtension on ImagePosition {
  String toValue() {
    ImagePositionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ImagePosition>(this) as String;
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
