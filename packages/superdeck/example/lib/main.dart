import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

import 'src/style.dart';
import 'src/widget/mix_demo.dart';

class HeaderPart extends SlidePart {
  const HeaderPart({
    super.key,
  });

  @override
  double get height => 40;

  @override
  Widget build(SlideConfiguration configuration) {
    final slide = configuration.slide;
    final index = configuration.slideIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(slide.options?.title ?? 'Generative UIs'),
          Text('${index + 1}'),
        ],
      ),
    );
  }
}

class FooterPart extends SlidePart {
  const FooterPart({
    super.key,
  });

  @override
  double get height => 40;

  @override
  Widget build(SlideConfiguration configuration) {
    // final slides = configuration.controller.slides;
    // final index = configuration.slideIndex;

    // final progress = (index + 1) / slides.length;

    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('SUPERDECK'),
        ],
      ),
    );
  }
}

void main() async {
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
          header: const HeaderPart(),
          footer: const FooterPart(),
          // ignore: prefer_const_literals_to_create_immutables
          examples: {'demo': mixExampleBuilder},
        ),
      );
    }),
  );
}
