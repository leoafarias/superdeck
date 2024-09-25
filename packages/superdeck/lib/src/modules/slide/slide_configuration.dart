import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import 'slide_parts.dart';

class SlideConfiguration extends Slide {
  final int slideIndex;

  final FixedSlidePart? header;
  final FixedSlidePart? footer;
  final SlidePart? background;

  final Style style;

  const SlideConfiguration._({
    required super.key,
    required super.options,
    required super.markdown,
    required super.sections,
    required super.notes,
    required this.slideIndex,
    required this.header,
    required this.footer,
    required this.background,
    required this.style,
  });

  factory SlideConfiguration({
    required Slide slide,
    required int slideIndex,
    required Style style,
    FixedSlidePart? header,
    FixedSlidePart? footer,
    SlidePart? background,
  }) {
    return SlideConfiguration._(
      key: slide.key,
      options: slide.options,
      markdown: slide.markdown,
      sections: slide.sections,
      notes: slide.notes,
      slideIndex: slideIndex,
      header: header,
      footer: footer,
      background: background,
      style: style,
    );
  }

  static SlideConfigurationProvider _of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SlideConfigurationProvider>()!;
  }

  static SlideConfiguration of(BuildContext context) {
    return _of(context).configuration;
  }

  static bool isCapturing(BuildContext context) {
    return _of(context).isCapturing;
  }

  Widget buildHeader() {
    return _PartBuilder(header);
  }

  Widget buildFooter() {
    return _PartBuilder(footer);
  }

  Widget buildBackground() {
    return background ?? const SizedBox.shrink();
  }
}

class SlideConfigurationProvider extends InheritedWidget {
  final SlideConfiguration configuration;
  final bool isCapturing;

  const SlideConfigurationProvider({
    super.key,
    required this.configuration,
    required super.child,
    this.isCapturing = false,
  });

  @override
  bool updateShouldNotify(SlideConfigurationProvider oldWidget) {
    return configuration != oldWidget.configuration;
  }
}

class _PartBuilder extends StatelessWidget {
  final SlidePart? part;

  const _PartBuilder(
    this.part,
  );

  @override
  Widget build(BuildContext context) {
    if (part == null) {
      return const SizedBox();
    }

    return part!;
  }
}
