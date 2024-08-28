import 'dart:convert';

import 'package:yaml/yaml.dart';

typedef MarkdownExtraction = ({
  String contents,
  Map<String, dynamic> frontMatter,
});

// Extracts the YAML frontmatter from a markdown string
MarkdownExtraction extractYamlFrontmatter(String markdown) {
  final regex = RegExp(r'^---\n([\s\S]*?)\n---', multiLine: true);
  final match = regex.firstMatch(markdown);

  if (match != null) {
    final yamlString = match.group(1);
    final markdownContent = match.group(2);

    final yamlMap = loadYaml(yamlString!) as YamlMap?;

    return (
      contents: markdownContent!,
      frontMatter: jsonDecode(jsonEncode(yamlMap)),
    );
  }

  // If no match is found, return the original markdown string
  return (contents: markdown, frontMatter: {});
}

String serializeYamlFrontmatter(Map<String, dynamic> data) {
  final yamlString = jsonEncode(data);
  return '---\n$yamlString---\n';
}
