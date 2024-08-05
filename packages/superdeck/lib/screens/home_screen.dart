import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/molecules/slide_preview.dart';
import '../components/molecules/split_view.dart';
import '../helpers/hooks.dart';
import '../superdeck.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigation = useNavigation();
    final currentSlide = navigation.currentSlide;
    final pageController = usePageController(initialPage: currentSlide);
    final slides = useSlides();

    useLayoutEffect(() {
      const duration = Duration(milliseconds: 300);
      const curve = Curves.easeInOutCubic;
      final currentPage = pageController.page?.toInt() ?? 0;

      // Return if already paged
      if (currentPage == currentSlide) return;

      // // Check if the current Page is more than 1 page away
      // final isFarAway = (currentPage - currentSlide).abs() > 1;

      // if (isFarAway) {
      //   //  fire this after layout

      //   pageController.jumpToPage(currentSlide);
      // } else {
      // }
      pageController.animateToPage(
        currentSlide,
        duration: duration,
        curve: curve,
      );

      return;
    }, [currentSlide]);

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
