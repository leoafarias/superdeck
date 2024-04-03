import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watcher/watcher.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/constants.dart';
import '../../helpers/loader.dart';
import '../../helpers/local_storage.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../models/config_model.dart';
import '../../models/slide_asset_model.dart';
import '../../superdeck.dart';
import '../../theme.dart';
import 'scaled_app.dart';
import 'slide_view.dart';

class SuperDeckApp extends StatefulWidget {
  const SuperDeckApp({
    super.key,
    this.style,
    this.previewBuilders,
  });

  static Future<void> initialize() async {
    await _initialize();
  }

  final Style? style;
  final Map<String, PreviewWidgetBuilder>? previewBuilders;

  @override
  // ignore: library_private_types_in_public_api
  _SuperDeckAppState createState() => _SuperDeckAppState();
}

class _SuperDeckAppState extends State<SuperDeckApp> {
  late List<SlideOptions> _slides = [];
  late List<SlideAsset> _assets = [];
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

  Future<void> _loadData() async {
    try {
      await SuperDeckApp.initialize();
      if (kDebugMode) {
        await SlidesLoader().load();
        await _loadFromLocalStorage();
        _subscriptions = _registerLocalListener();
      } else {
        await _loadFromRootBundle();
      }
    } catch (e) {
      print('Error loading data: $e');
    } finally {
      _loading = false;
    }
  }

  StreamSubscription<WatchEvent> _createFileListener(
    File file,
    void Function(String) callback,
  ) {
    return FileWatcher(file.path).events.listen((event) async {
      if (event.type == ChangeType.MODIFY) {
        callback(await file.readAsString());
      }
    });
  }

  List<StreamSubscription<WatchEvent>> _registerLocalListener() {
    return [
      _createFileListener(config.slidesJsonFile, (contents) {
        setState(() {
          _slides = parseSlides(contents);
        });
      }),
      _createFileListener(config.assetsJsonFile, (contents) {
        setState(() {
          _assets = parseAssets(contents);
        });
      }),
      _createFileListener(config.slidesMarkdownFile, (contents) async {
        print('Reloading slides');
        await SlidesLoader().load();
      })
    ];
  }

  Future<void> _loadFromLocalStorage() async {
    final slidesJson = await config.slidesJsonFile.readAsString();
    final assetsJson = await config.assetsJsonFile.readAsString();

    setState(() {
      _slides = parseSlides(slidesJson);
      _assets = parseAssets(assetsJson);
    });
  }

  Future<void> _loadFromRootBundle() async {
    final slidesJson = await rootBundle.loadString(config.slidesJsonFile.path);
    final assetsJson = await rootBundle.loadString(config.assetsJsonFile.path);

    setState(() {
      _slides = parseSlides(slidesJson);
      _assets = parseAssets(assetsJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaledApp(builder: (context, _) {
      return MaterialApp(
        theme: darkTheme,
        home: MixTheme(
          data: MixThemeData.withMaterial(),
          child: Scaffold(
            body: SuperDeck(
              slides: _slides,
              assets: _assets,
              style: defaultStyle.merge(widget.style),
              previewBuilders: widget.previewBuilders ?? {},
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : const AppShell(),
            ),
          ),
        ),
      );
    });
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slides = SuperDeck.slidesOf(context);
    final style = SuperDeck.styleOf(context);

    void goToPage(int page) {
      if (page < 0 || page >= slides.length) return;
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    void nextPage() => goToPage(_currentPage + 1);

    void previousPage() => goToPage(_currentPage - 1);
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
      child: Pressable(
        onPress: () {},
        child: StyledWidgetBuilder(
            style: style.animate(),
            builder: (mix) {
              final spec = SlideSpec.of(mix);

              return AnimatedMixedBox(
                duration: mix.animation?.duration ?? const Duration(),
                spec: spec.outerContainer,
                child: PageView(
                  controller: _pageController,
                  children: slides.map(SlideView.new).toList(),
                ),
              );
            }),
      ),
    );
  }
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.initialize();
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
