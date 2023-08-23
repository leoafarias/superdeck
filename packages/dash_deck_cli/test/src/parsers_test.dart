import 'dart:io';

import 'package:dash_deck_cli/src/builders/parser/slides_parser.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

final markdown =
    File(p.join('test', 'fixtures', 'slides.md')).readAsStringSync();

void main() {
  group('Parsers:', () {
    test('SlideDataParser', () {
      final slides = SlidesParser(markdown).parse();
      expect(slides.length, 5);
    });
  });
}
