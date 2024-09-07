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
  final regex = RegExp(
    r'^---.*\r?\n([\s\S]*?)---',
    multiLine: true,
  );
  final match = regex.firstMatch(markdown);
  if (match == null) {
    // get everything after the second `---`
    final contents = markdown.split('---').last;
    return (
      contents: contents.trim(),
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
