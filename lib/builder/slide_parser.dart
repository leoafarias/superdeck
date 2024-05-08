import '../helpers/config.dart';
import '../helpers/deep_merge.dart';
import '../helpers/utils.dart';
import '../models/slide_model.dart';

class SlideParser {
  final SDConfig config;

  SlideParser({required this.config});

  final _frontMatterRegex = RegExp(r'---([\s\S]*?)---');

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
      slides.add(buffer.toString());
    }

    return slides;
  }

  List<Slide> run(String contents) {
    final slidesRaw = _splitSlides(contents.trim());

    final slides = <Slide>[];

    for (final slideRaw in slidesRaw) {
      slides.add(_runEach(slideRaw));
    }

    return slides;
  }

  Slide _runEach(String slideRaw) {
    final frontMatter = _frontMatterRegex.firstMatch(slideRaw)?.group(1) ?? '';

    final options = converYamlToMap(frontMatter);

    final content = slideRaw
        .substring(_frontMatterRegex.matchAsPrefix(slideRaw)?.end ?? 0)
        .trim();

    final mergedOptions = deepMerge(
      config.toSlideMap(),
      {...options, 'raw': slideRaw, 'data': content},
    );

    return Slide.parse(mergedOptions);
  }
}
