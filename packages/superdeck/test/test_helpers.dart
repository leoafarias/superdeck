import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix/mix.dart';
import 'package:superdeck/components/atoms/slide_view.dart';
import 'package:superdeck/providers/controller.dart';
import 'package:superdeck/providers/snapshot_provider.dart';
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
        child: SuperDeckProvider(
          controller: SuperDeckController(
            styles: {},
            baseStyle: style,
            examples: examples,
          ),
          child: SlideView(slide),
        ),
      ),
    );
  }
}
