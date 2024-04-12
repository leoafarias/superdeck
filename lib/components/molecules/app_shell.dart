import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:signals/signals_flutter.dart';
import 'package:watcher/watcher.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/constants.dart';
import '../../helpers/loader.dart';
import '../../helpers/preference_storage.dart';
import '../../helpers/schema/schema.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../models/asset_model.dart';
import '../../models/options_model.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../../theme.dart';
import '../atoms/slide_thumbnail.dart';
import 'scaled_app.dart';
import 'slide_view.dart';
import 'split_view.dart';

class SuperDeckApp extends StatefulWidget {
  const SuperDeckApp({
    super.key,
    this.style,
    this.examples = const [],
  });

  static Future<void> initialize() async {
    await _initialize();
  }

  final Style? style;
  final List<Example> examples;

  @override
  // ignore: library_private_types_in_public_api
  _SuperDeckAppState createState() => _SuperDeckAppState();
}

class _SuperDeckAppState extends State<SuperDeckApp> {
  late List<Slide> _slides = [];
  late List<SlideAsset> _assets = [];
  late Config _config = const Config.empty();
  Slide? _errorSlide;
  bool _loading = true;

  List<StreamSubscription<WatchEvent>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  void dispose() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    super.dispose();
  }

  void _setSlides(List<Slide> slides) {
    // only update state if slide optinos are different
    if (!listEquals(slides, _slides)) {
      setState(() {
        _slides = slides;
      });
    }
  }

  void _setAssets(List<SlideAsset> assets) {
    // only update state if assets are different
    if (!listEquals(assets, _assets)) {
      setState(() {
        _assets = assets;
      });
    }
  }

  void _setProjectConfig(Config projectOptions) {
    // only update state if project options are different
    if (projectOptions != _config) {
      setState(() {
        _config = projectOptions;
      });
    }
  }

  Future<void> _loadData() async {
    try {
      await SuperDeckApp.initialize();

      final project = await _loadProjectConfig();
      final (slides, assets) = await SlidesLoader.loadFromStorage();

      setState(() {
        _slides = slides;
        _assets = assets;
        _config = project;
      });
      if (kDebugMode) {
        _subscriptions = _registerLocalListener();
      }
    } catch (e) {
      print('Error loading slides: $e');
      rethrow;
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<Config> _loadProjectConfig() async {
    try {
      final project = await SlidesLoader.loadProjectConfig();
      _errorSlide = null;
      return project;
    } on SchemaValidationException catch (e) {
      _errorSlide = InvalidSlide.projectSchemaError(e.result);

      return const Config.empty();
    } on Exception catch (e) {
      _errorSlide = InvalidSlide.exception(e);

      return const Config.empty();
    }
  }

  StreamSubscription<WatchEvent> _createFileListener(
    File file,
    void Function() callback,
  ) {
    return FileWatcher(file.path).events.listen((event) async {
      if (event.type == ChangeType.MODIFY) {
        callback();
      }
    });
  }

  List<StreamSubscription<WatchEvent>> _registerLocalListener() {
    return [
      _createFileListener(config.slidesMarkdownFile, () async {
        print('Reloading slides');
        final (slides, assets) = await SlidesLoader.load();
        _setSlides(slides);
        _setAssets(assets);
      }),
      _createFileListener(config.projectConfigFile, () async {
        print('Reloading project config');
        _setProjectConfig(await _loadProjectConfig());
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    final slides = _errorSlide != null ? [_errorSlide!] : _slides;
    final exampleBuilders =
        widget.examples.fold({}.cast<String, Example>(), (acc, builder) {
      acc[builder.name] = builder;
      return acc;
    });
    return MaterialApp(
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: MixTheme(
        data: MixThemeData.withMaterial(),
        child: Scaffold(
          body: SuperDeck(
            slides: slides,
            assets: _assets,
            style: defaultStyle.merge(widget.style),
            projectOptions: _config,
            //  Convert a List<WidgetDemo> to a Map<String, WidgetDemo>
            // where the key of the map is the widgetDemo.name
            widgetExamples: exampleBuilders,
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : const AppShell(),
          ),
        ),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _pageController = PageController(
    initialPage: PreferenceStorage.instance.lastPage ?? 0,
  );
  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();
  final _sideIsOpen = signal(false);
  final _currentSlide = signal(0);
  var _visibleItems = <ItemPosition>[];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(() {
      _visibleItems = _itemPositionsListener.itemPositions.value.toList();
    });
  }

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

      final visibleItem =
          _visibleItems.firstWhereOrNull((e) => e.index == page);

      double alignment;

      if (visibleItem == null) {
        final isBeginning = _visibleItems.first.index > page;

        alignment = isBeginning ? 0 : 0.75;
      } else {
        if (visibleItem.itemTrailingEdge > 1) {
          final totalSpace =
              visibleItem.itemTrailingEdge - visibleItem.itemLeadingEdge;
          alignment = 1 - totalSpace;
        } else if (visibleItem.itemLeadingEdge < 0) {
          alignment = 0;
        } else {
          alignment = visibleItem.itemLeadingEdge;
        }
      }
      _itemScrollController.scrollTo(
        index: page,
        alignment: alignment,
        duration: duration,
        curve: curve,
      );

      _currentSlide.value = page;

      await PreferenceStorage.instance.setLastPage(page);
    }

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
          sideWidth: 300,
          side: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 60,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 19, 19, 19),
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 43, 43, 43),
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Slides'),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 20, 20, 20),
                  child: ScrollablePositionedList.builder(
                      itemCount: slides.length,
                      itemPositionsListener: _itemPositionsListener,
                      itemScrollController: _itemScrollController,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, idx) {
                        return Watch.builder(builder: (context) {
                          return Center(
                            child: SlideThumbnail(
                              slide: slides[idx],
                              selected: idx == _currentSlide.value,
                              onTap: () {
                                goToPage(idx, animate: false);
                              },
                            ),
                          );
                        });
                      }),
                ),
              ),
            ],
          ),
          body: ScaledWidget(
            child: PageView.builder(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              itemCount: slides.length,
              itemBuilder: (context, index) {
                final slide = slides[index];
                return SlideView(slide);
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceStorage.initialize();
  await SyntaxHighlight.initialize();

  // Return if its web
  if (kIsWeb) return;
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: kResolution,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    minimumSize: Size(640, 360),
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await windowManager.setAspectRatio(kAspectRatio);
}
