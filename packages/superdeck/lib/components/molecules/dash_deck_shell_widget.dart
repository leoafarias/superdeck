import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:superdeck/components/atoms/slide_wrapper.dart';
import 'package:superdeck/components/molecules/slide_view.dart';
import 'package:superdeck/helpers/local_storage.dart';
import 'package:superdeck/helpers/syntax_highlighter.dart';
import 'package:superdeck/providers/superdeck_provider.dart';
import 'package:superdeck/theme.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:window_manager/window_manager.dart';

class DashDeck {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

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
    await DDSyntaxHighlight.initialize();
  }

  static Widget runAppWithoutScope() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      home: const DashDeckListenerApp(),
    );
  }

  static Widget runApp() {
    return ProviderScope(
      child: runAppWithoutScope(),
    );
  }
}

class DashDeckListenerApp extends ConsumerWidget {
  const DashDeckListenerApp({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final deck = ref.watch(deckControllerProvider);
    return deck.when(
      data: (data) {
        return DashDeckShell(data: data);
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}

class DashDeckShell extends HookConsumerWidget {
  const DashDeckShell({
    required this.data,
    Key? key,
  }) : super(key: key);

  final DashDeckData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();

    void handleGoToSlide(int page) {
      ref.read(slidePageProvider.notifier).setActivePage(page);
      controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    void handleStepSlide(int slide) {
      final currentPage = controller.page?.round() ?? 0;
      int stepToPage = currentPage + slide;

      if (stepToPage >= 0 && stepToPage < data.slides.length) {
        handleGoToSlide(stepToPage);
      } else if (stepToPage == -1) {
        handleGoToSlide(data.slides.length - 1);
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
              controller: controller,
              children: data.slides.map(SlideView.new).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
