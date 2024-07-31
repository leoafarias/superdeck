import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';

import '../helpers/utils.dart';
import '../models/options_model.dart';
import '../schema/schema_model.dart';
import '../schema/schema_values.dart';

part 'config_model.mapper.dart';

@MappableClass()
abstract class BaseConfig with BaseConfigMappable {
  final String? background;
  final String? style;
  final TransitionOptions? transition;

  const BaseConfig({
    required this.background,
    required this.style,
    required this.transition,
  });

  static final schema = SchemaShape(
    {
      "background": Schema.string,
      "style": Schema.string,
      "transition": TransitionOptions.schema.optional(),
    },
    additionalProperties: false,
  );
}

@MappableClass()
class Config extends BaseConfig with ConfigMappable {
  final bool? cacheRemoteAssets;

  const Config({
    required super.background,
    required super.style,
    required super.transition,
    this.cacheRemoteAssets,
  });

  const Config.empty()
      : this(
          cacheRemoteAssets: null,
          background: null,
          style: null,
          transition: null,
        );

  static const fromMap = ConfigMapper.fromMap;
  static const fromJson = ConfigMapper.fromJson;
  static Config fromYaml(String yaml) => fromMap(converYamlToMap(yaml));

  static Future<Config> load(File file) async {
    final contents = await file.readAsString();
    return fromYaml(contents);
  }

  Map<String, dynamic> toSlideMap() {
    final config = toMap();
    config.remove('cache_remote_assets');
    return config;
  }

  static final schema = BaseConfig.schema.merge(
    {
      "cache_remote_assets": Schema.boolean.optional(),
      "markdown_file": Schema.string.required().isPosixPath(),
      "assets_dir": Schema.string.required().isPosixPath(),
    },
  );
}
