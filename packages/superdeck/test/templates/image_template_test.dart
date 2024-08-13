import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/components/molecules/slide_content.dart';
import 'package:superdeck/superdeck.dart';
import 'package:superdeck/templates/templates.dart';

import '../test_helpers.dart';

void main() {
  group('ImageTemplate', () {
    final slideConfig = ImageSlide(
      key: 'image-slide',
      content: '',
      contentOptions: const ContentOptions(),
      options: const ImageOptions(
        src: 'https://example.com/image.jpg',
      ),
    );

    testWidgets('builds image template with correct layout',
        (WidgetTester tester) async {
      await tester.pumpSlide(slideConfig);

      expect(find.byType(SlideContent), findsOneWidget);
      expect(find.byType(ImageTemplate), findsOneWidget);

      final finder = find.byType(ImageTemplate);
      final template = tester.widget<ImageTemplate>(finder);

      expect(template.config, slideConfig);
    });
  });
}
