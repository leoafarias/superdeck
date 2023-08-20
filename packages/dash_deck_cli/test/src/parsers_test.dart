import 'dart:io';

import 'package:dash_deck_cli/src/builders/parser/slide_data_parser.dart';
import 'package:dash_deck_cli/src/builders/parser/slide_options_parser.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

final markdown =
    File(p.join('test', 'fixtures', 'slides.md')).readAsStringSync();

void main() {
  group('Parsers:', () {
    test('SlideDataParser', () {
      final slides = SlideDataParser(markdown).parse();
      expect(slides.length, 5);
    });

    test('FrontMatterParser', () {
      const content = '''
---
codePreview: true
layout: contentLeft
verticalAlignment: center
---
''';
      final frontMatter = FrontMatterParser(content).parse();
      // Validate
      expect(frontMatter['codePreview'], equals(true));
      expect(frontMatter['layout'], equals('contentLeft'));
      expect(frontMatter['verticalAlignment'], equals('center'));
    });
  });
}
