import 'package:dash_deck/components/atoms/slide_wrapper.dart';
import 'package:dash_deck/components/molecules/slide_view.dart';
import 'package:dash_deck/helpers/local_storage.dart';
import 'package:dash_deck/helpers/syntax_highlighter.dart';
import 'package:dash_deck/providers/dash_deck.provider.dart';
import 'package:dash_deck/theme.dart';
import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  static Widget runApp() {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const DashDeckListenerApp(),
      ),
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

class DashDeckShell extends StatefulWidget {
  const DashDeckShell({
    required this.data,
    Key? key,
  }) : super(key: key);

  final DashDeckData data;

  @override
  State<DashDeckShell> createState() => _DashDeckShellState();
}

class _DashDeckShellState extends State<DashDeckShell> {
  final int _initialPage = 0;
  PageController? controller;

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _handleGoToSlide(int page) {
    controller?.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handleStepSlide(int slide) {
    final currentPage = controller?.page?.round() ?? 0;
    final stepToPage = currentPage + slide;
    if (stepToPage >= 0 && stepToPage < widget.data.slides.length) {
      _handleGoToSlide(stepToPage);
    } else if (stepToPage == -1) {
      _handleGoToSlide(widget.data.slides.length);
    } else {
      _handleGoToSlide(0);
    }
  }

  void _handleNextSlide() {
    _handleStepSlide(1);
  }

  void _handlePreviousSlide() {
    _handleStepSlide(-1);
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(
          LogicalKeyboardKey.arrowRight,
          includeRepeats: false,
        ): _handleNextSlide,
        const SingleActivator(
          LogicalKeyboardKey.arrowDown,
          includeRepeats: false,
        ): _handleNextSlide,
        const SingleActivator(
          LogicalKeyboardKey.space,
          includeRepeats: false,
        ): _handleNextSlide,
        const SingleActivator(
          LogicalKeyboardKey.enter,
          includeRepeats: false,
        ): _handleNextSlide,
        const SingleActivator(
          LogicalKeyboardKey.numpadEnter,
          includeRepeats: false,
        ): _handleNextSlide,
        const SingleActivator(
          LogicalKeyboardKey.arrowLeft,
          includeRepeats: false,
        ): _handlePreviousSlide,
        const SingleActivator(
          LogicalKeyboardKey.arrowUp,
          includeRepeats: false,
        ): _handlePreviousSlide,
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          body: SlideWrapper(
            child: PageView(
              controller: controller,
              children: widget.data.slides.map(SlideView.new).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
