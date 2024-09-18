import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/src/components/atoms/slide_view.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleTemplate', () {
    const rawMarkdown = '''
# Hello
''';
    final slideConfig = Slide(markdown: rawMarkdown, key: 'simple-slide');
    testWidgets('builds content', (WidgetTester tester) async {
      await tester.pumpSlide(slideConfig);
      final finder = find.byType(SlideView);
      expect(finder, findsOneWidget);
      // Check if template model equals to slide model
      final template = tester.widget<SlideView>(finder);
      expect(template.slideIndex, slideConfig);
    });
  });
}
