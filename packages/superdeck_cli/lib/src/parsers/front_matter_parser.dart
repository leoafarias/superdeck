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
  final regex = RegExp(r'^---\n([\s\S]*?)\n---', multiLine: true);
  final match = regex.firstMatch(markdown);
  if (match == null) {
    throw Exception('Invalid frontmatter format');
  }
  final matched = match.group(0);
  final yamlString = match.group(1);
  final markdownContent = markdown.replaceFirst(matched!, '');

  final yamlMap = loadYaml(yamlString!) as YamlMap?;

  return (
    contents: markdownContent.trim(),
    frontMatter: jsonDecode(jsonEncode(yamlMap)),
    key: shortHashId(markdown),
  );

  // If no match is found, return the original markdown string
}

String serializeYamlFrontmatter(Map<String, dynamic> data) {
  final yamlString = jsonEncode(data);
  return '---\n$yamlString---\n';
}
