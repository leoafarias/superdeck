// lib/slide_parser.dart

import 'dart:convert';

import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/helpers/short_hash_id.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:yaml/yaml.dart';

List<Slide> parseSlides(String markdown) {
  try {
    final regex = RegExp(
      r'---\s*([\s\S]*?)\s*---\s*([\s\S]*?)(?=(---|$))',
      multiLine: true,
    );
    final matches = regex.allMatches(markdown);

    print('Number of matches: ${matches.length}');
    final slides = <Slide>[];

    for (final match in matches) {
      print(match.group(0));
      final yamlString = match.group(1);
      final markdownContent = match.group(2);
      final key = shortHashId(match.group(0)!);
      final yamlMap = loadYaml(yamlString!) as YamlMap?;

      // Whole content of the match

      slides.add(
        Slide.fromMap({
          'options': jsonDecode(jsonEncode(yamlMap)),
          'markdown': markdownContent,
          'key': key,
        }),
      );
    }

    return slides;
  } on FormatException catch (e) {
    throw SDFormatException(e.message, markdown, e.offset);
  } on SchemaValidationException catch (e) {
    throw SDMarkdownParsingException(e, 0);
  }
}
