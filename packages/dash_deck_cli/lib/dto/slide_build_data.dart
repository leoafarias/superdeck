import 'package:dash_deck_cli/helpers/slides_parser.dart';
import 'package:dash_deck_core/dash_deck_core.dart';

class SlideBuildData {
  const SlideBuildData(this.data);

  final Slide data;

  String get id => data.id;
  SlideOptions get options => data.options;
  String? get content => data.content;

  List<Snippet> get snippets {
    final codeSnippets = <Snippet>[];
    for (var i = 0, len = data.snippets.length; i < len; i++) {
      final source = data.snippets[i];

      codeSnippets.add(Snippet(
        source: source,
        focusLines: keywordLineParser(source, 'focus'),
        showLines: keywordLineParser(source, 'only'),
      ));
    }

    return codeSnippets;
  }
}
