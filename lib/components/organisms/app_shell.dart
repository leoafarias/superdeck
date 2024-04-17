import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals/signals_flutter.dart';

import '../../models/slide_model.dart';
import '../../providers/superdeck_controller.dart';
import '../../superdeck.dart';
import '../molecules/slide_preview.dart';
import '../molecules/split_view.dart';
import 'drawer.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final navigation = NavigationProvider();
  late final pageController = PageController(
    initialPage: navigation.currentSlide.value,
  );

  @override
  void dispose() {
    navigation.dispose();
    pageController.dispose();

    super.dispose();
  }

  Future<void> goToPage(int page) async {
    final slides = superDeck.slides;
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
    final slides = superDeck.slides.watch(context);

    navigation.currentSlide.listen(context, () {
      goToPage(navigation.currentSlide.value);
    });

    final isPreview = 0 == navigation.currentScreen.watch(context);

    final totalInvalid = slides.whereType<InvalidSlide>().length;

    final bindings = {
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
      ): navigation.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
      ): navigation.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.space,
      ): navigation.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
      ): navigation.previousSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
      ): navigation.previousSlide,
    };

    return CallbackShortcuts(
      bindings: bindings,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: navigation.toggleSide,
          child: Badge(
            label: Text(totalInvalid.toString()),
            isLabelVisible: totalInvalid != 0,
            child: const Icon(Icons.menu),
          ),
        ),
        key: _scaffoldKey,
        body: SplitView(
          isOpen: navigation.sideIsOpen.watch(context),
          side: SideDrawer(
            navigation: navigation,
          ),
          builder: (data) {
            return Padding(
              padding: EdgeInsets.only(left: data.sideWidth),
              child: PageView.builder(
                controller: pageController,
                itemCount: slides.length,
                itemBuilder: (context, idx) {
                  final slide = slides[idx];
                  return isPreview
                      ? SlidePreview(
                          slide: slide,
                          size: data.size,
                          sideWidth: data.sideWidth,
                        )
                      : SlideMarkdownPreview(
                          slide: slide,
                        );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
