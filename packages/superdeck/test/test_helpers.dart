import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix/mix.dart';
import 'package:superdeck/src/components/atoms/slide_view.dart';
import 'package:superdeck/src/modules/deck_reference/deck_reference_controller.dart';
import 'package:superdeck/src/modules/deck_reference/deck_reference_provider.dart';
import 'package:superdeck/src/modules/widget_capture/snapshot_provider.dart';
import 'package:superdeck_core/superdeck_core.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpWithScaffold(Widget widget) async {
    await pumpWidget(MaterialApp(home: Scaffold(body: widget)));
  }

  Future<void> pumpSlide<T extends Slide>(
    T slide, {
    bool isSnapshot = false,
    Style style = const Style.empty(),
    Map<String, ExampleBuilder> examples = const {},
    List<SlideAsset> assets = const [],
  }) async {
    return pumpWithScaffold(
      SnapshotProvider(
        isCapturing: isSnapshot,
        child: DecKReferenceProvider(
          styles: const {},
          baseStyle: style,
          examples: examples,
          child: SlideView(slide),
        ),
      ),
    );
  }
}
