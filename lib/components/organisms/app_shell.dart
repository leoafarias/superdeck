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

    void toggleDrawer() {
      if (_sideIsOpen.value) {
        _menuIndex.value = MenuSelection.play.index;
      }
      _sideIsOpen.value = !_sideIsOpen.value;
    }

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

    return CallbackShortcuts(
      bindings: bindings,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: toggleDrawer,
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
                    centerTitle: false,
                    leading: const Spacer(),
                    actions: const [],
                    scrolledUnderElevation: 10,
                    elevation: 4,
                    toolbarHeight: 30,
                  ),
                  body: Row(
                    children: [
                      NavigationRail(
                        extended: false,
                        selectedIndex: _menuIndex.watch(context),
                        onDestinationSelected: (int idx) {
                          _menuIndex.value = idx;
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
          builder: (data) {
            return Padding(
              padding: EdgeInsets.only(left: data.sideWidth),
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                itemBuilder: (context, idx) {
                  final slide = slides[idx];
                  if (MenuSelection.play.index == _menuIndex.watch(context)) {
                    return SlidePreview(
                      slide: slide,
                      size: data.size,
                      sideWidth: data.sideWidth,
                    );
                  } else {
                    return SlideMarkdownPreview(slide: slide);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
