import 'package:dash_deck/components/atoms/slide_wrapper.dart';
import 'package:dash_deck/dash_deck.dart';
import 'package:dash_deck_demo/chat/chat.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await DashDeck.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DashDeck App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const App(),
    );
  }
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class App extends HookWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    final isDrawerOpen = useState<bool>(false);

    final width = MediaQuery.of(context).size.width;

    final bodyWidth = isDrawerOpen.value ? width * 0.75 : width;

    final chatWidth = width * 0.25;
    const duration = Duration(milliseconds: 300);

    return Scaffold(
      key: scaffoldKey,
      body: SlideWrapper(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: duration,
              width: bodyWidth,
              child: const DashDeckListenerApp(),
            ),
            AnimatedPositioned(
              duration: duration,
              curve: Curves.easeInOut,
              right: isDrawerOpen.value ? 0 : -chatWidth,
              top: 0,
              bottom: 0,
              width: chatWidth,
              child: const ChatScreen(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton.small(
          onPressed: () {
            isDrawerOpen.value = !isDrawerOpen.value;
          },
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }
}
