import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

void main() async {
  await SuperDeck.initialize();
  runApp(SuperDeck.runApp());
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
      body: SuperDeck.runApp(),
    );
  }
}
