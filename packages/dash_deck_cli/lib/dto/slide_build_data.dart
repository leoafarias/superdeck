import 'package:dash_deck_cli/dto/code_snippet.dto.dart';
import 'package:dash_deck_core/models/slide.model.dart';
import 'package:dash_deck_core/models/slide_options.model.dart';

class SlideBuildData {
  const SlideBuildData(this.data);

  final Slide data;

  String get id => data.id;
  SlideOptions get options => data.options;
  String? get content => data.content;

  List<CodeSnippet> get snippets {
    final codeSnippets = <CodeSnippet>[];
    for (var i = 0, len = data.snippets.length; i < len; i++) {
      final source = data.snippets[i];

      codeSnippets.add(CodeSnippet(
        name: data.id,
        index: i,
        source: source,
      ));
    }

    return codeSnippets;
  }
}
