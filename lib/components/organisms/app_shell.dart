import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/preference_storage.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../molecules/slide_preview.dart';
import '../molecules/slide_thumbnail_list.dart';
import '../molecules/split_view.dart';

enum MenuSelection {
  play,
  markdown,
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final initialPage = PreferenceStorage.instance.lastPage ?? 0;
  late final _pageController = PageController(
    initialPage: initialPage,
  );

  final _sideIsOpen = signal(false);
  late final _currentSlide = signal(initialPage);
  final _menuIndex = signal(0);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void dispose() {
    _pageController.dispose();
    _sideIsOpen.dispose();
    _currentSlide.dispose();

    super.dispose();
  }

  Future<void> _isPaging = Future.value();

  @override
  Widget build(BuildContext context) {
    final slides = SuperDeck.slidesOf(context);

    final totalInvalidSlides = slides.whereType<InvalidSlide>().length;

    final selectedMenu = MenuSelection.values[_menuIndex.watch(context)];

    Future<void> goToPage(int page, {bool animate = true}) async {
      if (page < 0 || page >= slides.length) return;
      await _isPaging;

      const duration = Duration(milliseconds: 300);
      const curve = Curves.easeInOutCubic;

      if (animate) {
        _isPaging = _pageController.animateToPage(
          page,
          duration: duration,
          curve: curve,
        );
      } else {
        _pageController.jumpToPage(page);
      }

      _currentSlide.value = page;

      await PreferenceStorage.instance.setLastPage(page);
    }

    void onThumbnailSelected(int index) => goToPage(index, animate: false);

    void nextPage() => goToPage(_pageController.page!.toInt() + 1);

    void previousPage() => goToPage(_pageController.page!.toInt() - 1);
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

    Widget bodyWidget() {
      return switch (selectedMenu) {
        MenuSelection.play => SlidePreview(
            slides: slides,
            controller: _pageController,
          ),
        MenuSelection.markdown => SlideMarkdownPreview(
            slides: slides,
            controller: _pageController,
          ),
      };
    }

    return CallbackShortcuts(
      bindings: bindings,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _sideIsOpen.value = !_sideIsOpen.value;
          },
          child: Badge(
            label: Text(totalInvalidSlides.toString()),
            isLabelVisible: totalInvalidSlides != 0,
            child: const Icon(Icons.menu),
          ),
        ),
        key: _scaffoldKey,
        body: SplitView(
            isOpen: _sideIsOpen.watch(context),
            sideWidth: 380,
            side: Row(
              children: [
                Expanded(
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text('SD'),
                      scrolledUnderElevation: 10,
                      elevation: 4,
                    ),
                    body: Row(
                      children: [
                        NavigationRail(
                          extended: false,
                          selectedIndex: _menuIndex.watch(context),
                          onDestinationSelected: (int idx) {
                            _menuIndex.value = idx;
                          },
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
                            currentSlide: _currentSlide.watch(context),
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
            body: bodyWidget()),
      ),
    );
  }
}
