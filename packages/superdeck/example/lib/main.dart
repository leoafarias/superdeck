import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

VariantAttribute get coverStyle {
  return SlideVariant.cover(
    $.h1.textStyle.fontSize(96),
    $.h1.textStyle.fontWeight.bold(),
    $.paragraph.padding.right(300),
    $.paragraph.textStyle.fontSize(36),
    $.paragraph.textStyle.fontWeight.w100(),
    $.innerContainer.borderRadius.all(0),
    $.innerContainer.gradient.linear(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.9)],
    ),
  );
}

Style get style {
  return Style(
    // $.textStyle.as(GoogleFonts.poppins()),
    // $.code.textStyle.as(GoogleFonts.jetBrainsMono()),
    coverStyle,

    $.h1.textStyle.color.red(),
    $.contentContainer.border(color: Colors.red),
  );
}

Map<String, PreviewWidgetBuilder> get previewBuilders => {
      'slide': PreviewWidgetBuilder(
        builder: (context, options) {
          final heightValue = options.args['height'] ?? 100.0;
          final widthValue = options.args['width'] ?? 100.0;
          final textValue = options.args['title'] as String? ?? 'Custom Widget';
          final style = Style(
            width(widthValue),
            height(heightValue),
            margin.vertical(10),
            box.alignment.center(),
            elevation(2),
            borderRadius(10),
            backgroundColor($md.colorScheme.primary()),
            text.style.color($md.colorScheme.onPrimary()),
            onHover(
              elevation(4),
              padding(20),
              width(150),
              backgroundColor($md.colorScheme.secondary()),
              text.style(color: $md.colorScheme.onSecondary()),
            ),
          );
          return PressableBox(
            style: style.animate(),
            onPress: () {},
            child: StyledText(textValue),
          );
        },
      ),
      'markdown': PreviewWidgetBuilder(
        builder: (context, options) {
          return Container(
            color: Colors.red,
            child: Text('Markdown Preview: ${options.name}'),
          );
        },
      )
    };

void main() async {
  runApp(
    Builder(builder: (context) {
      return MaterialApp(
        home: SuperDeckApp(
          style: style,
          previewBuilders: previewBuilders,
        ),
      );
    }),
  );
}

class MyPresentation extends StatelessWidget {
  const MyPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperDeckApp(
      style: style,
      previewBuilders: previewBuilders,
    );
  }
}

double _calculateDistance(Alignment alignment) {
  final distance =
      -math.sqrt(alignment.x * alignment.x + alignment.y * alignment.y) / 1.5;

  return 1 - math.min(distance.abs(), 1);
}

Matrix4 _transformMatrix(Alignment alignment) {
  final double rotateX = alignment.y * 0.2;
  final double rotateY = -alignment.x * 0.2;
  return Matrix4.identity()
    ..rotateX(rotateX)
    ..rotateY(rotateY)
    ..translate(0.0, 0.0, 100.0);
}
