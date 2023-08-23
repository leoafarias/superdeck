import 'package:dash_deck_core/dash_deck_core.dart';

class CodeBlockParser {
  CodeBlockParser(this.text);
  final String text;
  static const langDelimiter = '```dart';
  static const langDelimiterEnd = '```';

  List<CodeBlock> parse() {
    return parseCodeBlocks(text);
  }

  List<CodeBlock> parseCodeBlocks(String markdown) {
    List<CodeBlock> codeBlocks = [];
    bool inCodeSnippet = false;
    List<String> lines = markdown.split('\n');
    StringBuffer snippetBuffer = StringBuffer();
    String? options;

    for (var line in lines) {
      if (inCodeSnippet) {
        if (line == '```') {
          // Code snippet ends
          inCodeSnippet = false;
          List<int> highlightedLines =
              options != null ? parseHighlightingOptions(options) : [];
          if (options != null) {
            snippetBuffer.writeln('@ddsyntax\n$options\n@endddsyntax');
          }
          codeBlocks.add(
            CodeBlock(
                source: snippetBuffer.toString(),
                highlightLines: highlightedLines),
          );
          snippetBuffer.clear();
          options = null;
        } else {
          // Add line to the code snippet buffer
          snippetBuffer.writeln(line);
        }
      } else {
        if (line.startsWith('```')) {
          // Code snippet starts
          inCodeSnippet = true;
          var match = RegExp(r'\{(.+)\}').firstMatch(line);
          if (match != null) {
            options = match.group(1);
          }
        }
      }
    }

    return codeBlocks;
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
}
