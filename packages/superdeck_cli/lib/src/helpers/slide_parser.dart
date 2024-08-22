// lib/slide_parser.dart

import 'package:collection/collection.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/helpers/yaml_to_map.dart';
import 'package:superdeck_core/superdeck_core.dart';

class SlideParser {
  final String contents;
  SlideParser(this.contents);

  List<String> _splitSlides(String content) {
    final lines = content.split('\n');
    final slides = <String>[];
    final buffer = StringBuffer();
    bool inSlide = false;

    var isCodeBlock = false;

    for (var line in lines) {
      if (line.trim().startsWith('```')) {
        isCodeBlock = !isCodeBlock;
      }
      if (line.trim() == '---' && !isCodeBlock) {
        if (buffer.isNotEmpty) {
          if (inSlide) {
            slides.add(buffer.toString().trim());
            inSlide = false;
            buffer.clear();
          } else {
            inSlide = true;
          }
        }
        buffer.writeln(line);
      } else {
        buffer.writeln(line);
      }
    }

    if (buffer.isNotEmpty) {
      slides.add(buffer.toString());
    }

    return slides;
  }

  List<Slide> run() {
    final markdownContents = _splitSlides(contents.trim());

    final slideRaws = markdownContents.map(parseSlideMarkdown).map((e) {
      return {
        'content': e.content,
        'options': e.options,
        'key': e.key,
      };
    });

    slideRaws.forEachIndexed((index, raw) {
      try {
        Slide.schema.validateOrThrow(raw);
      } on SchemaValidationException catch (e) {
        final keyPath = e.result.key.join(' | ');
        final errorMessages = e.result.errors.map((e) => e.message).join(', ');
        logger
          ..newLine()
          ..alert(
            'Slide schema validation failed',
          )
          ..newLine()
          ..info(
            'slide ${index + 1}: > $keyPath > $errorMessages',
          )
          ..newLine();

        throw Exception('Slide schema validation failed');
      }
    });

    return slideRaws.map(Slide.fromMap).toList();
  }
}

Map<String, dynamic> deepMerge(
    Map<String, dynamic> source, Map<String, dynamic> updates) {
  final result = Map<String, dynamic>.from(source);

  updates.forEach((key, value) {
    if (value is Map<String, dynamic> && result[key] is Map<String, dynamic>) {
      result[key] = deepMerge(result[key] as Map<String, dynamic>, value);
    } else {
      result[key] = value;
    }
  });

  return result;
}
