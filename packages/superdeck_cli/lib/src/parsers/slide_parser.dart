// lib/slide_parser.dart

import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/parsers/front_matter_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

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

List<Slide> parseSlides(String markdown) {
  try {
    final slidesRaws = _splitSlides(markdown);

    print('Number of matches: ${slidesRaws.length}');
    final slides = <Slide>[];

    for (final match in slidesRaws) {
      final extracted = extractYamlFrontmatter(match);

      // Whole content of the match

      slides.add(
        Slide.fromMap({
          'options': extracted.frontMatter,
          'markdown': extracted.contents,
          'key': extracted.key
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
