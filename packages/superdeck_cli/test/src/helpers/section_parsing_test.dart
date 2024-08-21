import 'package:collection/collection.dart';
import 'package:superdeck_cli/src/helpers/section_parsing.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:test/test.dart';

void main() {
  group('LayoutSection', () {
    group('Successful cases', () {
      test('Header with columns', () {
        const markdown = '''
{@header}
# Header Title

{@content}
Header content column 1.

{@content}
Header content column 2.

''';

        final sections = parseSections(markdown);
        expect(sections.root?.subSections.length, isNull);
        expect(sections.header?.subSections.length, equals(3));
        expect(sections.body?.subSections.length, isNull);
        expect(sections.footer?.subSections.length, isNull);
        expect(
            sections.header?.subSections[0].content.trim(), '# Header Title');
        expect(sections.header?.subSections[1].content.trim(),
            'Header content column 1.');
        expect(sections.header?.subSections[2].content.trim(),
            'Header content column 2.');
      });

      test('Body with columns', () {
        const markdown = '''
{@body}
{@content}
Body content column 1.

{@content}
Body content column 2.

''';

        final sections = parseSections(markdown);
        expect(sections.root?.subSections.length, isNull);
        expect(sections.header?.subSections.length, isNull);
        expect(sections.body?.subSections.length, equals(2));
        expect(sections.footer?.subSections.length, isNull);
        expect(sections.body?.subSections[0].content.trim(),
            'Body content column 1.');
        expect(sections.body?.subSections[1].content.trim(),
            'Body content column 2.');
      });

      test('Footer with columns', () {
        const markdown = '''
{@footer}
{@content}
Footer content column 1.

{@content}
Footer content column 2.

''';

        final sections = parseSections(markdown);
        expect(sections.root?.subSections.length, isNull);
        expect(sections.header?.subSections.length, isNull);
        expect(sections.body?.subSections.length, isNull);
        expect(sections.footer?.subSections.length, equals(2));
        expect(sections.footer?.subSections[0].content.trim(),
            'Footer content column 1.');
        expect(sections.footer?.subSections[1].content.trim(),
            'Footer content column 2.');
      });

      test('Only columns without header, body, or footer', () {
        const markdown = '''
{@content}
Content column 1.

{@content}
Content column 2.

''';

        final sections = parseSections(markdown);
        expect(sections.root?.subSections.length, equals(2));
        expect(sections.header?.subSections.length, isNull);
        expect(sections.body?.subSections.length, isNull);
        expect(sections.footer?.subSections.length, isNull);
        expect(
            sections.root?.subSections[0].content.trim(), 'Content column 1.');
        expect(
            sections.root?.subSections[1].content.trim(), 'Content column 2.');
      });

      test('Header, body, and footer with columns', () {
        const markdown = '''
{@header}
# Header Title

{@content}
Header content column.

{@body}
{@content}
Body content column 1.

{@content}
Body content column 2.

{@footer}
{@content}
Footer content column.

''';

        final sections = parseSections(markdown);

        expect(sections.root?.subSections.length, isNull);
        expect(sections.header?.subSections.length, equals(2));
        expect(sections.body?.subSections.length, equals(2));
        expect(sections.footer?.subSections.length, equals(1));
        expect(
            sections.header?.subSections[0].content.trim(), '# Header Title');
        expect(sections.header?.subSections[1].content.trim(),
            'Header content column.');
        expect(sections.body?.subSections[0].content.trim(),
            'Body content column 1.');
        expect(sections.body?.subSections[1].content.trim(),
            'Body content column 2.');
        expect(sections.footer?.subSections[0].content.trim(),
            'Footer content column.');
      });
    });
    group('Fail cases', () {
      test('Fail case - Column tag appears outside header, body, or footer',
          () {
        const markdown = '''
# Regular Markdown

{@content}
This is some regular markdown content.

{@header}
## Header Title

{@content}
Content inside the header.

''';

        expect(() => parseSections(markdown), throwsException);
      });

      test('Fail case - Header appears after body', () {
        const markdown = '''
{@body}
# Body Title

{@content}
Content in the body.

{@header}
## Header Title

{@content}
Content in the header.

''';

        expect(() => parseSections(markdown), throwsException);
      });

      test('Fail case - Body appears after footer', () {
        const markdown = '''
{@footer}
# Footer Title

{@content}
Content in the footer.

{@body}
## Body Title

{@content}
Content in the body.

''';

        expect(() => parseSections(markdown), throwsException);
      });
    });
  });

  group('ContentPart - Attribute Testing', () {
    test('Header with columns and flex attribute', () {
      const markdown = '''
{@header}
{@content flex: 1 }
Header content column 1.

{@content flex: 2}
Header content column 2.

''';

      final sections = parseSections(markdown);

      expect(sections.root?.subSections.length, isNull);
      expect(sections.header?.subSections.length, equals(2));
      expect(sections.body?.subSections.length, isNull);
      expect(sections.footer?.subSections.length, isNull);

      expect(sections.header?.subSections[0].content.trim(),
          'Header content column 1.');
      expect(sections.header?.subSections[1].content.trim(),
          'Header content column 2.');

      expect(sections.header?.subSections[0].contentOptions.flex, equals(1));
      expect(sections.header?.subSections[1].contentOptions.flex, equals(2));
    });

    test('Body with columns and alignment attribute in snake case', () {
      const markdown = '''
{@body}
{@content align:center}
Body content column 1.

{@content align:bottom_right}
Body content column 2.

''';

      final sections = parseSections(markdown);

      expect(sections.root?.subSections.length, isNull);
      expect(sections.header?.subSections.length, isNull);
      expect(sections.body?.subSections.length, equals(2));
      expect(sections.footer?.subSections.length, isNull);

      expect(sections.body?.subSections[0].content.trim(),
          'Body content column 1.');
      expect(sections.body?.subSections[1].content.trim(),
          'Body content column 2.');

      expect(sections.body?.subSections[0].contentOptions.align,
          equals(ContentAlignment.center));
      expect(sections.body?.subSections[1].contentOptions.align,
          equals(ContentAlignment.bottomRight));
    });

    test('Footer with columns, flex, and alignment attributes in snake case',
        () {
      const markdown = '''
{@footer}
{@content flex:3 | align:top_left}
Footer content column 1.

{@content flex:1 | align:center_right}
Footer content column 2.

''';

      final sections = parseSections(markdown);

      expect(sections.root?.subSections.length, isNull);
      expect(sections.header?.subSections.length, isNull);
      expect(sections.body?.subSections.length, isNull);
      expect(sections.footer?.subSections.length, equals(2));

      expect(sections.footer?.subSections[0].content.trim(),
          'Footer content column 1.');
      expect(sections.footer?.subSections[1].content.trim(),
          'Footer content column 2.');

      expect(sections.footer?.subSections[0].contentOptions.flex, equals(3));
      expect(sections.footer?.subSections[0].contentOptions.align,
          equals(ContentAlignment.topLeft));

      expect(sections.footer?.subSections[1].contentOptions.flex, equals(1));
      expect(sections.footer?.subSections[1].contentOptions.align,
          equals(ContentAlignment.centerRight));
    });

    test('Mixed header, body, and footer with columns and attributes', () {
      const markdown = '''
{@header}
{@content flex:1 | align:center}
Header content.

{@body}
{@content flex:2 | align:center_left}
Body content column 1.

{@content flex:1 | align:center_right}
Body content column 2.

{@footer}
{@content flex:1 | align:bottom_center}
Footer content.

''';

      final sections = parseSections(markdown);

      expect(sections.root?.subSections.length, isNull);
      expect(sections.header?.subSections.length, equals(1));
      expect(sections.body?.subSections.length, equals(2));
      expect(sections.footer?.subSections.length, equals(1));

      expect(sections.header?.subSections[0].content.trim(), 'Header content.');
      expect(sections.header?.subSections[0].contentOptions.flex, equals(1));
      expect(sections.header?.subSections[0].contentOptions.align,
          equals(ContentAlignment.center));

      expect(sections.body?.subSections[0].content.trim(),
          'Body content column 1.');
      expect(sections.body?.subSections[0].contentOptions.flex, equals(2));
      expect(sections.body?.subSections[0].contentOptions.align,
          equals(ContentAlignment.centerLeft));

      expect(sections.body?.subSections[1].content.trim(),
          'Body content column 2.');
      expect(sections.body?.subSections[1].contentOptions.flex, equals(1));
      expect(sections.body?.subSections[1].contentOptions.align,
          equals(ContentAlignment.centerRight));

      expect(sections.footer?.subSections[0].content.trim(), 'Footer content.');
      expect(sections.footer?.subSections[0].contentOptions.flex, equals(1));
      expect(sections.footer?.subSections[0].contentOptions.align,
          equals(ContentAlignment.bottomCenter));
    });
  });

  group('ContentPart - Fail Cases', () {
    test('Fail case - Column tag appears outside header, body, or footer', () {
      const markdown = '''
# Regular Markdown

{@content flex:1}
This is some regular markdown content.

{@header}
## Header Title

{@content}
Content inside the header.

''';

      expect(() => parseSections(markdown), throwsException);
    });

    test('Fail case - Invalid flex attribute format', () {
      const markdown = '''
{@header}
{@content flex:invalid}
Header content.

''';

      expect(() => parseSections(markdown), throwsException);
    });

    test('Fail case - Invalid alignment attribute value', () {
      const markdown = '''
{@header}
{@content align:invalid_alignment}
Header content.

''';

      expect(() => parseSections(markdown), throwsException);
    });
  });

  // Group that checks if columns inherit options from the parent
  group('ContentPart - Inheritance', () {
    test('Columns inherit options from the parent', () {
      const markdown = '''
{@header align:center}
{@content}
Header content.

{@body align:top_left | flex:2}
{@content flex:3}
Body content.

{@footer align:bottom_right | flex:1}
{@content align:bottom_right}
Footer content.

''';

      final sections = parseSections(markdown);

      expect(sections.root?.subSections.length, isNull);
      expect(sections.header?.subSections.length, equals(1));
      expect(sections.body?.subSections.length, equals(1));
      expect(sections.footer?.subSections.length, equals(1));

      expect(sections.header?.subSections[0].content.trim(), 'Header content.');
      expect(sections.header?.options.align, equals(ContentAlignment.center));

      expect(sections.body?.subSections[0].content.trim(), 'Body content.');
      expect(sections.body?.options.align, equals(ContentAlignment.topLeft));
      expect(sections.body?.subSections[0].contentOptions.flex, equals(3));

      expect(sections.footer?.subSections[0].content.trim(), 'Footer content.');
      expect(
          sections.footer?.options.align, equals(ContentAlignment.bottomRight));
      expect(sections.footer?.options.flex, equals(1));
    });
  });

  group(
    'getTagContents',
    () {
      test('Empty string', () {
        final result = getTagContents('{@tag}');
        expect(result.tag, equals('tag'));
        expect(result.options, isEmpty);
      });

      test('Single key-value pair', () {
        final result = getTagContents('{@tag key1: value1}');
        expect(result.tag, equals('tag'));
        expect(result.options, equals({'key1': 'value1'}));
      });

      test('Multiple key-value pairs', () {
        final result = getTagContents('{@tag key1: value1 | key2: value2}');
        expect(result.options, equals({'key1': 'value1', 'key2': 'value2'}));
      });

      test('Extra spaces', () {
        final result = getTagContents('{@tag  key1:  value1 |  key2:  value2}');
        expect(result.options, equals({'key1': 'value1', 'key2': 'value2'}));
      });

      test('Empty value', () {
        final result = getTagContents('{@tag key1:}');
        expect(result.options, equals({'key1': null}));
      });

      test('Missing value', () {
        final result = getTagContents('{@tag key1}');
        expect(result.options, equals({'key1': true}));
      });

      test('Invalid tag format', () {
        expect(() => getTagContents('{@tag key1:'), throwsException);
      });

      test('Returns contents of the first tag when multiple tags are present',
          () {
        final result = getTagContents('{@first firstTag} {@second tag}');
        expect(result.tag, equals('first'));
        expect(result.options, equals({'firstTag': true}));
      });

      test('Mixed valid and invalid pairs', () {
        final result =
            getTagContents('{@tag key1: value1 | single | key2: value2}');
        expect(
          result.tag,
          equals('tag'),
        );

        expect(result.options,
            equals({'key1': 'value1', 'single': true, 'key2': 'value2'}));
      });

      // Test falsy value
      test('Falsy value', () {
        final result = getTagContents('{@tag key1: false}');
        final result2 = getTagContents('{@tag key1: "false" | key2: true}');
        expect(result.options, equals({'key1': false}));
        expect(result2.options, equals({'key1': 'false', 'key2': true}));
      });

      test('Returns contents of the first tag when multiple tags are present',
          () {
        final result = getTagContents('{@first firstTag} {@second tag}');
        expect(result.tag, equals('first'));
        expect(result.options, equals({'firstTag': true}));
      });

      test('Trims leading and trailing whitespace from tag contents', () {
        final result = getTagContents('{@tag key1: value1 | key2: value2 }');
        expect(result.options, equals({'key1': 'value1', 'key2': 'value2'}));
      });
    },
  );
}

extension on List<SectionPart> {
  SectionPart? get root => firstWhereOrNull((part) => part.type.name == 'root');
  SectionPart? get header =>
      firstWhereOrNull((part) => part.type.name == 'header');
  SectionPart? get body => firstWhereOrNull((part) => part.type.name == 'body');
  SectionPart? get footer =>
      firstWhereOrNull((part) => part.type.name == 'footer');
}

extension on SubSectionPart {
  String get content => (this as ContentPart).content;
  ContentOptions get contentOptions => (this as ContentPart).options;
  ImageOptions get imageOptions => (this as ImagePart).options;
}
