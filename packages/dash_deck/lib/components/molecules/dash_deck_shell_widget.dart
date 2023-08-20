import 'package:dash_deck/components/atoms/slide_wrapper.dart';
import 'package:dash_deck/components/molecules/slide_view.dart';
import 'package:dash_deck/helpers/local_storage.dart';
import 'package:dash_deck/models/dash_deck_data_model.dart';
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
  }
}

class DashDeckApp extends StatelessWidget {
  const DashDeckApp({
    required this.data,
    Key? key,
  }) : super(key: key);

  final DashDeckData data;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: DashDeckShell(data: data),
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

    final lastPage = LocalStorage.getLastPage() ?? _initialPage;
    controller = PageController(initialPage: lastPage);
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
    LocalStorage.setLastPage(page);
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
              onPageChanged: _handleGoToSlide,
              children: widget.data.slides
                  .map(
                    (slide) => SlideView(slide),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
