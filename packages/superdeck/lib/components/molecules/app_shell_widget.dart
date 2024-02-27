import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/local_storage.dart';
import '../../helpers/service_locator.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../helpers/use_signals.dart';
import '../../models/deck_data_model.dart';
import '../../providers/superdeck_provider.dart';
import '../../theme.dart';
import '../atoms/slide_wrapper.dart';
import 'slide_view.dart';

class SuperDeck {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    setupLocator();

    // Return if its web
    if (kIsWeb) return;
    // Must add this line.
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720),
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

    await windowManager.setAspectRatio(16 / 9);

    await LocalStorage.initialize();
    await SyntaxHighlight.initialize();
  }

  static Widget runApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      home: const SuperDeckListenerApp(),
    );
  }
}

class SuperDeckListenerApp extends StatelessWidget {
  const SuperDeckListenerApp({super.key});

  @override
  Widget build(context) {
    return Watch((context) {
      if (sdeck.isLoading()) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return SuperDeckShell(data: sdeck.data());
    });
  }
}

class SuperDeckShell extends StatefulWidget {
  const SuperDeckShell({required this.data, super.key});

  final DeckData data;

  @override
  State<SuperDeckShell> createState() => _SuperDeckShellState();
}

class _SuperDeckShellState extends State<SuperDeckShell> {
  final _pageController = createPageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      void handleGoToSlide(int page) {
        sdeck.goToPage(page);
        _pageController().animateToPage(
          page,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }

      void handleStepSlide(int slide) {
        final currentPage = _pageController.value.page?.round() ?? 0;
        int stepToPage = currentPage + slide;

        if (stepToPage >= 0 && stepToPage < widget.data.slides.length) {
          handleGoToSlide(stepToPage);
        } else if (stepToPage == -1) {
          handleGoToSlide(widget.data.slides.length - 1);
        } else {
          handleGoToSlide(0);
        }
      }

      void handleNextSlide() {
        handleStepSlide(1);
      }

      void handlePreviousSlide() {
        handleStepSlide(-1);
      }

      return CallbackShortcuts(
        bindings: {
          const SingleActivator(
            LogicalKeyboardKey.arrowRight,
            includeRepeats: false,
          ): handleNextSlide,
          const SingleActivator(
            LogicalKeyboardKey.arrowDown,
            includeRepeats: false,
          ): handleNextSlide,
          const SingleActivator(
            LogicalKeyboardKey.space,
            includeRepeats: false,
          ): handleNextSlide,
          const SingleActivator(
            LogicalKeyboardKey.enter,
            includeRepeats: false,
          ): handleNextSlide,
          const SingleActivator(
            LogicalKeyboardKey.numpadEnter,
            includeRepeats: false,
          ): handleNextSlide,
          const SingleActivator(
            LogicalKeyboardKey.arrowLeft,
            includeRepeats: false,
          ): handlePreviousSlide,
          const SingleActivator(
            LogicalKeyboardKey.arrowUp,
            includeRepeats: false,
          ): handlePreviousSlide,
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            body: SlideWrapper(
              child: PageView(
                controller: _pageController.value,
                children: widget.data.slides.map(SlideView.new).toList(),
              ),
            ),
          ),
        ),
      );
    });
  }
}
