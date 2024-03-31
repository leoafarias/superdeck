import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

Style style() {
  return Style(
    $.outerContainer.padding.all(0),
    $.outerContainer.color.red(),
    // $.innerContainer.margin.all(20),
    $.contentContainer.padding.all(10),
    $.innerContainer.color.grey(),
    $.innerContainer.gradient.linear(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.red.withOpacity(0.5), Colors.blue.withOpacity(0.5)],
    ),
    $.contentContainer.color.black(),
    $.innerContainer.borderRadius.all(10),
    $.h1.textStyle.color.purple(),
    const Variant('simple')(
      $.paragraph.textStyle.color.red(),
    ),
  );
}

void main() async {
  await SuperDeck.initialize();
  runApp(const SuperDeck(styleBuilder: style));
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
