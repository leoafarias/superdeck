import 'dart:convert';

import 'package:yaml/yaml.dart';

Map<String, dynamic> convertYamlToMap(String yamlString) {
  final yamlMap = loadYaml(yamlString) as YamlMap?;

  return jsonDecode(jsonEncode(yamlMap));
}
