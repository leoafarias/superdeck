import 'package:flutter/widgets.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/styles/style_spec.dart';
import 'deck_controller.dart';

class SlideConfiguration {
  final Slide slide;
  final int slideIndex;
  final SlideSpec spec;
  final DeckController controller;

  const SlideConfiguration({
    required this.slide,
    required this.slideIndex,
    required this.spec,
    required this.controller,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SlideConfiguration &&
        other.slide == slide &&
        other.slideIndex == slideIndex &&
        other.spec == spec &&
        other.controller == controller;
  }

  @override
  int get hashCode {
    return slide.hashCode ^
        slideIndex.hashCode ^
        spec.hashCode ^
        controller.hashCode;
  }
}

class SlideProvider extends InheritedWidget {
  final SlideConfiguration configuration;

  const SlideProvider({
    super.key,
    required this.configuration,
    required super.child,
  });

  static SlideProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SlideProvider>()!;
  }

  @override
  bool updateShouldNotify(SlideProvider oldWidget) {
    return configuration != oldWidget.configuration;
  }
}
