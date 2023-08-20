import 'package:dash_deck/dash_deck.dart';
import 'package:flutter/material.dart';

void main() async {
  await DashDeck.initialize();
  runApp(DashDeck.runApp());
}
