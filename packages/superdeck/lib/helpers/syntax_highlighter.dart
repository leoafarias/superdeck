import 'package:flutter/material.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class DDSyntaxHighlight {
  DDSyntaxHighlight._();

  static late Highlighter _highlighter;

  static initialize() async {
    await Highlighter.initialize([
      'dart',
      'yaml',
    ]);
    var theme = await HighlighterTheme.loadForBrightness(Brightness.dark);
    _highlighter = Highlighter(
      language: 'dart',
      theme: theme,
    );
  }

  static TextSpan highlight(String source) {
    return _highlighter.highlight(source);
  }
}
