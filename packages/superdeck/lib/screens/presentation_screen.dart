import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/molecules/slide_preview.dart';
import '../helpers/hooks.dart';
import '../superdeck.dart';

class PresentationScreen extends HookWidget {
  const PresentationScreen({super.key, this.slideIndex = 0});

  final int slideIndex;
  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(initialPage: slideIndex);
    final slides = useSlides();

    usePostFrameEffect(() {
      if (slideIndex >= slides.length) {
        return;
      }

      if (slideIndex < 0) {
        return;
      }
      pageController.animateToPage(slideIndex,
          duration: _duration, curve: _curve);
    }, [slideIndex, slides.length]);

    // useEffect(() {
    //   // Subscribe to route changes
    //   GoRouter.of(context).routerDelegate.addListener(() {
    //     final currentRoute =
    //         GoRouter.of(context).routeInformationProvider.value.uri.toString();
    //     // Check if the route matches /slides/:index
    //     final match = RegExp(r'/slides/(\d+)').firstMatch(currentRoute);
    //     if (match != null) {
    //       final index = int.parse(match.group(1)!);
    //       // Check if the PageView needs to be updated
    //       if (pageController.page?.toInt() != index) {
    //         pageController.animateToPage(
    //           index,
    //           duration: _duration,
    //           curve: _curve,
    //         );
    //       }
    //     }
    //   });
    // }, []);

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
