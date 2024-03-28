import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

SlideStyle style() {
  return SlideStyle(
    outerContainer: Style(
      padding.all(20),
      // backgroundColor.red(),
    ),
    innerContainer: Style(
      padding.all(20),

      // backgroundColor.green(),
      borderRadius.all(10),
    ),
    content: Style(
      $.h1.textStyle.color.purple(),
      const Variant('simple')(
        $.paragraph.textStyle.color.red(),
      ),
    ),
  );
}

void main() {
  SuperDeck.run(style: style());
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
