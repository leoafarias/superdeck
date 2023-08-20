import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:flutter/material.dart';

class SlideDataProvider extends InheritedWidget {
  const SlideDataProvider({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final SlideData data;

  static SlideData of(BuildContext context) {
    final data =
        context.dependOnInheritedWidgetOfExactType<SlideDataProvider>()?.data;

    if (data == null) {
      throw Exception('SlideData.of() needs to be called within a Slide');
    }
    return data;
  }

  @override
  bool updateShouldNotify(SlideDataProvider oldWidget) {
    return data != oldWidget.data;
  }
}
