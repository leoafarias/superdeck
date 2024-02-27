import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:superdeck/components/atoms/slide_wrapper.dart';
import 'package:superdeck/superdeck.dart';

void main() async {
  await SuperDeck.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperDeck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const App(),
    );
  }
}

final scaffoldKey = GlobalKey<ScaffoldState>();

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SlideWrapper(
        child: SuperDeck.runApp(),
      ),
    );
  }
}
