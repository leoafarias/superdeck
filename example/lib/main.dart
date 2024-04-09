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
    $.code.span.fontSize(14),
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
            Example.simple(
              name: 'demo',
              builder: (args) {
                final options = ExampleOptions.fromMap(args);
                return Container(
                  height: options.height,
                  width: options.width,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      options.text ?? 'No text',
                    ),
                  ),
                );
              },
            ),
            // // ignore: prefer_const_constructors
            // Example.withDecoder(
            //   name: 'demo',
            //   decoder: ExampleOptions.fromMap,
            //   schema: ExampleOptions.schema,
            //   builder: (args) {
            //     return Container(
            //       height: args.height,
            //       width: args.width,
            //       color: Colors.purple,
            //       child: Center(
            //         child: Text(
            //           args.text ?? 'No text',
            //         ),
            //       ),
            //     );
            //   },
            // )
          ],
        ),
      );
    }),
  );
}
