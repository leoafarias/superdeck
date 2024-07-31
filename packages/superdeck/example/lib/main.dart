import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

import 'src/style.dart';
import 'src/widget/mix_demo.dart';

void main() async {
  await SuperDeckApp.initialize();
  runApp(
    Builder(builder: (context) {
      return MaterialApp(
        title: 'Superdeck',
        debugShowCheckedModeBanner: false,
        home: SuperDeckApp(
          style: style,
          // ignore: prefer_const_literals_to_create_immutables
          examples: {'demo': mixExampleBuilder},
        ),
      );
    }),
  );
}
