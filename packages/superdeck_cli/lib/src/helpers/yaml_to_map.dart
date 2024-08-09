import 'dart:convert';

import 'package:superdeck_cli/src/helpers/raw_models.dart';
import 'package:yaml/yaml.dart';

final _frontMatterRegex = RegExp(r'---([\s\S]*?)---');

Json converYamlToMap(String yamlString) {
  final yamlMap = loadYaml(yamlString) as YamlMap? ?? YamlMap();

  final yaml = jsonEncode(yamlMap);

  return jsonDecode(yaml);
}

({String content, Json options}) parseSlideMarkdown(String slideContents) {
  final frontMatter =
      _frontMatterRegex.firstMatch(slideContents)?.group(1) ?? '';
  final options = converYamlToMap(frontMatter);

  final content = slideContents
      .substring(_frontMatterRegex.matchAsPrefix(slideContents)?.end ?? 0)
      .trim();

  return (
    content: content,
    options: options,
  );
}
