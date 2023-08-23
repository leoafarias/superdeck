import 'package:dash_deck/helpers/scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighting/themes/dracula.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlighting/highlighting.dart';

Map<String, TextStyle?> get syntaxTheme {
  return {
    ...draculaTheme,
    'number': draculaTheme['variable'],
    'class': draculaTheme['variable'],
    'built_in': draculaTheme['variable'],
  };
}

TextStyle applyStyle(String? className) {
  final classStyle = className == null ? null : syntaxTheme[className];

  final baseStyle = TextStyle(
    fontSize: Scale.scaleFont(16),
    height: 1.6,
    color: Colors.white,
  );

  if (className != null && classStyle == null) {
    throw Exception('No classname found on theme: $className');
  }

  if (classStyle == null) {
    return baseStyle;
  }

  return baseStyle.merge(classStyle);
}

class DartSyntaxBuilder extends SyntaxHighlighter {
  @override
  TextSpan format(String source) {
    final parsedSyntax = parseSyntax(source);
    return TextSpan(
      children: _convert(
        highlight
            .parse(
              parsedSyntax.updatedContent,
              languageId: 'dart',
            )
            .nodes!,
      ),
    );
  }
}

List<TextSpan> _convert(List<Node> nodes) {
  List<TextSpan> spans = [];
  var currentSpans = spans;
  List<List<TextSpan>> stack = [];

  const delimiter = '\n';

  traverse(Node node) {
    TextStyle? getTextStyle() {
      final className = node.className;

      final textStyle = applyStyle(className);

      // if (lineNumber != 3 && lineNumber != 4) {
      //   return textStyle.copyWith(color: textStyle.color!.withOpacity(0.4));
      // }
      return textStyle;
    }

    if (node.value != null) {
      final hasNewLine = delimiter.allMatches(node.value!).isNotEmpty;

      // NEW LINE CONDITIONAL
      if (hasNewLine) {
        currentSpans.add(TextSpan(
          text: node.value!.substring(0, node.value!.indexOf(delimiter)),
          style: getTextStyle(),
        ));

        currentSpans.add(TextSpan(
          text: delimiter,
          style: getTextStyle(),
        ));

        // Jump a line number now

        currentSpans.add(
          TextSpan(
            text: node.value!.substring(node.value!.indexOf('\n') + 1),
            style: getTextStyle(),
          ),
        );
      } else {
        currentSpans.add(TextSpan(text: node.value));
      }
    } else {
      List<TextSpan> tmp = [];
      currentSpans.add(TextSpan(children: tmp, style: getTextStyle()));
      stack.add(currentSpans);
      currentSpans = tmp;
    }

    for (var n in node.children) {
      traverse(n);
      if (n == node.children.last) {
        currentSpans = stack.isEmpty ? spans : stack.removeLast();
      }
    }
  }

  for (var node in nodes) {
    traverse(node);
  }

  return spans;
}

class ParsedSyntax {
  final String updatedContent;
  final List<int> highlightedLines;

  ParsedSyntax(this.updatedContent, this.highlightedLines);
}

ParsedSyntax parseSyntax(String content) {
  final startIndex = content.indexOf('@ddsyntax');
  final endIndex = content.indexOf('@endddsyntax');

  if (startIndex == -1 || endIndex == -1 || startIndex >= endIndex) {
    return ParsedSyntax(
      content,
      [],
    ); // Return original content if tags are not found correctly
  }

  final highlightedLines =
      content.substring(startIndex + '@ddsyntax'.length, endIndex).trim();
  final updatedContent =
      content.replaceRange(startIndex, endIndex + '@endddsyntax'.length, '');

  return ParsedSyntax(
      updatedContent, parseHighlightingOptions(highlightedLines));
}

List<int> parseHighlightingOptions(String options) {
  var result = <int>[];
  var parts = options.split(',');

  for (var part in parts) {
    if (part.contains(':')) {
      var range = part.split(':').map((e) => int.parse(e.trim())).toList();
      result.addAll(
          List<int>.generate(range[1] - range[0] + 1, (i) => i + range[0]));
    } else {
      result.add(int.parse(part.trim()));
    }
  }

  return result;
}
