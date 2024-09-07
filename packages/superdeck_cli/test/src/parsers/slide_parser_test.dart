import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/parsers/slide_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:test/test.dart';

void main() {
  group('parseSlides', () {
    test('parses valid markdown into slides', () {
      const markdown = '''
---
title: Slide 1
---

Content for slide 1

---
title: Slide 2 
---  

Content for slide 2
''';

      final slides = parseSlides(markdown);

      for (var slide in slides) {
        print('Slide: ${slide.options?.title}');
        print('Markdown: ${slide.markdown}');
      }

      expect(slides.length, equals(2));
      expect(slides[0].options?.title, equals('Slide 1'));
      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options?.title, equals('Slide 2'));
      expect(slides[1].markdown, equals('Content for slide 2'));
    });

    test('parses slides with additional properties in YAML frontmatter', () {
      const markdown = '''
---
title: Slide 1
---
Content for slide 1

---
title: Slide 2 
---  
Content for slide 2
''';

      final slides = parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options?.title, equals('Slide 1'));

      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options?.title, equals('Slide 2'));

      expect(slides[1].markdown, equals('Content for slide 2'));
    });

    test('handles slides with no properties in frontmatter', () {
      const markdown = '''
---
---
Content for slide 1

---
---
Content for slide 2
''';

      final slides = parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options, SlideOptions());
      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options, SlideOptions());
      expect(slides[1].markdown, equals('Content for slide 2'));
    });

    test('handles slides with empty frontmatter', () {
      const markdown = '''
---
title: 
---
Content for slide 1

---
title: 
---  
Content for slide 2
''';

      final slides = parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options?.title, isNull);
      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options?.title, isNull);
      expect(slides[1].markdown, equals('Content for slide 2'));
    });

    test('throws SDFormatException on invalid YAML frontmatter', () {
      const markdown = '''
---  
invalid: yaml: frontmatter
---
Slide content
''';

      expect(() => parseSlides(markdown), throwsA(isA<SDFormatException>()));
    });

    test('throws SDMarkdownParsingException on invalid slide schema', () {
      const markdown = '''
---
invalidField: Invalid value
---  
Slide content 
''';

      expect(() => parseSlides(markdown),
          throwsA(isA<SDMarkdownParsingException>()));
    });

    test('handles empty markdown string', () {
      const markdown = '';

      final slides = parseSlides(markdown);

      expect(slides, isEmpty);
    });

    test('ignores content outside slide separators', () {
      const markdown = '''
This content is outside slides
---
title: Slide 1
---
Content for slide 1

This content is also outside slides
''';

      final slides = parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[1].options?.title, equals('Slide 1'));
      expect(slides[1].markdown,
          equals('Content for slide 1\n\nThis content is also outside slides'));
    });

    test('parses slide with no content but valid frontmatter', () {
      const markdown = '''
---
title: Slide 1
---
''';

      final slides = parseSlides(markdown);

      expect(slides.length, equals(1));
      expect(slides[0].options?.title, equals('Slide 1'));
      expect(slides[0].markdown, isEmpty);
    });

    test('parses multiple slides with some missing content or frontmatter', () {
      const markdown = '''
---
title: Slide 1
---
Content for slide 1

---
title: Slide 2
---
---
title: Slide 3
---
Content for slide 3
''';

      final slides = parseSlides(markdown);

      expect(slides.length, equals(3));
      expect(slides[0].options?.title, equals('Slide 1'));
      expect(slides[0].markdown, equals('Content for slide 1'));

      expect(slides[1].options?.title, equals('Slide 2'));
      expect(slides[1].markdown, isEmpty);

      expect(slides[2].options?.title, equals('Slide 3'));
      expect(slides[2].markdown, equals('Content for slide 3'));
    });
  });

  // Group test notes from comments
  group('Correctly parses slide notes from markdown comments', () {
    test('parses notes from markdown comments', () {
      const markdown = '''
---
title: Slide 1
---
Content for slide 1

<!-- This is a note for slide 1 -->

---
title: Slide 2
---

Content for slide 2

''';

      final slides = parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options?.title, equals('Slide 1'));
      expect(slides[0].markdown,
          equals('Content for slide 1\n\n<!-- This is a note for slide 1 -->'));
      expect(slides[0].notes.length, equals(1));
      expect(slides[0].notes[0].note, equals('This is a note for slide 1'));

      expect(slides[1].options?.title, equals('Slide 2'));
      expect(slides[1].markdown, equals('Content for slide 2'));
      expect(slides[1].notes, isEmpty);
    });

    test('parses multiple notes from markdown comments', () {
      const markdown = '''
---
title: Slide 1
---
Content for slide 1

<!-- This is a note for slide 1 -->

<!-- This is another note for slide 1 -->

<!-- This is a third note for 
slide 1 -->

---
title: Slide 2
---

Content for slide 2

''';

      final slides = parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options?.title, equals('Slide 1'));
      expect(
          slides[0].markdown,
          equals(
              'Content for slide 1\n\n<!-- This is a note for slide 1 -->\n\n<!-- This is another note for slide 1 -->\n\n<!-- This is a third note for \nslide 1 -->'));
      expect(slides[0].notes.length, equals(3));
      expect(slides[0].notes[0].note, equals('This is a note for slide 1'));

      expect(
          slides[0].notes[1].note, equals('This is another note for slide 1'));

      expect(slides[0].notes[2].note,
          equals('This is a third note for \nslide 1'));

      expect(slides[1].options?.title, equals('Slide 2'));
      expect(slides[1].markdown, equals('Content for slide 2'));
      expect(slides[1].notes, isEmpty);
    });
  });

  // Test that mixes single --- with frontmatter
  group('Handles slides with mixed frontmatter and ---', () {
    test('parses slides with mixed frontmatter and ---', () {
      const markdown = '''
---
title: Slide 1
--- 
Content for slide 1

---

Content for the second slide
''';

      final slides = parseSlides(markdown);

      expect(slides.length, equals(2));

      expect(slides[0].options?.title, equals('Slide 1'));
      expect(slides[0].markdown, equals('Content for slide 1'));

      expect(slides[1].options, SlideOptions());
      expect(slides[1].markdown, equals('Content for the second slide'));

      expect(slides[1].notes, isEmpty);
    });
  });
}
