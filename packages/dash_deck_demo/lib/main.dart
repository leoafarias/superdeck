import 'package:dash_deck/dash_deck.dart';
import 'package:dash_deck_demo/dash_deck/generated/slides.g.dart';
import 'package:flutter/material.dart';

void main() async {
  await DashDeck.initialize();
  runApp(const DashDeckApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dash Deck',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ReloadOnChange(
        directoryPath: 'lib/dash_deck',
        child: DashDeckApp(),
      ),
    );
  }
}
