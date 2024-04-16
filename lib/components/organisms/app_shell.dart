import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals/signals_flutter.dart';

import '../../models/slide_model.dart';
import '../../providers/superdeck_controller.dart';
import '../../superdeck.dart';
import '../molecules/slide_preview.dart';
import '../molecules/slide_thumbnail_list.dart';
import '../molecules/split_view.dart';

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

  Future<void> goToPage(int page, {bool animate = true}) async {
    final slides = superDeck.slides;
    if (page < 0 || page >= slides.value.length) return;

    const duration = Duration(milliseconds: 300);
    const curve = Curves.easeInOutCubic;

    if (animate) {
      pageController.animateToPage(
        page,
        duration: duration,
        curve: curve,
      );
    } else {
      pageController.jumpToPage(page);
    }

    navigation.goToSlide(page);
  }

  void onThumbnailSelected(int index) => goToPage(index, animate: false);

  void nextPage() => goToPage(pageController.page!.toInt() + 1);

  void previousPage() => goToPage(pageController.page!.toInt() - 1);

  @override
  Widget build(BuildContext context) {
    final slides = superDeck.slides.watch(context);

    final isPreview = 0 == navigation.currentScreen.watch(context);

    final totalInvalid = slides.whereType<InvalidSlide>().length;

    final bindings = {
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
      ): nextPage,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
      ): nextPage,
      const SingleActivator(
        LogicalKeyboardKey.space,
      ): nextPage,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
      ): previousPage,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
      ): previousPage,
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
          sideWidth: 380,
          side: Row(
            children: [
              Expanded(
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: false,
                    scrolledUnderElevation: 10,
                    elevation: 4,
                    toolbarHeight: 30,
                  ),
                  body: Row(
                    children: [
                      NavigationRail(
                        extended: false,
                        selectedIndex: navigation.currentScreen.watch(context),
                        onDestinationSelected: navigation.goToScreen,
                        trailing: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Add your leading widget here
                              // For example:
                              Text(
                                'SD',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.white.withOpacity(0.2),
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 20)
                            ],
                          ),
                        ),
                        labelType: NavigationRailLabelType.none,
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(
                              Icons.play_arrow,
                              size: 20,
                            ),
                            label: Text('Debug'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(
                              Icons.code,
                              size: 20,
                            ),
                            label: Text('Save pdf'),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SlideThumbnailList(
                          currentSlide: navigation.currentSlide(),
                          onSelect: onThumbnailSelected,
                          slides: slides,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
                          key: ValueKey(slide),
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
