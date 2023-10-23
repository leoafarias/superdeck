import 'package:dash_deck_core/dash_deck_core.dart';

class SlidesParser {
  // Constructor that accepts the text input for parsing.
  SlidesParser(this.text);
  final String text;

  // Public method that parses the text and returns a list of SlideData.
  List<SlideData> parse() {
    // Parse slides from the input text.
    final slidesContents = parseSlides(text);

    // Map the parsed slides to SlideData objects and return as a list.
    return slidesContents.asMap().entries.map((entry) {
      final slide = entry.value;

      // Convert front matter to SlideOptions.
      final slideOptions = SlideOptions.fromMap(slide.frontMatter);

      // Return a SlideData object for each slide.
      return SlideData(
        options: slideOptions,
        content: slide.content.trim(),
      );
    }).toList();
  }
}

// Private class to represent parsed slide data.
class _SlideParserData {
  final Map<String, String> frontMatter;
  final String content;

  _SlideParserData(this.frontMatter, this.content);

  @override
  String toString() => 'FrontMatter: $frontMatter, Content: $content';
}

// Function to parse slides from the content string.
List<_SlideParserData> parseSlides(String content) {
  final slides = <_SlideParserData>[];
  final lines = content.split('\n');

  // Flags and temporary variables to keep track of parsing state.
  var inFrontMatter = false;
  var frontMatter = <String, String>{};

  var slideContent = <String>[];

  // Iterate through each line, parsing front matter and content.
  for (final line in lines) {
    if (line == '---') {
      // Toggle front matter parsing state.
      if (inFrontMatter) {
        inFrontMatter = false;
      } else {
        // If exiting a slide, add the parsed slide and reset temporary variables.
        if (slideContent.isNotEmpty || frontMatter.isNotEmpty) {
          slides.add(_SlideParserData(frontMatter, slideContent.join('\n')));
          frontMatter = {};
          slideContent = [];
        }
        inFrontMatter = true;
      }
    } else if (inFrontMatter) {
      // Inside front matter: parse key-value pairs.
      final index = line.indexOf(':');
      if (index != -1) {
        final key = line.substring(0, index).trim();
        final value = line.substring(index + 1).trim();
        frontMatter[key] = value;
      }
    } else {
      // Outside front matter: accumulate slide content.
      slideContent.add(line);
    }
  }

  // Handle the last slide, if any content or front matter remains.
  if (slideContent.isNotEmpty || frontMatter.isNotEmpty) {
    slides.add(_SlideParserData(frontMatter, slideContent.join('\n')));
  }

  return slides;
}
