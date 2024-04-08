import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superdeck/models/options_model.dart';
import 'package:superdeck/superdeck.dart';
import 'package:superdeck_demo/src/widget/mix_demo.dart';

VariantAttribute get coverStyle {
  return SlideVariant.cover(
    $.h1.textStyle.fontSize(96),
    $.h1.textStyle.fontWeight.bold(),

    // $.paragraph.padding.right(300),

    $.innerContainer.borderRadius.all(0),
    $.innerContainer.gradient.linear(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.9)],
    ),
  );
}

VariantAttribute get demoStyle {
  return const SlideVariant('demo')(
    $.h1.textStyle.fontSize(56),
    $.h1.textStyle.fontWeight.bold(),
    $.innerContainer.gradient.linear(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.purple.withOpacity(0.1), Colors.purple.withOpacity(0.3)],
    ),
  );
}

VariantAttribute get quoteStyle {
  return SlideVariant.quote(
    $.blockquote.textStyle.as(GoogleFonts.notoSerif()),
    $.blockquote.decoration.border.left(
      width: 4,
      color: Colors.red,
    ),
    $.paragraph.textStyle.fontSize(32),
    $.h6.textStyle.as(GoogleFonts.notoSerif()),
    $.h6.textStyle.fontSize(20),
  );
}

Style get style {
  return Style(
    coverStyle,
    quoteStyle,
    demoStyle,

    // $.contentContainer.border(color: Colors.blue),
  );
}

void main() async {
  runApp(
    Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SuperDeckApp(
          style: style,
          // ignore: prefer_const_literals_to_create_immutables
          examples: [
            // ignore: prefer_const_constructors
            Example.withDecoder(
              name: 'demo',
              decoder: ExampleOptions.fromMap,
              schema: ExampleOptions.schema,
              builder: (args) {
                return Container(
                  color: Colors.purple,
                  child: const Center(
                    child: Text('Hello World'),
                  ),
                );
              },
            )
          ],
        ),
      );
    }),
  );
}
