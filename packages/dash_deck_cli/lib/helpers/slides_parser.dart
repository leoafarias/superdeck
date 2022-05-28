import 'dart:io';

import 'package:dash_deck_cli/dto/slide_build_data.dart';
import 'package:dash_deck_core/constants.dart';
import 'package:dash_deck_core/models/slide.model.dart';
import 'package:dash_deck_core/models/slide_options.model.dart';
import 'package:path/path.dart';
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

List<int> getFocusValueFromDelimiter(String value) {
  // Get the index that starts with "//@focus:"
  // Get the line numbers that should focus after comma separated
  // 1,2,3 will return a a list of [1,2,3]
  // 1,2:5 will return a list of [1,2,3,4,5]
  // 1:5 will return a list of [1,2,3,4,5]
  // 1 will return a list of [1]
  const delimiter = '//@focus:';
  const lineBreak = '\n';

  final text = value.trimLeft();
  final hasFocus = text.startsWith(delimiter);
  if (!hasFocus) {
    return [];
  }

  final focusValue = text.substring(delimiter.length, text.indexOf(lineBreak));
  final focusValues = focusValue.split(',');
  final focusList = focusValues
      .map((text) {
        if (text.contains(':')) {
          final split = text.split(':');
          return List<int>.generate(
            int.parse(split[1]) - int.parse(split[0]) + 1,
            (index) => int.parse(split[0]) + index,
          );
        } else {
          return [int.parse(text)];
        }
      })
      .expand((text) => text)
      .toList();

  return focusList;
}

String? getFileContentFromImportTag(String value) {
  const importDelimiter = '//@import:';

  const lineBreakDelimiter = '\n';

  final importIndex = value.indexOf(importDelimiter);
  if (importIndex == -1) {
    return null;
  }

  final importValue = value.substring(
      importIndex + importDelimiter.length, value.indexOf(lineBreakDelimiter));
  final imports = importValue.split('/');
  final importJoin = imports.reduce((value, element) => join(value, element));
  final codeContent = File(join(kDashDeckDirectory.projectLibPath, importJoin))
      .readAsStringSync();

  return codeContent;
}

List<String> snippetParser(String text, [List<String>? snippets]) {
  const langDelimiter = '```dart';
  const langDelimiterEnd = '```';

  snippets ??= <String>[];
  final value = text.trimLeft();

  final startIndex = value.indexOf(langDelimiter);

  if (startIndex == -1) {
    return snippets;
  }

  final closeIndex =
      value.indexOf(langDelimiterEnd, startIndex + langDelimiter.length);

  if (closeIndex == -1) {
    return snippets;
  }

  final snippet =
      value.substring(startIndex + langDelimiter.length, closeIndex).trimLeft();

  snippets.add(snippet);

  return snippetParser(
    value.substring(closeIndex + langDelimiterEnd.length),
    snippets,
  );
}
