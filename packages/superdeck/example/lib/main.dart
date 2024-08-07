import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:superdeck/superdeck.dart';

import 'src/style.dart';
import 'src/widget/mix_demo.dart';

void main() async {
  debugRepaintRainbowEnabled = true;
  await SuperDeckApp.initialize();
  runApp(
    Builder(builder: (context) {
      return MaterialApp(
        title: 'Superdeck',
        debugShowCheckedModeBanner: false,
        home: SuperDeckApp(
          styles: {
            'rad': radStyle,
            'custom': customStyle,
            'cover': coverStyle,
            'announcement': announcementStyle,
            'quote': quoteStyle,
            'show_sections': showSectionsStyle,
          },
          // ignore: prefer_const_literals_to_create_immutables
          examples: {'demo': mixExampleBuilder},
        ),
      );
    }),
  );
}
