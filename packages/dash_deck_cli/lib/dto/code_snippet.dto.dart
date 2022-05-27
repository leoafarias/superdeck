import 'package:dash_deck_cli/helpers/recase.dart';

class CodeSnippet {
  final String name;
  final int index;
  final String source;

  const CodeSnippet({
    required this.name,
    required this.index,
    required this.source,
  });

  String get fileName {
    return '${name}_snippet_${index}_preview';
  }

  String get fileNameWithExt {
    return '$fileName.g.dart';
  }

  String get widgetName {
    return ReCase(fileName).pascalCase;
  }
}
