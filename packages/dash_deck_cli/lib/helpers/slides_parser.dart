import 'package:dash_deck_cli/dto/slide_build_data.dart';
import 'package:dash_deck_core/models/slide.model.dart';
import 'package:dash_deck_core/models/slide_options.model.dart';
import 'package:yaml/yaml.dart';

const delimiter = '---';
const delimeterLineBreak = '\n$delimiter';

/// Extracts and parses YAML front matter from a [String].
///
/// Returns a [SlideData] comprising the parsed YAML front matter
/// `data` [YamlMap], and the remaining `content` [String].
///
/// Throws a [FrontMatterException] if front matter contains invalid YAML.
List<SlideBuildData> slideMarkdownParser(String text) {
  // Remove any leading whitespace.
  final value = text.trimLeft();

  // If there's no starting delimiter, there's no front matter.
  if (!value.startsWith(delimiter)) {
    // throw const FrontMatterException(frontMatterRequired);
    return [];
  }
  return findNextFrontMatterSlide(value, firstRun: true);
}

List<SlideBuildData> findNextFrontMatterSlide(
  String value, {
  List<SlideBuildData>? slides,
  bool firstRun = false,
}) {
  slides ??= <SlideBuildData>[];
  // Get the index of the closing delimiter.
  String currentDelimiter;

  if (firstRun) {
    currentDelimiter = delimiter;
  } else {
    currentDelimiter = delimeterLineBreak;
  }

  final closeIndex = value.indexOf(delimeterLineBreak, currentDelimiter.length);

  // Get the raw front matter block between the opening and closing delimiters.
  final frontMatter = value.substring(currentDelimiter.length, closeIndex);

  // Parse the front matter as YAML.
  final slideOptions = loadYaml(frontMatter) as YamlMap?;
  // The content begins after the closing delimiter index.
  final slideContent =
      value.substring(closeIndex + (currentDelimiter.length + 1));

  final nextIndex = slideContent.indexOf(delimeterLineBreak);

  final lastSlide = nextIndex == -1;

  String getCurrentContent() {
    if (lastSlide) {
      return slideContent;
    } else {
      return slideContent.substring(0, nextIndex);
    }
  }

  String getNextContent() {
    return slideContent.substring(
      nextIndex,
    );
  }

  final slide = Slide(
      // +1 because slide has not been added to list yet
      id: 'slide_${slides.length + 1}',
      options: SlideOptions.fromYamlMap(slideOptions),
      content: getCurrentContent(),
      snippets: snippetParser(getCurrentContent()));

  slides.add(SlideBuildData(slide));

  if (lastSlide) {
    return slides;
  }

  return findNextFrontMatterSlide(
    getNextContent(),
    slides: slides,
  );
}

List<String> snippetParser(String text, [List<String>? snippets]) {
  const delimiter = '```dart';
  const delimeterEnd = '```';

  const importDelimiter = '//@import:';

  const lineBreakDelimiter = '\n';

  snippets ??= <String>[];
  final value = text.trimLeft();

  final startIndex = value.indexOf(delimiter);

  if (startIndex == -1) {
    return snippets;
  }

  final closeIndex = value.indexOf(delimeterEnd, startIndex + delimiter.length);

  if (closeIndex == -1) {
    return snippets;
  }

  final snippet =
      value.substring(startIndex + delimiter.length, closeIndex).trimLeft();
  print(snippet);
  // if (snippet.startsWith(importDelimiter)) {
  //   final importPath = snippet.substring(
  //       importDelimiter.length, snippet.indexOf(lineBreakDelimiter));
  //   final imports = importPath.split('/');
  //   final importJoin = imports.reduce((value, element) => join(value, element));
  //   final codeContent =
  //       File(join(kShowtimeDirectory.projectLibPath, importJoin))
  //           .readAsStringSync();
  //   snippets.add(codeContent);
  // } else {
  //   snippets.add(snippet);
  // }
  snippets.add(snippet);

  return snippetParser(
    value.substring(closeIndex + delimeterEnd.length),
    snippets,
  );
}
