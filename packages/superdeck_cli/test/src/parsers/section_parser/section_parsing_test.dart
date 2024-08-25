import 'package:superdeck_cli/src/parsers/section_parser/section_parsing.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:test/test.dart';

void main() {
  group('LayoutSection', () {
    group('Successful cases', () {
      test('Section with columns', () {
        const markdown = '''
{@section}
# Title

{@column}
content column 1.

{@column}
content column 2.

''';

        final sections = parseSections(markdown);
        expect(sections.length, equals(1));
        expect(sections[0].subSections.length, equals(3));

        expect(sections[0].subSections[0].content.trim(), '# Title');
        expect(sections[0].subSections[1].content.trim(), 'content column 1.');
        expect(sections[0].subSections[2].content.trim(), 'content column 2.');
      });

      test('Only columns without sections', () {
        const markdown = '''
{@column}
Content column 1.

{@column}
Content column 2.

''';

        final sections = parseSections(markdown);
        expect(sections.length, equals(1));
        expect(sections[0].subSections.length, equals(2));
        expect(sections[0].subSections[0].content.trim(), 'Content column 1.');
        expect(sections[0].subSections[1].content.trim(), 'Content column 2.');
      });

      test('Columns then sections', () {
        const markdown = '''
# Regular Markdown

This is some regular markdown content.

{@section}
## Header Title

{@column}
Content inside the header.
''';

        final sections = parseSections(markdown);
        expect(sections.length, equals(2));
        expect(sections[0].subSections.length, equals(1));
        expect(sections[1].subSections.length, equals(2));

        expect(sections[0].subSections[0].content.trim(),
            '# Regular Markdown\nThis is some regular markdown content.');
        expect(sections[1].subSections[0].content.trim(), '## Header Title');
        expect(sections[1].subSections[1].content.trim(),
            'Content inside the header.');
      });

      test('Header, body, and footer with columns', () {
        const markdown = '''
{@section}
# Header Title

{@column}
Header content column.

{@section}
{@column}
Body content column 1.

{@column}
Body content column 2.

{@section}
{@column}
Footer content column.

''';

        final sections = parseSections(markdown);

        expect(sections.length, equals(3));
        expect(sections[0].subSections.length, equals(2));
        expect(sections[1].subSections.length, equals(2));
        expect(sections[2].subSections.length, equals(1));
        expect(sections[0].subSections[0].content.trim(), '# Header Title');
        expect(sections[0].subSections[1].content.trim(),
            'Header content column.');
        expect(sections[1].subSections[0].content.trim(),
            'Body content column 1.');
        expect(sections[1].subSections[1].content.trim(),
            'Body content column 2.');
        expect(sections[2].subSections[0].content.trim(),
            'Footer content column.');
      });
    });
  });

  group('ColumnBlockDto - Attribute Testing', () {
    test('Header with columns and flex attribute', () {
      const markdown = '''
{@section}
{@column flex: 1 }
Header content column 1.

{@column flex: 2}
Header content column 2.

''';

      final sections = parseSections(markdown);

      expect(sections.length, equals(1));
      expect(sections[0].subSections.length, equals(2));

      expect(sections[0].subSections[0].content.trim(),
          'Header content column 1.');
      expect(sections[0].subSections[1].content.trim(),
          'Header content column 2.');

      expect(sections[0].subSections[0].columnOptiouns?.flex, equals(1));
      expect(sections[0].subSections[1].columnOptiouns?.flex, equals(2));
    });

    test('Section with columns and alignment attribute in snake case', () {
      const markdown = '''
{@section}
{@column align: center}
Body content column 1.

{@column align: bottom_right}
Body content column 2.

''';

      final sections = parseSections(markdown);

      expect(sections.length, equals(1));
      expect(sections[0].subSections.length, equals(2));

      expect(
          sections[0].subSections[0].content.trim(), 'Body content column 1.');
      expect(
          sections[0].subSections[1].content.trim(), 'Body content column 2.');

      expect(sections[0].subSections[0].columnOptiouns?.align,
          equals(ContentAlignment.center));
      expect(sections[0].subSections[1].columnOptiouns?.align,
          equals(ContentAlignment.bottomRight));
    });

    test('Section with columns, flex, and alignment attributes in snake case',
        () {
      const markdown = '''
{@section}
{@column flex: 3 align: top_left}
Footer content column 1.

{@column flex: 1 align: center_right}
Footer content column 2.

''';

      final sections = parseSections(markdown);

      expect(sections.length, equals(1));
      expect(sections[0].subSections.length, equals(2));

      expect(sections[0].subSections[0].content.trim(),
          'Footer content column 1.');
      expect(sections[0].subSections[1].content.trim(),
          'Footer content column 2.');

      expect(sections[0].subSections[0].columnOptiouns?.flex, equals(3));
      expect(sections[0].subSections[0].columnOptiouns?.align,
          equals(ContentAlignment.topLeft));

      expect(sections[0].subSections[1].columnOptiouns?.flex, equals(1));
      expect(sections[0].subSections[1].columnOptiouns?.align,
          equals(ContentAlignment.centerRight));
    });

    test('Sections with columns and attributes', () {
      const markdown = '''
{@section}
{@column flex: 1 align: center}
Header content.

{@section}
{@column flex: 2  align: center_left}
Body content column 1.

{@column flex: 1 align: center_right}
Body content column 2.

{@section}
{@column flex: 1 align: bottom_center}
Footer content.

''';

      final sections = parseSections(markdown);

      expect(sections.length, equals(3));
      expect(sections[0].subSections.length, equals(1));
      expect(sections[1].subSections.length, equals(2));
      expect(sections[2].subSections.length, equals(1));

      expect(sections[0].subSections[0].content.trim(), 'Header content.');
      expect(sections[0].subSections[0].columnOptiouns?.flex, equals(1));
      expect(sections[0].subSections[0].columnOptiouns?.align,
          equals(ContentAlignment.center));

      expect(
          sections[1].subSections[0].content.trim(), 'Body content column 1.');
      expect(sections[1].subSections[0].columnOptiouns?.flex, equals(2));
      expect(sections[1].subSections[0].columnOptiouns?.align,
          equals(ContentAlignment.centerLeft));

      expect(
          sections[1].subSections[1].content.trim(), 'Body content column 2.');
      expect(sections[1].subSections[1].columnOptiouns?.flex, equals(1));
      expect(sections[1].subSections[1].columnOptiouns?.align,
          equals(ContentAlignment.centerRight));

      expect(sections[2].subSections[0].content.trim(), 'Footer content.');
      expect(sections[2].subSections[0].columnOptiouns?.flex, equals(1));
      expect(sections[2].subSections[0].columnOptiouns?.align,
          equals(ContentAlignment.bottomCenter));
    });
  });

  group('ColumnBlockDto - Fail Cases', () {
    test('Fail case - Invalid flex attribute format', () {
      const markdown = '''
{@section}
{@column flex:invalid}
Header content.

''';

      expect(() => parseSections(markdown), throwsException);
    });

    test('Fail case - Invalid alignment attribute value', () {
      const markdown = '''
{@section}
{@column align:invalid_alignment}
Header content.

''';

      expect(() => parseSections(markdown), throwsException);
    });
  });

  // Group that checks if columns inherit options from the parent
  group('ColumnBlockDto - Inheritance', () {
    test('Columns inherit options from the parent', () {
      const markdown = '''
{@section align: center}
{@column}
Header content.

{@section align: top_left flex: 2}
{@column flex: 3}
Body content.

{@section align: bottom_right flex: 1}
{@column align: bottom_right}
Footer content.

''';

      final sections = parseSections(markdown);

      expect(sections.length, equals(3));
      expect(sections[0].subSections.length, equals(1));
      expect(sections[1].subSections.length, equals(1));
      expect(sections[2].subSections.length, equals(1));

      expect(sections[0].subSections[0].content.trim(), 'Header content.');
      expect(sections[0].options?.align, equals(ContentAlignment.center));

      expect(sections[1].subSections[0].content.trim(), 'Body content.');
      expect(sections[1].options?.align, equals(ContentAlignment.topLeft));
      expect(sections[1].subSections[0].columnOptiouns?.flex, equals(3));

      expect(sections[2].subSections[0].content.trim(), 'Footer content.');
      expect(sections[2].options?.align, equals(ContentAlignment.bottomRight));
      expect(sections[2].options?.flex, equals(1));
    });
  });

  group(
    'getTagContents',
    () {
      test('Empty string', () {
        final result = extractTagData('{@section}');
        expect(result.blockType, equals(BlockType.section));
        expect(result.options, isEmpty);
      });

      test('Single key-value pair', () {
        final result = extractTagData('{@section key1: value1}');
        expect(result.blockType, equals(BlockType.section));
        expect(result.options, equals({'key1': 'value1'}));
      });

      test('Multiple key-value pairs', () {
        final result = extractTagData('{@section key1: value1 key2: value2}');
        expect(result.options, equals({'key1': 'value1', 'key2': 'value2'}));
      });

      test('Extra spaces', () {
        final result =
            extractTagData('{@section  key1:  value1  key2:  value2}');
        expect(result.options, equals({'key1': 'value1', 'key2': 'value2'}));
      });

      test('Empty value', () {
        expect(() => extractTagData('{@section key1:}'), throwsException);
      });

      test('Missing value', () {
        expect(() => extractTagData('{@section key1}'), throwsException);
      });

      test('Invalid tag format', () {
        expect(() => extractTagData('{@section key1:'), throwsException);
      });

      test('Returns contents of the first tag when multiple tags are present',
          () {
        final result =
            extractTagData('{@column firstTag: true} {@block secondTag:false}');
        expect(result.blockType, equals(BlockType.column));
        expect(result.options, equals({'firstTag': 'true'}));
      });

      test('Mixed valid and invalid pairs', () {
        final result = extractTagData('{@column key1: value1 key2: value2}');
        expect(
          result.blockType,
          equals(BlockType.column),
        );

        expect(result.options, equals({'key1': 'value1', 'key2': 'value2'}));
      });

      // Test falsy value
      test('Falsy value', () {
        final result = extractTagData('{@column key1: false}');
        final result2 = extractTagData('{@column key1: false key2: true}');
        expect(result.options, equals({'key1': 'false'}));
        expect(result2.options, equals({'key1': 'false', 'key2': 'true'}));
      });

      test('Trims leading and trailing whitespace from tag contents', () {
        final result = extractTagData('{@column key1: value1 key2: value2 }');
        expect(result.options, equals({'key1': 'value1', 'key2': 'value2'}));
      });
    },
  );
}

extension on SubSectionBlockDto {
  ContentOptions? get columnOptiouns => (this as ColumnBlockDto).options;
}