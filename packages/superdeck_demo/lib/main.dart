import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:superdeck/components/atoms/slide_wrapper.dart';
import 'package:superdeck/superdeck.dart';

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

    return Scaffold(
      key: scaffoldKey,
      body: SlideWrapper(
        child: DashDeck.runApp(),
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
