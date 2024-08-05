import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/molecules/slide_preview.dart';
import '../components/molecules/split_view.dart';
import '../superdeck.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentSlide = useCurrentSlide();
    final pageController = usePageController(initialPage: currentSlide);
    final slides = useSlides();

    useOnSlideChange((value) async {
      const duration = Duration(milliseconds: 300);
      const curve = Curves.easeInOutCubic;
      final currentPage = pageController.page?.toInt() ?? 0;

      // Return if already paged
      if (currentPage == value) return;

      // Check if the current Page is more than 1 page away
      final isFarAway = (currentPage - value).abs() > 1;

      if (isFarAway) {
        pageController.jumpToPage(value);
      } else {
        await pageController.animateToPage(
          value,
          duration: duration,
          curve: curve,
        );
      }
    });

    return SplitView(
      child: Container(
        alignment: Alignment.center,
        child: PageView.builder(
          controller: pageController,
          itemCount: slides.length,
          itemBuilder: (context, idx) {
            final slide = slides[idx];
            return SlidePreview(slide);
          },
        ),
      ),
    );
  }
}
