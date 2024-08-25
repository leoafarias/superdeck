import 'package:superdeck_cli/src/parsers/section_parser/section_regex.dart';
import 'package:test/test.dart';

void main() {
  group('Tag parsing tests', () {
    test('Parse tag with both parts', () {
      final input = '{@column blue: car}';
      final expectedOutput = 'column blue: car';
      expect(getTagContents(input), equals(expectedOutput));
    });

    test('Parse tag with only first part', () {
      final input = '{@column:demo}';
      final expectedOutput = 'column:demo';
      expect(getTagContents(input), equals(expectedOutput));
    });

    test('Parse tag with extra whitespace', () {
      final input = '{@column   red  :   bike }';
      final expectedOutput = 'column   red  :   bike';
      expect(getTagContents(input), equals(expectedOutput));
    });

    test('Parse tag with underscore in part names', () {
      final input = '{@column my_color: my_vehicle}';
      final expectedOutput = 'column my_color: my_vehicle';
      expect(getTagContents(input), equals(expectedOutput));
    });

    test('Parse tag with numbers in part names', () {
      final input = '{@column color123: vehicle456 blabla: 10}';
      final expectedOutput = 'column color123: vehicle456 blabla: 10';
      expect(getTagContents(input), equals(expectedOutput));
    });

    test('Return null for input without tag', () {
      final input = 'This is a regular text without a tag.';
      expect(getTagContents(input), isNull);
    });

    test('Return null for input with incomplete tag', () {
      final input = '{@column';
      expect(getTagContents(input), isNull);
    });

    test('Return null for input with incorrect tag format', () {
      final input = '{@column: blue car}';
      final expected = 'column: blue car';
      expect(getTagContents(input), equals(expected));
    });
  });
}
