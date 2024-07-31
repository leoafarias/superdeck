import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/components/atoms/slide_view.dart';
import 'package:superdeck/providers/slide_provider.dart';
import 'package:superdeck/superdeck.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpWithScaffold(Widget widget) async {
    await pumpWidget(MaterialApp(home: Scaffold(body: widget)));
  }

  Future<void> pumpSlide(Widget widget) async {
    await pumpWidget(MaterialApp(home: widget));
  }

  Future<void> pumpSlideView(
    Slide slide, {
    bool isSnapshot = false,
  }) async {
    await pumpWithScaffold(
      SlideView(
        slide,
        isSnapshot: isSnapshot,
      ),
    );
  }

  Future<void> pumpWithSlideBuilder<T extends Slide>(
    T slide, {
    bool isSnapshot = false,
    SlideSpec spec = const SlideSpec(),
    Map<String, ExampleBuilder> examples = const {},
    List<SlideAsset> assets = const [],
  }) async {
    return pumpWithScaffold(
      SlideBuilder<T>(
        config: slide,
        spec: spec,
        isSnapshot: isSnapshot,
        examples: examples,
        assets: assets,
      ),
    );
  }
}
