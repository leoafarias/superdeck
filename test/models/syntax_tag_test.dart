import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/helpers/section_tag.dart';

void main() {
  group('Tag Detection Tests', () {
    test('Detects left and right tags with content', () {
      const input = '''
::left::

## Content One
Description of content

::right::

#### Content Two

- First bullet point
- Second bullet point
- Third bullet point
''';
      final expected = {
        SectionTag.left: '''

## Content One
Description of content

''',
        SectionTag.right: '''

#### Content Two

- First bullet point
- Second bullet point
- Third bullet point
'''
      };
      expect(
        parseContentSections(input),
        expected,
      );
    });

    test('Handles input without tags correctly', () {
      const input = '''
## Content One
Description of content
''';
      final expected = <String, String>{
        SectionTag.first: '''
## Content One
Description of content
'''
      };
      expect(parseContentSections(input), expected);
    });

    test('Detects right tag only with content', () {
      const input = '''
## Content One
Description of content

::right::

#### Content Two

- First bullet point
- Second bullet point
- Third bullet point
''';
      final expected = {
        SectionTag.first: '''
## Content One
Description of content

''',
        SectionTag.right: '''

#### Content Two

- First bullet point
- Second bullet point
- Third bullet point
'''
      };
      expect(parseContentSections(input), expected);
    });

    test('Detects misaligned left tag with content', () {
      const input = '''
## Content One
Description of content

::left::

#### Content Two

- First bullet point
- Second bullet point
- Third bullet point
''';
      final expected = {
        SectionTag.first: '''
## Content One
Description of content

''',
        SectionTag.left: '''

#### Content Two

- First bullet point
- Second bullet point
- Third bullet point
'''
      };
      expect(parseContentSections(input), expected);
    });

    test('Throws exception for duplicate tags', () {
      const input = '''
::left::

## Content One
Description of content

::left::

#### Content Two

- First bullet point
- Second bullet point
- Third bullet point
''';
      expect(
          () => parseContentSections(
                input,
              ),
          throwsException);
    });

    test('Throws exception for empty content between same tags', () {
      const input = '''
::left::
::left::

Description of content
''';
      expect(
          () => parseContentSections(
                input,
              ),
          throwsException);
    });
  });
}
