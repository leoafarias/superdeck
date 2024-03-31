import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/constants.dart';
import '../../helpers/local_storage.dart';
import '../../helpers/service_locator.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../superdeck.dart';
import '../../theme.dart';
import 'scaled_app.dart';
import 'slide_view.dart';

class SuperDeck extends StatelessWidget {
  const SuperDeck({super.key, this.styleBuilder});

  final Style Function()? styleBuilder;

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

  @override
  Widget build(BuildContext context) {
    return ScaledApp(
      builder: (context, scale) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: darkTheme,
          home: DeckStyle(
            style: defaultStyle.merge(styleBuilder?.call()),
            child: Watch((context) {
              return superdeck.isLoading()
                  ? const Center(child: CircularProgressIndicator())
                  : const AppShell();
            }),
          ),
        );
      },
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    superdeck.currentPage.listen(context, () {
      _pageController.animateToPage(
        superdeck.currentPage(),
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    });

    final slides = superdeck.slides.watch(context);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(
          LogicalKeyboardKey.arrowRight,
        ): superdeck.nextPage,
        const SingleActivator(
          LogicalKeyboardKey.arrowDown,
        ): superdeck.nextPage,
        const SingleActivator(
          LogicalKeyboardKey.space,
        ): superdeck.nextPage,
        const SingleActivator(
          LogicalKeyboardKey.arrowLeft,
        ): superdeck.previousPage,
        const SingleActivator(
          LogicalKeyboardKey.arrowUp,
        ): superdeck.previousPage,
      },
      child: Watch((context) {
        final style = DeckStyle.of(context);

        return Pressable(
          onPress: () {},
          child: StyledWidgetBuilder(
              style: style.animate(),
              builder: (mix) {
                final spec = SlideSpec.of(mix);

                return BoxSpecWidget(
                  spec: spec.outerContainer,
                  child: PageView(
                    controller: _pageController,
                    children: slides.map(SlideView.new).toList(),
                  ),
                );
              }),
        );
      }),
    );
  }
}
