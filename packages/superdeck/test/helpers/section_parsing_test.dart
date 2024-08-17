import 'package:superdeck/helpers/section_parsing.dart';
import 'package:superdeck/superdeck.dart';
import 'package:test/test.dart';

extension on List<SectionPart> {
  SectionPart get header =>
      firstWhere((part) => part.location == Section.header);
  SectionPart get body => firstWhere((part) => part.location == Section.body);
  SectionPart get footer =>
      firstWhere((part) => part.location == Section.footer);
}

void main() {
  group('LayoutSection', () {
    group('Successful cases', () {
      test('Header with columns', () {
        const markdown = '''
{.header}
# Header Title

{.content}
Header content column 1.

{.content}
Header content column 2.

''';

        final sections = parseSections(markdown);
        expect(sections.header.contentParts.length, equals(3));
        expect(sections.body.contentParts.length, equals(0));
        expect(sections.footer.contentParts.length, equals(0));
        expect(
            sections.header.contentParts[0].content.trim(), '# Header Title');
        expect(sections.header.contentParts[1].content.trim(),
            'Header content column 1.');
        expect(sections.header.contentParts[2].content.trim(),
            'Header content column 2.');
      });

      test('Body with columns', () {
        const markdown = '''
{.body}
{.content}
Body content column 1.

{.content}
Body content column 2.

''';

        final sections = parseSections(markdown);
        expect(sections.header.contentParts.length, equals(0));
        expect(sections.body.contentParts.length, equals(2));
        expect(sections.footer.contentParts.length, equals(0));
        expect(sections.body.contentParts[0].content.trim(),
            'Body content column 1.');
        expect(sections.body.contentParts[1].content.trim(),
            'Body content column 2.');
      });

      test('Footer with columns', () {
        const markdown = '''
{.footer}
{.content}
Footer content column 1.

{.content}
Footer content column 2.

''';

        final sections = parseSections(markdown);
        expect(sections.header.contentParts.length, equals(0));
        expect(sections.body.contentParts.length, equals(0));
        expect(sections.footer.contentParts.length, equals(2));
        expect(sections.footer.contentParts[0].content.trim(),
            'Footer content column 1.');
        expect(sections.footer.contentParts[1].content.trim(),
            'Footer content column 2.');
      });

      test('Only columns without header, body, or footer', () {
        const markdown = '''
{.content}
Content column 1.

{.content}
Content column 2.

''';

        final sections = parseSections(markdown);
        expect(sections.header.contentParts.length, equals(0));
        expect(sections.body.contentParts.length, equals(2));
        expect(sections.footer.contentParts.length, equals(0));
        expect(
            sections.body.contentParts[0].content.trim(), 'Content column 1.');
        expect(
            sections.body.contentParts[1].content.trim(), 'Content column 2.');
      });

      test('Header, body, and footer with columns', () {
        const markdown = '''
{.header}
# Header Title

{.content}
Header content column.

{.body}
{.content}
Body content column 1.

{.content}
Body content column 2.

{.footer}
{.content}
Footer content column.

''';

        final sections = parseSections(markdown);
        expect(sections.header.contentParts.length, equals(2));
        expect(sections.body.contentParts.length, equals(2));
        expect(sections.footer.contentParts.length, equals(1));
        expect(
            sections.header.contentParts[0].content.trim(), '# Header Title');
        expect(sections.header.contentParts[1].content.trim(),
            'Header content column.');
        expect(sections.body.contentParts[0].content.trim(),
            'Body content column 1.');
        expect(sections.body.contentParts[1].content.trim(),
            'Body content column 2.');
        expect(sections.footer.contentParts[0].content.trim(),
            'Footer content column.');
      });
    });
    group('Fail cases', () {
      test('Fail case - Column tag appears outside header, body, or footer',
          () {
        const markdown = '''
# Regular Markdown

{.content}
This is some regular markdown content.

{.header}
## Header Title

{.content}
Content inside the header.

''';

        expect(() => parseSections(markdown), throwsException);
      });

      test('Fail case - Header appears after body', () {
        const markdown = '''
{.body}
# Body Title

{.content}
Content in the body.

{.header}
## Header Title

{.content}
Content in the header.

''';

        expect(() => parseSections(markdown), throwsException);
      });

      test('Fail case - Body appears after footer', () {
        const markdown = '''
{.footer}
# Footer Title

{.content}
Content in the footer.

{.body}
## Body Title

{.content}
Content in the body.

''';

        expect(() => parseSections(markdown), throwsException);
      });
    });
  });

  group('ContentPart - Attribute Testing', () {
    test('Header with columns and flex attribute', () {
      const markdown = '''
{.header}
{.content flex="1"}
Header content column 1.

{.content flex="2"}
Header content column 2.

''';

      final sections = parseSections(markdown);
      expect(sections.header.contentParts.length, equals(2));
      expect(sections.body.contentParts.length, equals(0));
      expect(sections.footer.contentParts.length, equals(0));

      expect(sections.header.contentParts[0].content.trim(),
          'Header content column 1.');
      expect(sections.header.contentParts[1].content.trim(),
          'Header content column 2.');

      expect(sections.header.contentParts[0].options.flex, equals(1));
      expect(sections.header.contentParts[1].options.flex, equals(2));
    });

    test('Body with columns and alignment attribute in snake case', () {
      const markdown = '''
{.body}
{.content alignment="center"}
Body content column 1.

{.content alignment="bottom_right"}
Body content column 2.

''';

      final sections = parseSections(markdown);
      expect(sections.header.contentParts.length, equals(0));
      expect(sections.body.contentParts.length, equals(2));
      expect(sections.footer.contentParts.length, equals(0));

      expect(sections.body.contentParts[0].content.trim(),
          'Body content column 1.');
      expect(sections.body.contentParts[1].content.trim(),
          'Body content column 2.');

      expect(sections.body.contentParts[0].options.align,
          equals(ContentAlignment.center));
      expect(sections.body.contentParts[1].options.align,
          equals(ContentAlignment.bottomRight));
    });

    test('Footer with columns, flex, and alignment attributes in snake case',
        () {
      const markdown = '''
{.footer}
{.content flex="3" alignment="top_left"}
Footer content column 1.

{.content flex="1" alignment="center_right"}
Footer content column 2.

''';

      final sections = parseSections(markdown);
      expect(sections.header.contentParts.length, equals(0));
      expect(sections.body.contentParts.length, equals(0));
      expect(sections.footer.contentParts.length, equals(2));

      expect(sections.footer.contentParts[0].content.trim(),
          'Footer content column 1.');
      expect(sections.footer.contentParts[1].content.trim(),
          'Footer content column 2.');

      expect(sections.footer.contentParts[0].options.flex, equals(3));
      expect(sections.footer.contentParts[0].options.align,
          equals(ContentAlignment.topLeft));

      expect(sections.footer.contentParts[1].options.flex, equals(1));
      expect(sections.footer.contentParts[1].options.align,
          equals(ContentAlignment.centerRight));
    });

    test('Mixed header, body, and footer with columns and attributes', () {
      const markdown = '''
{.header}
{.content flex="1" alignment="center"}
Header content.

{.body}
{.content flex="2" alignment="center_left"}
Body content column 1.

{.content flex="1" alignment="center_right"}
Body content column 2.

{.footer}
{.content flex="1" alignment="bottom_center"}
Footer content.

''';

      final sections = parseSections(markdown);
      expect(sections.header.contentParts.length, equals(1));
      expect(sections.body.contentParts.length, equals(2));
      expect(sections.footer.contentParts.length, equals(1));

      expect(sections.header.contentParts[0].content.trim(), 'Header content.');
      expect(sections.header.contentParts[0].options.flex, equals(1));
      expect(sections.header.contentParts[0].options.align,
          equals(ContentAlignment.center));

      expect(sections.body.contentParts[0].content.trim(),
          'Body content column 1.');
      expect(sections.body.contentParts[0].options.flex, equals(2));
      expect(sections.body.contentParts[0].options.align,
          equals(ContentAlignment.centerLeft));

      expect(sections.body.contentParts[1].content.trim(),
          'Body content column 2.');
      expect(sections.body.contentParts[1].options.flex, equals(1));
      expect(sections.body.contentParts[1].options.align,
          equals(ContentAlignment.centerRight));

      expect(sections.footer.contentParts[0].content.trim(), 'Footer content.');
      expect(sections.footer.contentParts[0].options.flex, equals(1));
      expect(sections.footer.contentParts[0].options.align,
          equals(ContentAlignment.bottomCenter));
    });
  });

  group('ContentPart - Fail Cases', () {
    test('Fail case - Column tag appears outside header, body, or footer', () {
      const markdown = '''
# Regular Markdown

{.content flex="1"}
This is some regular markdown content.

{.header}
## Header Title

{.content}
Content inside the header.

''';

      expect(() => parseSections(markdown), throwsException);
    });

    test('Fail case - Invalid flex attribute format', () {
      const markdown = '''
{.header}
{.content flex="invalid"}
Header content.

''';

      expect(() => parseSections(markdown), throwsException);
    });

    test('Fail case - Invalid alignment attribute value', () {
      const markdown = '''
{.header}
{.content alignment="invalid_alignment"}
Header content.

''';

      expect(() => parseSections(markdown), throwsException);
    });
  });

  // Group that checks if columns inherit options from the parent
  group('ContentPart - Inheritance', () {
    test('Columns inherit options from the parent', () {
      const markdown = '''
{.header alignment="center"}
{.content}
Header content.

{.body alignment="top_left" flex="2"}
{.content flex="3"}
Body content.

{.footer alignment="bottom_right" flex="1"}
{.content alignment="bottom_right"}
Footer content.

''';

      final sections = parseSections(markdown);
      expect(sections.header.contentParts.length, equals(1));
      expect(sections.body.contentParts.length, equals(1));
      expect(sections.footer.contentParts.length, equals(1));

      expect(sections.header.contentParts[0].content.trim(), 'Header content.');
      expect(sections.header.contentParts[0].options.align,
          equals(ContentAlignment.center));

      expect(sections.body.contentParts[0].content.trim(), 'Body content.');
      expect(sections.body.contentParts[0].options.align,
          equals(ContentAlignment.topLeft));
      expect(sections.body.contentParts[0].options.flex, equals(3));

      expect(sections.footer.contentParts[0].content.trim(), 'Footer content.');
      expect(sections.footer.contentParts[0].options.align,
          equals(ContentAlignment.bottomRight));
      expect(sections.footer.contentParts[0].options.flex, equals(1));
    });
  });

  group('extractAttributes', () {
    test('Extracts attributes from a valid tag', () {
      const tag = '{.content width:50% align:center}';
      final attributes = extractAttributesFromLine(tag);
      expect(attributes, equals({'width': '50%', 'align': 'center'}));
    });

    test('Returns an empty map when no attributes are present', () {
      const tag = '{.content}';
      final attributes = extractAttributesFromLine(tag);
      expect(attributes, equals({}));
    });

    test('Handles attributes with special characters', () {
      const tag = '{.content data_custom:some_value}';
      final attributes = extractAttributesFromLine(tag);
      expect(attributes, equals({'data_custom': 'some_value'}));
    });

    test('Ignores invalid attribute syntax', () {
      const tag = '{.content width:65% align:bottom_right invalid}';
      final attributes = extractAttributesFromLine(tag);
      expect(attributes, equals({'width': '65%', 'align': 'bottom_right'}));
    });
  });
}
