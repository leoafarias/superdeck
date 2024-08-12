import 'dart:convert';
import 'dart:io';

import 'package:superdeck_cli/src/helpers/short_hash_id.dart';
import 'package:superdeck_cli/src/helpers/yaml_to_map.dart';

typedef Json = Map<String, dynamic>;

class RawReference {
  final List<RawAsset> assets;
  final List<RawSlide> slides;
  final Json config;

  const RawReference({
    required this.assets,
    required this.slides,
    required this.config,
  });

  static RawReference loadFile(File file) {
    try {
      return fromJson(file.readAsStringSync());
    } catch (e) {
      return const RawReference(assets: [], slides: [], config: {});
    }
  }

  static RawReference fromMap(Json map) {
    return RawReference(
      assets: (map['assets'] as List<dynamic>)
          .map((e) => RawAsset.fromMap(e))
          .toList(),
      slides: (map['slides'] as List<dynamic>)
          .map((e) => RawSlide(e as Json))
          .toList(),
      config: map['config'] as Json,
    );
  }

  static RawReference fromJson(String json) {
    return fromMap(jsonDecode(json) as Json);
  }
}

class RawConfig {
  final Json _map;

  const RawConfig(this._map);

  static RawConfig loadFile(File file) {
    try {
      final yamlString = file.readAsStringSync();
      return RawConfig(converYamlToMap(yamlString));
    } catch (e) {
      return const RawConfig({});
    }
  }

  Json toMap() => _map;
}

class RawSlide {
  final String key;
  final Json _map;

  RawSlide(this._map) : key = shortHashId(_map.toString());

  String get content => (_map['content'] ?? '') as String;

  static RawSlide fromYaml(String yamlString) {
    final (:content, :options) = parseSlideMarkdown(yamlString);
    return RawSlide({
      ...options,

      // Change from content on the frontMatter to content options in on the map
      if (options['content'] != null) 'content_options': options['content'],
      'content': content,
    });
  }

  RawSlide copyWith({
    String? content,
  }) {
    return RawSlide(
      {
        ..._map,
        'content': content ?? _map['content'],
      },
    );
  }

  Json toMap() => {
        ..._map,
        'key': key,
      };

  static RawSlide fromJson(String json) {
    return RawSlide(jsonDecode(json));
  }
}

class RawAsset {
  final String path;
  final String? reference;
  final int width;
  final int height;

  const RawAsset({
    required this.path,
    required this.width,
    required this.height,
    required this.reference,
  });

  static RawAsset fromMap(Json json) {
    return RawAsset(
      path: json['path'] as String,
      reference: json['reference'] as String?,
      width: json['width'] as int,
      height: json['height'] as int,
    );
  }

  static RawAsset fromJson(String json) {
    return fromMap(jsonDecode(json) as Json);
  }

  Json toMap() => {
        'path': path,
        'width': width,
        'height': height,
        if (reference != null) 'reference': reference,
      };
}
