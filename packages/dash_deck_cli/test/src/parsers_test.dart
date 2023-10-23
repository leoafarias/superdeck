import 'dart:io';

import 'package:dash_deck_cli/src/builders/parser/slides_parser.dart';
import 'package:dash_deck_cli/src/builders/slide_data_builder.dart';
import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:path/path.dart' as p;
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
      await storeSlideData(DashDeckData(slides: slides));
      expect(slides.length, 5);
    });
  });
}
