import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';

import '../models/options_model.dart';
import '../schema/schema.dart';
import '../schema/schema_values.dart';
import 'utils.dart';

part 'config.mapper.dart';

@MappableClass()
abstract class Config with ConfigMappable {
  final String? background;
  final String? style;
  final TransitionOptions? transition;

  const Config({
    required this.background,
    required this.style,
    required this.transition,
  });

  static final schema = Schema(
    {
      "background": Schema.string.isOptional(),
      "style": Schema.string.isOptional(),
      "transition": TransitionOptions.schema.isOptional(),
    },
    additionalProperties: false,
  );
}

@MappableClass()
class SDConfig extends Config with SDConfigMappable {
  final bool? cacheRemoteAssets;

  const SDConfig({
    required super.background,
    required super.style,
    required super.transition,
    this.cacheRemoteAssets,
  });

  const SDConfig.empty()
      : this(
          cacheRemoteAssets: null,
          background: null,
          style: null,
          transition: null,
        );

  static const fromMap = SDConfigMapper.fromMap;
  static const fromJson = SDConfigMapper.fromJson;
  static SDConfig fromYaml(String yaml) => fromMap(converYamlToMap(yaml));

  static Future<SDConfig> load(File file) async {
    final contents = await file.readAsString();
    return fromYaml(contents);
  }

  Map<String, dynamic> toSlideMap() {
    final config = toMap();
    config.remove('cache_remote_assets');
    return config;
  }

  static final schema = Config.schema.merge(
    {
      "cache_remote_assets": Schema.boolean.isOptional(),
      "markdown_file": Schema.string.isRequired().isPosixPath(),
      "assets_dir": Schema.string.isRequired().isPosixPath(),
    },
  );
}
