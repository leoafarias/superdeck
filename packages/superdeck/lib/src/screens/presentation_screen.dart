import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/molecules/slide_preview.dart';
import '../modules/common/helpers/hooks.dart';
import '../modules/deck/deck_hooks.dart';
import '../modules/navigation/navigation_hooks.dart';

class PresentationScreen extends HookWidget {
  const PresentationScreen({super.key});

  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    final slideIndex = useCurrentSlideIndex();
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

    return PageView(
      controller: pageController,
      children: slides.mapIndexed((index, slide) {
        return SlideScreen(slideIndex: index);
      }).toList(),
    );
  }
}

class SlideScreen extends StatelessWidget {
  const SlideScreen({required this.slideIndex, super.key});

  final int slideIndex;

  @override
  Widget build(BuildContext context) {
    return SlidePreview(slideIndex);
  }
}
