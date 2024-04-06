import 'package:flutter/material.dart';
import 'package:re_highlight/languages/all.dart';
import 'package:re_highlight/re_highlight.dart' as re;
import 'package:re_highlight/styles/all.dart';

final reHighlight = re.Highlight();

class SyntaxHighlight {
  SyntaxHighlight._();

  static initialize() async {
    reHighlight.registerLanguages(builtinAllLanguages);
  }

  static List<TextSpan> render(String source, String? language) {
    re.HighlightResult result;

    if (language == null) {
      result = reHighlight.highlightAuto(source);
    } else {
      result = reHighlight.highlight(code: source, language: language);
    }

    final renderer =
        re.TextSpanRenderer(null, builtinAllThemes['tokyo-night-dark']!);
    result.render(renderer);
    final span = renderer.span ?? const TextSpan();

    return [span];
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

final markdownGrammar = {
  'fileTypes': [
    'md',
    'markdown',
  ],
  "name": "Markdown",
  'scopeName': 'source.markdown',
  'patterns': [
    {
      'include': '#heading',
    },
    {
      'include': '#italic',
    },
    {
      'include': '#bold',
    },
    {
      'include': '#link',
    },
    {
      'include': '#image',
    },
    {
      'match': '^\\s*[-+*]\\s+(.+)\$',
      'captures': {
        '0': {'name': 'markup.list.unnumbered.markdown'},
      },
    },
    {
      'match': '^\\s*\\d+\\.\\s+(.+)\$',
      'captures': {
        '0': {'name': 'markup.list.numbered.markdown'},
      },
    },
    {
      'match': '`([^`]+)`',
      'captures': {
        '0': {'name': 'markup.raw.inline.markdown'},
      },
    },
    {
      'begin': '```',
      'end': '```',
      'name': 'markup.raw.block.markdown',
    },
    {
      'match': '^\\s*>\\s*(.+)\$',
      'captures': {
        '0': {'name': 'markup.quote.markdown'},
      },
    },
    {
      'match': '^[-*_]{3,}\$',
      'name': 'punctuation.definition.thematic-break.markdown',
    },
    {
      'match': '^\\|?(.+\\|.+)\\|?\$',
      'captures': {
        '0': {'name': 'markup.other.table.markdown'},
      },
    },
    {
      'match': '~~([^~]+)~~',
      'captures': {
        '0': {'name': 'markup.strikethrough.markdown'},
      },
    },
    {
      'match': '^\\s*[-+*]\\s+\\[[xX\\s]\\]\\s+(.+)\$',
      'captures': {
        '0': {'name': 'markup.list.unnumbered.todo.markdown'},
      },
    },
    {
      'match': '<([^>]+)>',
      'name': 'markup.raw.inline.html.markdown',
    },
  ],
  'repository': {
    'heading': {
      'match': '^(#{1,6})\\s+(.*?)\$',
      'captures': {
        '1': {'name': 'punctuation.definition.heading.markdown'},
        '2': {'name': 'entity.name.section.markdown'},
      },
    },
    'italic': {
      'match': '\\*([^*]+)\\*',
      'captures': {
        '0': {'name': 'markup.italic.markdown'},
      },
    },
    'bold': {
      'match': '\\*\\*([^*]+)\\*\\*',
      'captures': {
        '0': {'name': 'markup.bold.markdown'},
      },
    },
    'link': {
      'match': '\\[([^\\]]+)\\]\\(([^\\)]+)\\)',
      'captures': {
        '0': {'name': 'markup.underline.link.markdown'},
      },
    },
    'image': {
      'match': '!\\[([^\\]]+)\\]\\(([^\\)]+)\\)',
      'captures': {
        '0': {'name': 'markup.underline.link.image.markdown'},
      },
    },
  },
  'foldingStartMarker': '^\\s*<!--\\s*#?region\\b.*-->',
  'foldingStopMarker': '^\\s*<!--\\s*#?endregion\\b.*-->',
};
