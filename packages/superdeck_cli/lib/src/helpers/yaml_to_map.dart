import 'dart:convert';

import 'package:yaml/yaml.dart';

Map<String, dynamic> converYamlToMap(String yamlString) {
  final yamlMap = loadYaml(yamlString) as YamlMap? ?? YamlMap();

  final yaml = jsonEncode(yamlMap);

  return jsonDecode(yaml);
}
