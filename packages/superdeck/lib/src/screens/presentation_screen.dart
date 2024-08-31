import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/molecules/slide_preview.dart';
import '../modules/common/helpers/hooks.dart';
import '../modules/common/helpers/routes.dart';
import '../modules/deck_reference/deck_reference_hooks.dart';

class PresentationScreen extends HookWidget {
  const PresentationScreen({super.key});

  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    final slideIndex = context.currentSlideIndex;
    final pageController = usePageController(initialPage: slideIndex);

    final slides = useDeckSlides();

    usePostFrameEffect(() {
      if (slideIndex >= slides.length) {
        return;
      }

      if (slideIndex < 0) {
        return;
      }
      pageController.animateToPage(
        slideIndex,
        duration: _duration,
        curve: _curve,
      );
    }, [slideIndex, slides.length]);

    return PageView(
      controller: pageController,
      children: slides.map(SlidePreview.new).toList(),
    );
  }
}
