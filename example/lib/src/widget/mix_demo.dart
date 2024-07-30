import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:superdeck/components/molecules/code_preview.dart';
import 'package:superdeck/schema/schema_model.dart';
import 'package:superdeck/superdeck.dart';

const purpleAccent = Color.fromARGB(255, 95, 44, 188);
const purple = Color.fromARGB(255, 66, 19, 152);

Style get _style => Style(
      // Box
      $box.height(250),
      $box.width(250),
      $box.borderRadius.circular(10),
      $box.alignment.center(),
      $box.shadow(
        blurRadius: 20,
        spreadRadius: 10,
        color: Colors.black.withOpacity(0.5),
      ),
      $box.gradient.radial(
        stops: [0.0, 1.0],
        radius: 0.7,
        colors: [purpleAccent, purple],
      ),
      // Decorators
      $with.scale(1.0),
      $with.opacity(1),
      // Text
      $text.textAlign.center(),
      $text.style.shadow.blurRadius(2),
      $text.style(
        color: Colors.white,
        fontSize: 32,
      ),
      // Events
      $on.hover.event((e) {
        if (e == null) return const Style.empty();
        final position = e.position;
        final dx = position.x * 10;
        final dy = position.y * 10;

        final opacityDistance = _calculateDistance(position);

        return Style(
          $text.style.shadow.color.black.withOpacity(opacityDistance),
          $text.style.shadow.offset(-dx, -dy),
          $box.transform(_transformMatrix(position)),
          $box.shadow.offset(dx, dy),
          $box.gradient.radial.center(position),
        );
      }),

      $on.hover(
        $box.color.black(),
      ),

      ($on.press | $on.longPress)(
        $box.shadow(
          blurRadius: 5,
          spreadRadius: 1,
          offset: Offset.zero,
          color: purpleAccent,
        ),
        $box.border(color: Colors.white, width: 1),
        $box.gradient.radial.colors([purpleAccent, purpleAccent]),
        $text.style.shadow.offset.zero(),
        $with.scale(0.95),
      ),
    );

class ExampleOptions {
  final double height;
  final double width;
  final String? text;
  const ExampleOptions({
    required this.height,
    required this.width,
    this.text,
  });

  static ExampleOptions fromMap(Map<String, dynamic> map) {
    return ExampleOptions(
      height: map['height'] as double,
      width: map['width'] as double,
      text: map['text'] as String?,
    );
  }

  static final schema = ArgsSchema(
    validator: Schema(
      {
        'height': Schema.double.isRequired(),
        'width': Schema.double.isRequired(),
        'text': Schema.string.isRequired(),
      },
    ),
    decoder: fromMap,
  );
}

Widget mixExampleBuilder(BuildContext context) {
  final options = ExampleOptions.fromMap(context.args);
  return Builder(
    builder: (context) {
      return Center(
        child: Box(
          style: Style(
            _style(),
            $box.height(options.height),
            $box.width(options.width),
          ).animate(),
          child: StyledText(
            options.text ?? 'Mix',
          ),
        ),
      );
    },
  );
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
