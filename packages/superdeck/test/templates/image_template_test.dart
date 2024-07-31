import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/components/molecules/slide_content.dart';
import 'package:superdeck/superdeck.dart';
import 'package:superdeck/templates/templates.dart';

import '../test_helpers.dart';

void main() {
  group('ImageTemplate', () {
    final slideConfig = ImageSlide(
      key: 'image-slide',
      data: '',
      contentOptions: const ContentOptions(),
      options: const ImageOptions(
        src: 'https://example.com/image.jpg',
      ),
    );
    const spec = SlideSpec(
      image: ImageSpec(
        width: 800,
        height: 600,
        alignment: Alignment.center,
        fit: BoxFit.cover,
      ),
    );

    testWidgets('builds image template with correct layout',
        (WidgetTester tester) async {
      await tester.pumpWithSlideBuilder(slideConfig, spec: spec);

      expect(find.byType(SlideContent), findsOneWidget);
      expect(find.byType(ImageTemplate), findsOneWidget);

      final finder = find.byType(ImageTemplate);
      final template = tester.widget<ImageTemplate>(finder);
      expect(template.model.config, slideConfig);
      expect(template.model.spec, spec);
    });
  });
}
