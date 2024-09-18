import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/styles/style_spec.dart';
import 'deck_controller.dart';

class SlideConfiguration {
  final Slide slide;
  final int slideIndex;
  final SlideSpec spec;
  final DeckController controller;
  final Style slideStyle;

  const SlideConfiguration({
    required this.slide,
    required this.slideIndex,
    required this.spec,
    required this.controller,
    required this.slideStyle,
  });

  static SlideConfiguration of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_SlideConfigurationProvider>()!
        .configuration;
  }

  Widget inherit(
    Widget Function(BuildContext, SlideConfiguration) builder,
  ) {
    return SlideConfigurationBuilder(
      slideIndex: slideIndex,
      controller: controller,
      builder: builder,
    );
  }

  Widget watch(Widget Function(BuildContext context) builder) {
    return _SlideConfigurationProvider(
      configuration: this,
      child: Builder(builder: builder),
    );
  }

  Widget buildHeader() {
    return _SlidePartBuilder(controller.header);
  }

  Widget buildFooter() {
    return _SlidePartBuilder(controller.footer);
  }

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

class _SlideConfigurationProvider extends InheritedWidget {
  final SlideConfiguration configuration;

  const _SlideConfigurationProvider({
    required this.configuration,
    required super.child,
  });

  @override
  bool updateShouldNotify(_SlideConfigurationProvider oldWidget) {
    return configuration != oldWidget.configuration;
  }
}

class SlideConfigurationBuilder extends StatelessWidget {
  final int slideIndex;

  final Widget Function(BuildContext, SlideConfiguration) builder;

  final DeckController controller;

  const SlideConfigurationBuilder({
    super.key,
    required this.slideIndex,
    required this.controller,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final slide = controller.getSlide(slideIndex);
    final slideStyle = controller.getStyle(slide.options?.style);

    return SpecBuilder(
      style: slideStyle,
      builder: (context) {
        final spec = SlideSpec.of(context);

        return _SlideConfigurationProvider(
            configuration: SlideConfiguration(
              slide: slide,
              slideIndex: slideIndex,
              spec: spec,
              slideStyle: slideStyle,
              controller: controller,
            ),
            child: Builder(
              builder: (context) {
                return builder(context, SlideConfiguration.of(context));
              },
            ));
      },
    );
  }
}

class _SlidePartBuilder extends StatelessWidget {
  final SlidePart? part;

  const _SlidePartBuilder(
    this.part,
  );

  @override
  Widget build(BuildContext context) {
    if (part == null) {
      return const SizedBox();
    }

    return SizedBox(
      height: part!.height,
      child: part!.build(context),
    );
  }
}
