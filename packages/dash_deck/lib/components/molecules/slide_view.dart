import 'package:dash_deck/helpers/slide_builder.dart';
import 'package:dash_deck_core/dash_deck_core.dart';
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

    if (slide is CoverSlide) {
      slideWidget = CoverSlideWidget(slide as CoverSlide);
    } else if (slide is ImageSlide) {
      slideWidget = ImageSlideWidget(slide as ImageSlide);
    } else if (slide is FullSlide) {
      slideWidget = FullSlideWidget(slide as FullSlide);
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
