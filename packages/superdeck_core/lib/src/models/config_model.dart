import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'config_model.mapper.dart';

@MappableClass(
  hook: UnmappedPropertiesHook('args'),
)
class SlideOptions with SlideOptionsMappable {
  final String? title;
  final String? background;
  final String? style;
  final Map<String, Object?> args;

  const SlideOptions({
    this.title,
    this.background,
    this.style,
    this.args = const {},
  });

  static final fromMap = SlideOptionsMapper.fromMap;

  static final schema = SchemaShape(
    {
      "title": Schema.string,
      "background": Schema.string,
      "style": Schema.string,
    },
    additionalProperties: true,
  );
}

@MappableClass()
class Config extends SlideOptions with ConfigMappable {
  final bool? cacheRemoteAssets;

  const Config({
    required super.background,
    required super.style,
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
        );

  static const fromMap = ConfigMapper.fromMap;
  static const fromJson = ConfigMapper.fromJson;

  Map<String, dynamic> toSlideMap() {
    final config = toMap();
    config.remove('cache_remote_assets');
    return config;
  }

  static final schema = SlideOptions.schema.extend(
    {
      "cache_remote_assets": Schema.boolean.optional(),
      "markdown_file": Schema.string.required().isPosixPath(),
      "assets_dir": Schema.string.required().isPosixPath(),
    },
  );
}
