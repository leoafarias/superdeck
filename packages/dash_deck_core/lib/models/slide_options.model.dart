import 'dart:convert';

import 'package:dash_deck_core/helpers/mappers.dart';
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

class SlideOptions {
  const SlideOptions({
    this.devicePreview = false,
    this.scrollable = false,
    this.layout = SlideLayout.none,
    this.image,
    this.imageFit = ImageFit.cover,
    this.contentAlignment = ContentAlignment.center,
    this.mix,
    this.codePreview = false,
  });

  final bool devicePreview;
  final bool scrollable;
  final SlideLayout layout;
  final String? image;
  final ImageFit imageFit;
  final ContentAlignment contentAlignment;
  final String? mix;
  final bool codePreview;

  static const availableOptions = [
    'devicePreview',
    'scrollable',
    'layout',
    'image',
    'imageFit',
    'contentAlignment',
    'mix',
    'codePreview',
  ];

  static void validate(Map<String, dynamic> map) {
    final keys = map.keys.toList();
    for (final key in keys) {
      if (!availableOptions.contains(key)) {
        throw Exception(
          '''Invalid option: $key \n
            Available Options: ${availableOptions.join(', ')}''',
        );
      }
    }
  }

  factory SlideOptions.fromYamlMap(YamlMap? yamlMap) {
    if (yamlMap == null) {
      return const SlideOptions();
    }
    return SlideOptions.fromMap(yamlMap.value.cast<String, dynamic>());
  }

  factory SlideOptions.fromMap(Map<String, dynamic> map) {
    validate(map);

    return SlideOptions(
      devicePreview: map['devicePreview'] ?? false,
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
      mix: map['mix'],
      codePreview: map['codePreview'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SlideOptions.fromJson(String source) {
    return SlideOptions.fromMap(json.decode(source));
  }

  Map<String, dynamic> toMap() {
    return {
      'devicePreview': devicePreview,
      'scrollable': scrollable,
      'layout': layout.name,
      'image': image,
      'imageFit': imageFit.name,
      'contentAlignment': contentAlignment.name,
      'mix': mix,
      'codePreview': codePreview,
    };
  }
}
