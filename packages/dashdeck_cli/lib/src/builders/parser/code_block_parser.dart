import 'dart:io';

import 'package:dashdeck_cli/src/constants.dart';
import 'package:dashdeck_core/dashdeck_core.dart';
import 'package:path/path.dart';

class CodeBlockParser {
  CodeBlockParser(this.text);
  final String text;
  static const langDelimiter = '```dart';
  static const langDelimiterEnd = '```';

  List<CodeBlock> parse() {
    return _codeBlockExtractor(text.trimLeft());
  }

  List<CodeBlock> _codeBlockExtractor(
    String value, [
    List<CodeBlock>? snippets,
  ]) {
    const lineBreak = '\n';
    snippets ??= <CodeBlock>[];

    final startIndex = value.indexOf(langDelimiter);

    if (startIndex == -1) {
      return snippets;
    }

    final closeIndex =
        value.indexOf(langDelimiterEnd, startIndex + langDelimiter.length);

    if (closeIndex == -1) {
      return snippets;
    }

    final langDirectives = value.substring(
      langDelimiterEnd.length,
      value.indexOf(lineBreak),
    );

    final source = value
        .substring(startIndex + langDelimiter.length, closeIndex)
        .trimLeft();

    snippets.add(
      CodeBlock(
        source: source,
        focusLines: langDirectiveFromLineParser(langDirectives, 'focus'),
        showLines: langDirectiveFromLineParser(langDirectives, 'show'),
      ),
    );

    return _codeBlockExtractor(
      value.substring(closeIndex + langDelimiterEnd.length),
      snippets,
    );
  }

  List<int> langDirectiveFromLineParser(String value, String keyword) {
    final values = value.split(' ');

    for (final directive in values) {
      final results = _langDirectiveParser(directive, keyword);
      if (results.isNotEmpty) {
        return results;
      }
    }

    return [];
  }

  List<int> _langDirectiveParser(String value, String keyword) {
    // Get the index that starts with "keyword"
    // Get the line numbers that should focus after comma separated
    // 1,2,3 will return a a list of [1,2,3]
    // 1,2:5 will return a list of [1,2,3,4,5]
    // 1:5 will return a list of [1,2,3,4,5]
    // 1 will return a list of [1]

    final content = _getCodeBlockDirectives(value, keyword);

    if (content == null) {
      return [];
    }

    final values = content.split(',');
    final valueList = values
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

    return valueList;
  }

  String? _getCodeBlockDirectives(
    String value,
    String keyword,
  ) {
    final delimiter = '$keyword=';

    final text = value.trimLeft();
    final hasKeyword = text.startsWith(delimiter);
    if (!hasKeyword) {
      return null;
    }

    return text.substring(delimiter.length);
  }

  String? _getFileContentFromImportTag(String value) {
    final importValue = _getLineKeywordContent(value, 'import');
    if (importValue == null) {
      return null;
    }
    final imports = importValue.split('/');
    final importJoin = imports.reduce(join);
    final codeContent = File(
      join(kDashDeckDirectory.appLibDir.path, importJoin),
    ).readAsStringSync();

    return codeContent;
  }

  String? _getLineKeywordContent(String value, String keyword) {
    final delimiter = '//@$keyword:';
    const lineBreak = '\n';

    final text = value.trimLeft();
    final hasKeyword = text.startsWith(delimiter);
    if (!hasKeyword) {
      return null;
    }

    return text.substring(delimiter.length, text.indexOf(lineBreak));
  }
}
