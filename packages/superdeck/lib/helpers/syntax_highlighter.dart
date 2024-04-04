import 'package:flutter/material.dart';
import 'package:flutter_prism/flutter_prism.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class SyntaxHighlight {
  SyntaxHighlight._();

  static List<String> get supportedLanguages => ['dart', 'yaml', 'json'];

  static late HighlighterTheme _theme;

  static initialize() async {
    await Highlighter.initialize(supportedLanguages);

    _theme = await HighlighterTheme.loadForBrightness(Brightness.dark);
  }

  static List<TextSpan> render(String source, String language) {
    if (supportedLanguages.contains(language)) {
      return [Highlighter(language: language, theme: _theme).highlight(source)];
    } else {
      final prism = Prism(style: const PrismStyle.dark());
      return prism.render(source, language);
    }
  }
}

List<int> parseLineNumbers(String input) {
  // Regular expression to find the content within the curly braces
  final regExp = RegExp(r'\{(.*?)\}');
  final match = regExp.firstMatch(input);

  // If there's no match, return an empty list
  if (match == null) return [];

  // Extract the content within the curly braces
  var content = match.group(1) ?? '';

  // Initialize an empty set to hold the line numbers (avoids duplicates)
  var lineNumbers = <int>{};

  // Split the content by comma to separate the elements
  var elements = content.split(',');

  // Iterate over each element to process single numbers and ranges
  for (var element in elements) {
    element = element.trim(); // Trim whitespace
    if (element.isEmpty) {
      continue; // Skip empty elements (e.g., when there are spaces after commas
    }

    if (element.contains('-')) {
      // It's a range, split into start and end
      var rangeParts = element.split('-');
      var start = int.parse(rangeParts[0].trim());
      var end = int.parse(rangeParts[1].trim());

      // Add all numbers in the range to the set
      for (var i = start; i <= end; i++) {
        lineNumbers.add(i);
      }
    } else {
      // It's a single number, add it to the set
      lineNumbers.add(int.parse(element));
    }
  }

  // Convert the set to a list, sort it, and return
  var lineNumberList = lineNumbers.toList();
  lineNumberList.sort();
  return lineNumberList;
}
