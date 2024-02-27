import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:superdeck_cli/src/builders/slides_parser.dart';
import 'package:superdeck_cli/src/builders/store_deck_data.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:test/test.dart';

final markdown =
    File(p.join('test', 'src', 'fixtures', 'slides.md')).readAsStringSync();

void main() {
  group('Parsers:', () {
    test('SlideDataParser', () {
      final slides = SlidesParser(markdown).parse();
      expect(slides.length, 5);
    });

    test('Mermaid', () async {
      final slides = SlidesParser(markdown).parse();
      await storeDeckData(DeckData(slides: slides));
      expect(slides.length, 5);
    });
  });
}
