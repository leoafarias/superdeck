import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/templates/slide_template.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleTemplate', () {
    const rawMarkdown = '''
# Hello
''';
    final slideConfig = Slide(content: rawMarkdown, key: 'simple-slide');
    testWidgets('builds content', (WidgetTester tester) async {
      await tester.pumpSlide(slideConfig);
      final finder = find.byType(SlideTemplate);
      expect(finder, findsOneWidget);
      // Check if template model equals to slide model
      final template = tester.widget<SlideTemplate>(finder);
      expect(template.config, slideConfig);
    });
  });
}
