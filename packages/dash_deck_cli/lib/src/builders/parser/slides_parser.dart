import 'package:dash_deck/dash_deck.dart';
import 'package:dash_deck_cli/src/builders/parser/code_block_parser.dart';
import 'package:dash_deck_cli/src/builders/parser/slide_content_parser.dart';
import 'package:dash_deck_cli/src/builders/parser/slide_data_parser.dart';
import 'package:dash_deck_cli/src/builders/parser/slide_options_parser.dart';

class SlidesParser {
  SlidesParser(this.text);
  final String text;

  List<SlideData> parse() {
    final slidesContents = SlideDataParser(text).parse();

    return slidesContents.map((content) {
      final slideOptions = SlideOptionsParser(content).parse();

      final slideContent = SlideContentParser(content).parse();

      final slideCodeBlocks = CodeBlockParser(slideContent).parse();

      return SlideData(
        id: 'slide_${slideCodeBlocks.length + 1}',
        options: slideOptions,
        content: slideContent,
        codeBlocks: slideCodeBlocks,
      );
    }).toList();
  }
}
