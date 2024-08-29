import 'dart:convert';

import 'package:superdeck_cli/src/helpers/short_hash_id.dart';
import 'package:yaml/yaml.dart';

typedef MarkdownExtraction = ({
  String contents,
  Map<String, dynamic> frontMatter,
  String key,
});

// Extracts the YAML frontmatter from a markdown string
MarkdownExtraction extractYamlFrontmatter(String markdown) {
  final key = shortHashId(markdown);
  final regex = RegExp(r'^---\n([\s\S]*?)\n---', multiLine: true);
  final match = regex.firstMatch(markdown);
  if (match == null) {
    return (
      contents: markdown.trim(),
      frontMatter: {},
      key: key,
    );
  }

  final yamlString = match.group(1);
  final markdownContent = markdown.replaceFirst(match.group(0)!, '');

  final yamlMap = loadYaml(yamlString!) as YamlMap?;

  return (
    contents: markdownContent.trim(),
    frontMatter: yamlMap == null ? {} : jsonDecode(jsonEncode(yamlMap)),
    key: key,
  );
}

String serializeYamlFrontmatter(Map<String, dynamic> data) {
  final yamlString = jsonEncode(data);
  return '---\n$yamlString---\n';
}
