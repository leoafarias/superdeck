import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/molecules/slide_preview.dart';
import '../components/molecules/split_view.dart';
import '../helpers/hooks.dart';
import '../superdeck.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    final page = useNavigationSelector((c) => c.page);

    final pageController = usePageController(initialPage: page);
    final slides = useSlides();

    useUpdateEffect(() {
      pageController.animateToPage(
        page,
        duration: _duration,
        curve: _curve,
      );
    }, [page]);

    return SplitView(
      child: Center(
        child: PageView.builder(
          controller: pageController,
          itemCount: slides.length,
          itemBuilder: (_, index) {
            return SlidePreview(slides[index]);
          },
        ),
      ),
    );
  }
}
