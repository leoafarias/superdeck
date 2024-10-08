import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/molecules/slide_preview.dart';
import '../helpers/hooks.dart';
import '../helpers/routes.dart';
import '../superdeck.dart';

class PresentationScreen extends HookWidget {
  const PresentationScreen({super.key});

  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    final slideIndex = context.currentSlideIndex;
    final pageController = usePageController(initialPage: slideIndex);

    final slides = useSlides();

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

    return Center(
      child: PageView.builder(
        controller: pageController,
        itemCount: slides.length,
        itemBuilder: (_, index) {
          return SlidePreview(slides[index]);
        },
      ),
    );
  }
}
