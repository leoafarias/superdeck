// lib/slide_parser.dart

import 'package:superdeck_cli/src/helpers/short_hash_id.dart';
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

    final slideRaws = markdownContents.map(parseSlideMarkdown).toList();

    return slideRaws.map((raw) {
      return Slide(
        content: raw.content,
        key: shortHashId(raw.toString()),
        options: SlideOptions.fromMap(raw.options),
      );
    }).toList();
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
