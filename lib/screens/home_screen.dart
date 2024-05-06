import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../components/molecules/slide_preview.dart';
import '../components/molecules/split_view.dart';
import '../superdeck.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController pageController;
  final superdeck = SDController.instance;
  final navigation = NavigationProvider.instance;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: navigation.currentSlide.value);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> goToPage(int page) async {
    final slides = superdeck.slides;
    if (page < 0 || page >= slides.value.length) return;

    const duration = Duration(milliseconds: 300);
    const curve = Curves.easeInOutCubic;

    // Return if already paged
    if (pageController.page == page) return;

    if (page != navigation.currentSlide.value) {
      await pageController.animateToPage(
        page,
        duration: duration,
        curve: curve,
      );

      navigation.currentSlide.value = page;
    } else {
      pageController.jumpToPage(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    final slides = superdeck.slides.watch(context);

    navigation.currentSlide.listen(context, () {
      goToPage(navigation.currentSlide.value);
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
