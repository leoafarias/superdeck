
import 'package:yaml/yaml.dart';

class SlidesParser {
  // Constructor that accepts the text input for parsing.
  SlidesParser(this.text);
  final String text;

  // Public method that parses the text and returns a list of SlideData.
  List<Map<String, dynamic>> parse() => _parseSlideContents(text);
}

final frontMatterParser = RegExp(r'---([\s\S]*?)---');
// Function to parse slides from the content string.
List<Map<String,dynamic>> _parseSlideContents(String content) {
  final slideContent = extractSlides(content);

  // Map the front matter and content to a list of _SlideParserData objects.
  return slideContent.map((slide) {
    final frontMatter =
        frontMatterParser.allMatches(slide).first.group(1) ?? '';

    // Parse the front matter into a map.
    final frontMatterMap = loadYaml(frontMatter) as YamlMap;

    // Remove all the matching front matter from the slide content.
    content = slide
        .substring(frontMatterParser.matchAsPrefix(slide)?.end ?? 0)
        .trim();

    final map = Map<String, dynamic>.from(frontMatterMap);

    map['content'] = content;
    // Return a _SlideParserData object for each slide.
    return map;
  }).toList();
}

List<String> extractSlides(String content) {
  final lines = content.split('\n');
  final slides = <String>[];
  final buffer = StringBuffer();
  bool inSlide = false;

  for (var line in lines) {
    if (line.trim() == '---') {
      if (buffer.isNotEmpty) {
        if (inSlide) {
          // Add the slide content to the list of slides
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

  // Capture any remaining content as a slide
  if (buffer.isNotEmpty) {
    slides.add(buffer.toString().trim());
  }

  return slides;
}
