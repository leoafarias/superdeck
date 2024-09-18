import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/src/components/atoms/slide_view.dart';
import 'package:superdeck/src/modules/widget_capture/widget_capture_provider.dart';
import 'package:superdeck/superdeck.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpWithScaffold(Widget widget) async {
    await pumpWidget(MaterialApp(home: Scaffold(body: widget)));
  }

  Future<void> pumpSlide<T extends Slide>(
    T slide, {
    bool isSnapshot = false,
    DeckStyle? style,
    Map<String, ExampleBuilder> examples = const {},
    List<SlideAsset> assets = const [],
  }) async {
    final controller = DeckController(
      styles: const {},
      initialSlides: [slide],
      baseStyle: style ?? DeckStyle(),
      examples: examples,
    );
    return pumpWithScaffold(
      SnapshotProvider(
        isCapturing: isSnapshot,
        child: controller.watch((context) => const SlideView(0)),
      ),
    );
  }
}
