import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

import 'src/style.dart';
import 'src/widget/mix_demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SuperDeckApp.initialize();
  runApp(
    Builder(builder: (context) {
      return MaterialApp(
        title: 'Superdeck',
        debugShowCheckedModeBanner: false,
        home: SuperDeckApp(
          styles: {
            'cover': CoverStyle(),
            'announcement': AnnouncementStyle(),
            'quote': QuoteStyle(),
            'show_sections': ShowSectionsStyle(),
          },
          // ignore: prefer_const_literals_to_create_immutables
          examples: {'demo': mixExampleBuilder},
        ),
      );
    }),
  );
}
