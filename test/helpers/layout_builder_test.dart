import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/components/molecules/slide_content.dart';
import 'package:superdeck/helpers/layout_builder.dart';
import 'package:superdeck/superdeck.dart';

void main() {
  group('SlideBuilder', () {
    const spec = SlideSpec();
    testWidgets(
        'buildContent returns SlideContent with correct data and options',
        (WidgetTester tester) async {
      const content = 'Test content';
      const options = ContentOptions(flex: 2);
      final slide =
          SimpleSlide(data: content, contentOptions: options, raw: '');
      final builder = SimpleSlideBuilder(config: slide, spec: spec);

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: builder)));

      final slideContentFinder = find.byType(SlideContent);
      expect(slideContentFinder, findsOneWidget);

      final slideContent = tester.widget<SlideContent>(slideContentFinder);
      expect(slideContent.data, equals(content));
      expect(slideContent.options, equals(options));
    });

    testWidgets(
        'buildContentSection returns Expanded with correct flex and content',
        (WidgetTester tester) async {
      const content = 'Test section content';
      const options = ContentOptions(flex: 3);
      const section = (content: content, options: options);
      final slide = SimpleSlide(data: '', raw: '');
      final builder = SimpleSlideBuilder(config: slide, spec: spec);

      await tester
          .pumpWidget(MaterialApp(home: builder.buildContentSection(section)));

      final expandedFinder = find.byType(Expanded);
      expect(expandedFinder, findsOneWidget);

      final expanded = tester.widget<Expanded>(expandedFinder);
      expect(expanded.flex, equals(options.flex));

      final slideContentFinder = find.byType(SlideContent);
      expect(slideContentFinder, findsOneWidget);

      final slideContent = tester.widget<SlideContent>(slideContentFinder);
      expect(slideContent.data, equals(content));
      expect(slideContent.options, equals(options));
    });
  });

  group('InvalidSlideBuilder', () {
    testWidgets(
        'build returns Container with red background and yellow error text',
        (WidgetTester tester) async {
      final slide = InvalidSlide(
          data: 'Invalid slide content',
          raw: '',
          contentOptions: const ContentOptions());
      final builder = InvalidSlideBuilder(
        config: slide,
        spec: const SlideSpec(),
      );

      await tester.pumpWidget(MaterialApp(home: builder));

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      expect(container.decoration, isA<BoxDecoration>());
      expect((container.decoration as BoxDecoration).color,
          equals(const Color.fromARGB(255, 166, 6, 6)));

      final slideContentFinder = find.byType(SlideContent);
      expect(slideContentFinder, findsOneWidget);

      final slideContent = tester.widget<SlideContent>(slideContentFinder);
      expect(slideContent.data, equals(slide.data));
    });
  });
}
