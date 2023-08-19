import 'dart:convert';

import 'package:dashdeck_core/src/helpers/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:yaml/yaml.dart';

enum SlideLayout { none, cover, contentLeft, contentRight }

enum ImageFit { cover, contain, fill, fitHeight, fitWidth, none, scaleDown }

enum VerticalAlignment { top, center, bottom }

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

enum HorizontalAlignment { left, center, right }

class SlideOptions extends Equatable {
  const SlideOptions({
    this.scrollable = false,
    this.layout = SlideLayout.none,
    this.image,
    this.imageFit = ImageFit.cover,
    this.contentAlignment = ContentAlignment.center,
    this.styles,
  });

  final bool scrollable;
  final SlideLayout layout;
  final String? image;
  final ImageFit imageFit;
  final ContentAlignment contentAlignment;
  final String? styles;

  static const availableOptions = [
    'scrollable',
    'layout',
    'image',
    'imageFit',
    'contentAlignment',
    'styles',
  ];

  factory SlideOptions.fromYamlMap(YamlMap? yamlMap) {
    if (yamlMap == null) {
      return const SlideOptions();
    }
    return SlideOptions.fromMap(yamlMap.value.cast<String, dynamic>());
  }

  factory SlideOptions.fromMap(Map<String, dynamic> map) {
    return SlideOptions(
      scrollable: map['scrollable'] ?? false,
      layout: enumFromString(
        SlideLayout.values,
        map['layout'],
      ),
      image: map['image'],
      imageFit: enumFromString(
        ImageFit.values,
        map['imageFit'],
      ),
      contentAlignment: enumFromString(
        ContentAlignment.values,
        map['contentAlignment'],
      ),
      styles: map['styles'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SlideOptions.fromJson(String source) {
    return SlideOptions.fromMap(json.decode(source));
  }

  Map<String, dynamic> toMap() {
    return {
      'scrollable': scrollable,
      'layout': layout.name,
      'image': image,
      'imageFit': imageFit.name,
      'contentAlignment': contentAlignment.name,
      'styles': styles,
    };
  }

  @override
  List<Object?> get props => [
        scrollable,
        layout,
        image,
        imageFit,
        contentAlignment,
        styles,
      ];
}
