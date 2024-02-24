import 'package:superdeck/helpers/slide_builder.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:flutter/material.dart';

class SlideView extends StatelessWidget {
  const SlideView(
    this.slide, {
    super.key,
  });

  final Slide slide;

  @override
  Widget build(BuildContext context) {
    Widget slideWidget;

    if (slide is ImageSlide) {
      slideWidget = ImageSlideWidget(slide as ImageSlide);
    } else if (slide is TwoColumnSlide) {
      slideWidget = TwoColumnSlideWidget(slide as TwoColumnSlide);
    } else if (slide is TwoColumnHeaderSlide) {
      slideWidget = TwoColumnHeaderSlideWidget(slide as TwoColumnHeaderSlide);
    } else {
      slideWidget = SlideWidget(slide);
    }

    return slideWidget;
  }
}
