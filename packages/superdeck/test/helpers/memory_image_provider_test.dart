import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/helpers/cache_memory_image.dart';

void main() {
  group('CachedMemoryImage', () {
    const base64TestImage =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAACklEQVR4nGMAAQAABQABDQottAAAAABJRU5ErkJggg==';

    testWidgets('builds Image widget with correct properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const CachedMemoryImage(
          base64Image: base64TestImage,
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        ),
      );

      final Image image = tester.widget(find.byType(Image));
      expect(image.width, equals(100.0));
      expect(image.height, equals(100.0));
      expect(image.fit, equals(BoxFit.fill));
      expect(image.gaplessPlayback, isTrue);
    });

    testWidgets('decodes base64 string to bytes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const CachedMemoryImage(base64Image: base64TestImage),
      );

      final Image image = tester.widget(find.byType(Image));
      final MemoryImage memoryImage = image.image as MemoryImage;
      expect(memoryImage.bytes, equals(base64Decode(base64TestImage)));
    });

    testWidgets('uses base64 string as ValueKey', (WidgetTester tester) async {
      await tester.pumpWidget(
        const CachedMemoryImage(base64Image: base64TestImage),
      );

      final Image image = tester.widget(find.byType(Image));
      expect(image.key, equals(const ValueKey(base64TestImage)));
    });
  });
}
