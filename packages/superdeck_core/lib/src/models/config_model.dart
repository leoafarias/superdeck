import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../schema/schema_model.dart';
import '../schema/schema_values.dart';

part 'config_model.mapper.dart';

@MappableClass()
class SlideOptions with SlideOptionsMappable {
  final String? title;
  final String? background;
  final String? style;
  final TransitionOptions? transition;

  const SlideOptions({
    this.title,
    this.background,
    this.style,
    this.transition,
  });

  static final fromMap = SlideOptionsMapper.fromMap;

  static final schema = SchemaShape(
    {
      "title": Schema.string,
      "background": Schema.string,
      "style": Schema.string,
      "transition": TransitionOptions.schema.optional(),
    },
    additionalProperties: false,
  );
}

@MappableClass()
class Config extends SlideOptions with ConfigMappable {
  final bool? cacheRemoteAssets;

  const Config({
    required super.background,
    required super.style,
    required super.transition,
    this.cacheRemoteAssets,
  });

  static Config loadFile(File file) {
    try {
      final yamlString = file.readAsStringSync();
      return Config.fromMap(convertYamlToMap(yamlString));
    } catch (e) {
      return const Config.empty();
    }
  }

  const Config.empty()
      : this(
          cacheRemoteAssets: null,
          background: null,
          style: null,
          transition: null,
        );

  static const fromMap = ConfigMapper.fromMap;
  static const fromJson = ConfigMapper.fromJson;

  Map<String, dynamic> toSlideMap() {
    final config = toMap();
    config.remove('cache_remote_assets');
    return config;
  }

  static final schema = SlideOptions.schema.merge(
    {
      "cache_remote_assets": Schema.boolean.optional(),
      "markdown_file": Schema.string.required().isPosixPath(),
      "assets_dir": Schema.string.required().isPosixPath(),
    },
  );
}
