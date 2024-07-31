import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/models/slide_model.dart';
import 'package:superdeck/templates/templates.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleTemplate', () {
    const rawMarkdown = '''
# Hello
''';
    final slideConfig =
        SimpleSlide(rawMarkdown: rawMarkdown, content: rawMarkdown);
    testWidgets('builds content', (WidgetTester tester) async {
      await tester.pumpWithSlideBuilder(slideConfig);
      final finder = find.byType(SimpleTemplate);
      expect(finder, findsOneWidget);
      // Check if template model equals to slide model
      final template = tester.widget<SimpleTemplate>(finder);
      expect(template.model.config, slideConfig);
    });
  });
}
