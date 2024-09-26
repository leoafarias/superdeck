import 'dart:convert';
import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/src/models/asset_model.dart';
import 'package:superdeck_core/src/models/config_model.dart';
import 'package:superdeck_core/src/models/slide_model.dart';
import 'package:yaml/yaml.dart' as yaml;

part 'reference_model.mapper.dart';

@MappableClass()
class ReferenceDto with ReferenceDtoMappable {
  final Config config;
  final List<Slide> slides;
  final List<SlideAsset> assets;

  ReferenceDto({
    required this.config,
    required this.slides,
    required this.assets,
  });

  static ReferenceDto loadFile(File file) {
    try {
      return fromJson(file.readAsStringSync());
    } catch (e) {
      return ReferenceDto(assets: [], slides: [], config: Config.empty());
    }
  }

  static ReferenceDto loadYaml(File file) {
    try {
      final yamlString = yaml.loadYaml(file.readAsStringSync());
      return ReferenceDto.fromJson(jsonEncode(yamlString));
    } catch (e) {
      return ReferenceDto(assets: [], slides: [], config: Config.empty());
    }
  }

  const ReferenceDto.empty()
      : config = const Config.empty(),
        slides = const [],
        assets = const [];

  static const fromMap = ReferenceDtoMapper.fromMap;
  static const fromJson = ReferenceDtoMapper.fromJson;
}
