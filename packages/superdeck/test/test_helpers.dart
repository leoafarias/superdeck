import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/src/components/atoms/slide_view.dart';
import 'package:superdeck/src/modules/common/styles/style.dart';
import 'package:superdeck/src/modules/deck/deck_controller.dart';
import 'package:superdeck/src/modules/widget_capture/widget_capture_provider.dart';
import 'package:superdeck_core/superdeck_core.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpWithScaffold(Widget widget) async {
    await pumpWidget(MaterialApp(home: Scaffold(body: widget)));
  }

  Future<void> pumpSlide<T extends Slide>(
    T slide, {
    bool isSnapshot = false,
    DeckStyle? style,
    Map<String, WidgetBuilderWithOptions> widgets = const {},
    List<SlideAsset> assets = const [],
  }) async {
    final controller = DeckController(
      styles: const {},
      baseStyle: style ?? DeckStyle(),
      widgets: widgets,
    );
    return pumpWithScaffold(
      SnapshotProvider(
        isCapturing: isSnapshot,
        child: DeckControllerProvider(
          controller: controller,
          child: SlideView(slide),
        ),
      ),
    );
  }
}
