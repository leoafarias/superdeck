import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/models/syntax_tag.dart';

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
        SyntaxTag.left: '''

## Content One
Description of content

''',
        SyntaxTag.right: '''

#### Content Two

- First bullet point
- Second bullet point
- Third bullet point
'''
      };
      expect(
        parseContentWithTags(input, [SyntaxTag.left, SyntaxTag.right]),
        expected,
      );
    });

    test('Handles input without tags correctly', () {
      const input = '''
## Content One
Description of content
''';
      final expected = <String, String>{
        SyntaxTag.content: '''
## Content One
Description of content
'''
      };
      expect(parseContentWithTags(input, [SyntaxTag.left, SyntaxTag.right]),
          expected);
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
        SyntaxTag.content: '''
## Content One
Description of content

''',
        SyntaxTag.right: '''

#### Content Two

- First bullet point
- Second bullet point
- Third bullet point
'''
      };
      expect(parseContentWithTags(input, [SyntaxTag.left, SyntaxTag.right]),
          expected);
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
        SyntaxTag.content: '''
## Content One
Description of content

''',
        SyntaxTag.left: '''

#### Content Two

- First bullet point
- Second bullet point
- Third bullet point
'''
      };
      expect(parseContentWithTags(input, [SyntaxTag.left, SyntaxTag.right]),
          expected);
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
          () => parseContentWithTags(input, [SyntaxTag.left, SyntaxTag.right]),
          throwsException);
    });

    test('Throws exception for empty content between same tags', () {
      const input = '''
::left::
::left::

Description of content
''';
      expect(
          () => parseContentWithTags(input, [SyntaxTag.left, SyntaxTag.right]),
          throwsException);
    });
  });
}
