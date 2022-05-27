import 'package:dash_deck/helpers/scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/highlight.dart';

Map<String, TextStyle?> syntaxTheme() {
  final theme = {
    ...draculaTheme,
    'number': draculaTheme['variable'],
    'class': draculaTheme['variable'],
    'built_in': draculaTheme['variable'],
  };
  return theme;
}

TextStyle applyStyle(String? className) {
  final classStyle = className == null ? null : syntaxTheme()[className];

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
    return TextSpan(
      children: _convert(highlight
          .parse(_convertDisplaySnippet(source), language: 'dart')
          .nodes!),
    );
  }
}

String _convertDisplaySnippet(String source) {
  const delimiter = '//@gist:start';
  const endDelimiter = '//@gist:end';

  final startIndex = source.indexOf(delimiter);
  final endIndex = source.indexOf(endDelimiter);

  if (startIndex == -1 || endIndex == -1) {
    return source;
  }

  final snippet = source.substring(startIndex + delimiter.length, endIndex);
  return snippet;
}

List<TextSpan> _convert(List<Node> nodes) {
  List<TextSpan> spans = [];
  var currentSpans = spans;
  List<List<TextSpan>> stack = [];

  const delimiter = '\n';
  var lineNumber = 1;

  _traverse(Node node) {
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
        lineNumber++;

        currentSpans.add(
          TextSpan(
            text: node.value!.substring(node.value!.indexOf('\n') + 1),
            style: getTextStyle(),
          ),
        );
      } else {
        currentSpans.add(TextSpan(text: node.value));
      }
    } else if (node.children != null) {
      List<TextSpan> tmp = [];
      currentSpans.add(TextSpan(children: tmp, style: getTextStyle()));
      stack.add(currentSpans);
      currentSpans = tmp;

      node.children!.forEach((n) {
        _traverse(n);
        if (n == node.children!.last) {
          currentSpans = stack.isEmpty ? spans : stack.removeLast();
        }
      });
    }
  }

  for (var node in nodes) {
    _traverse(node);
  }

  return spans;
}
