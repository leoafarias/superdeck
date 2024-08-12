import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/components/atoms/slide_view.dart';
import 'package:superdeck/providers/assets_provider.dart';
import 'package:superdeck/providers/examples_provider.dart';
import 'package:superdeck/providers/snapshot_provider.dart';
import 'package:superdeck/providers/style_provider.dart';
import 'package:superdeck/superdeck.dart';

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
        child: StyleProvider(
          baseStyle: style,
          child: AssetsProvider(
            assets: assets,
            child: ExamplesProvider(
              examples: examples,
              child: SlideView(slide),
            ),
          ),
        ),
      ),
    );
  }
}
