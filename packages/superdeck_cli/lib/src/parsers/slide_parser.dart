// lib/slide_parser.dart

import 'dart:convert';

import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/parsers/front_matter_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

List<String> _splitSlides(String content) {
  content = content.trim();
  final lines = LineSplitter().convert(content);
  final slides = <String>[];
  final buffer = StringBuffer();
  bool insideFrontMatter = false;

  var isCodeBlock = false;

  for (var line in lines) {
    final trimmed = line.trim();
    if (trimmed.startsWith('```')) {
      isCodeBlock = !isCodeBlock;
    }
    if (isCodeBlock) {
      buffer.writeln(line);
      continue;
    }

    if (insideFrontMatter && trimmed.isEmpty) {
      insideFrontMatter = false;
    }

    if (trimmed == '---') {
      if (!insideFrontMatter) {
        if (buffer.isNotEmpty) {
          slides.add(buffer.toString().trim());
          buffer.clear();
        }
      }
      insideFrontMatter = !insideFrontMatter;
    }
    buffer.writeln(line);
  }

  if (buffer.isNotEmpty) {
    slides.add(buffer.toString());
  }

  return slides;
}

List<Slide> parseSlides(String markdown) {
  try {
    final slidesRaws = _splitSlides(markdown);

    print('Slides ${slidesRaws.length}');
    final slides = <Slide>[];

    for (final match in slidesRaws) {
      final extracted = extractYamlFrontmatter(match);

      final regexComments = RegExp(r'<!--(.*?)-->', dotAll: true);

      final notes = <SlideNote>[];
      final comments = regexComments.allMatches(extracted.contents);

      for (final comment in comments) {
        final note = {
          'content': comment.group(1)?.trim(),
        };
        SlideNote.schema.validateOrThrow(note);
        notes.add(SlideNote.fromMap(note));
      }

      // Whole content of the match
      slides.add(
        Slide.fromMap({
          'options': extracted.frontMatter,
          'markdown': extracted.contents,
          'key': extracted.key
        }).copyWith(notes: notes),
      );
    }

    return slides;
  } on FormatException catch (e) {
    throw SdFormatException(e.message, markdown, e.offset);
  } on SchemaValidationException catch (e) {
    throw SdMarkdownParsingException(e, 0);
  }
}
