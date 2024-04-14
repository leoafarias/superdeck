import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:watcher/watcher.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/constants.dart';
import '../../helpers/loader.dart';
import '../../helpers/preference_storage.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../models/asset_model.dart';
import '../../models/options_model.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../helpers/config.dart';
import '../helpers/theme.dart';

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

  Future<void> _loadData() async {
    try {
      await SuperDeckApp.initialize();

      final (slides, assets) = await SlidesLoader.loadFromStorage();

      setState(() {
        _slides = slides;
        _assets = assets;
      });
      if (kDebugMode && !kIsWeb) {
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

  List<StreamSubscription<WatchEvent>> _registerLocalListener() {
    return [
      kConfig.slidesMarkdownFile,
      kConfig.projectConfigFile,
    ].map((file) {
      return FileWatcher(file.path).events.listen((event) async {
        if (event.type == ChangeType.MODIFY) {
          print('Reloading slides');
          final (slides, assets) = await SlidesLoader.load();
          _setSlides(slides);
          _setAssets(assets);
        }
      });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final exampleBuilders =
        widget.examples.fold({}.cast<String, Example>(), (acc, builder) {
      acc[builder.name] = builder;
      return acc;
    });
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: MixTheme(
        data: MixThemeData.withMaterial(),
        child: Scaffold(
          body: SuperDeck(
            slides: _slides,
            assets: _assets,
            style: defaultStyle.merge(widget.style),

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
