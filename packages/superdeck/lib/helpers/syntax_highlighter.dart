import 'package:flutter/material.dart';
import 'package:flutter_highlighting/themes/github.dart';
import 'package:highlighting/highlighting.dart';
import 'package:highlighting/languages/dart.dart';
import 'package:highlighting/languages/javascript.dart';
import 'package:highlighting/languages/json.dart';
import 'package:highlighting/languages/python.dart';
import 'package:highlighting/languages/typescript.dart';
import 'package:highlighting/languages/yaml.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class SyntaxHighlight {
  SyntaxHighlight._();

  static late HighlighterTheme _theme;

  static initialize() async {
    await Highlighter.initialize([
      'dart',
      'yaml',
    ]);

    _theme = await HighlighterTheme.loadForBrightness(Brightness.dark);

    highlight.registerLanguage(dart);
    highlight.registerLanguage(json);
    highlight.registerLanguage(yaml);
    highlight.registerLanguage(python);
    // typescript
    // javascript
    highlight.registerLanguage(typescript);
    highlight.registerLanguage(javascript);
  }

  static TextSpan render(String source, String language) {
    if (language == 'dart') {
      return Highlighter(language: language, theme: _theme).highlight(source);
    } else {
      final value = highlight.parse(source, languageId: language).nodes ?? [];
      return TextSpan(children: _convert(value));
    }
  }
}

const _theme = githubTheme;

List<TextSpan> _convert(List<Node> nodes) {
  List<TextSpan> spans = [];
  var currentSpans = spans;
  List<List<TextSpan>> stack = [];

  traverse(Node node) {
    if (node.value != null) {
      currentSpans.add(node.className == null
          ? TextSpan(text: node.value)
          : TextSpan(text: node.value, style: _theme[node.className]));
    } else {
      List<TextSpan> tmp = [];
      currentSpans.add(TextSpan(children: tmp, style: _theme[node.className]));
      stack.add(currentSpans);
      currentSpans = tmp;

      for (var n in node.children) {
        traverse(n);
        if (n == node.children.last) {
          currentSpans = stack.isEmpty ? spans : stack.removeLast();
        }
      }
    }
  }

  for (var node in nodes) {
    traverse(node);
  }

  return spans;
}
