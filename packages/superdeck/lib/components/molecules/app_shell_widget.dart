import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/constants.dart';
import '../../helpers/local_storage.dart';
import '../../helpers/service_locator.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../helpers/use_signals.dart';
import '../../models/deck_data_model.dart';
import '../../superdeck.dart';
import '../../theme.dart';
import 'scaled_app.dart';
import 'slide_view.dart';

class SuperDeck {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    setupLocator();

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

  static Future<void> run({SlideStyle? style}) async {
    SuperDeck.initialize();
    styles.load(style);

    return runApp(ScaledApp(
      builder: (context, scale) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: darkTheme,
          home: Watch((context) {
            if (deckController.isLoading()) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return AppShell(data: deckController.data());
          }),
        );
      },
    ));
  }
}

class AppShell extends StatefulWidget {
  const AppShell({required this.data, super.key});

  final DeckData data;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
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
        deckController.goToPage(page);
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

      final style = styles.get(null);

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
        child: PressableBox(
          style: style.outerContainer.animate(),
          child: PageView(
            controller: _pageController.value,
            children: widget.data.slides.map((config) {
              return PressableBox(
                style: style.innerContainer.animate(),
                child: SlideView(config),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
