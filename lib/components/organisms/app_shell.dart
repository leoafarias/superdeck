import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';

import '../../providers/superdeck_controller.dart';
import '../../superdeck.dart';
import '../molecules/slide_preview.dart';
import '../molecules/slide_thumbnail_list.dart';
import '../molecules/split_view.dart';

class AppShell extends HookWidget {
  AppShell({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final (:currentSlide, :menuSelection, :menuIsOpen) = deckState();
    final pageController = usePageController(initialPage: currentSlide.value);

    final slides = superDeck.slides.watch(context);

    final totalInvalid = superDeck.totalInvalid.watch(context);

    void toggleDrawer() {
      if (menuIsOpen.value) {
        menuSelection.value = 0;
      }
      menuIsOpen.value = !menuIsOpen.value;
    }

    Future<void> goToPage(int page, {bool animate = true}) async {
      if (page < 0 || page >= slides.length) return;

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

      currentSlide.value = page;
    }

    void onThumbnailSelected(int index) => goToPage(index, animate: false);

    void nextPage() => goToPage(pageController.page!.toInt() + 1);

    void previousPage() => goToPage(pageController.page!.toInt() - 1);
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
          onPressed: toggleDrawer,
          child: Badge(
            label: Text(totalInvalid.toString()),
            isLabelVisible: totalInvalid != 0,
            child: const Icon(Icons.menu),
          ),
        ),
        key: _scaffoldKey,
        body: SplitView(
          isOpen: menuIsOpen.watch(context),
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
                        selectedIndex: menuSelection.watch(context),
                        onDestinationSelected: (int idx) {
                          menuSelection.value = idx;
                        },
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
                          currentSlide: currentSlide.watch(context),
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
            final isPreview = 0 == menuSelection.watch(context);
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
