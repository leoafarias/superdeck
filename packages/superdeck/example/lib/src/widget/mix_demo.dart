import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:superdeck/models/options_model.dart';
import 'package:superdeck/superdeck.dart';

const purpleAccent = Color.fromARGB(255, 95, 44, 188);
const purple = Color.fromARGB(255, 66, 19, 152);

final style = Style(
  // Box
  box.height(250),
  box.width(250),
  box.borderRadius.circular(10),
  box.alignment.center(),
  box.shadow(
    blurRadius: 20,
    spreadRadius: 10,
    color: Colors.black.withOpacity(0.5),
  ),
  box.gradient.radial(
    stops: [0.0, 1.0],
    radius: 0.7,
    colors: [purpleAccent, purple],
  ),
  // Decorators
  scale(1.0),
  opacity(1),
  // Text
  text.textAlign.center(),
  text.uppercase(),
  text.style.shadow.blurRadius(2),
  text.style(
    color: Colors.white,
    fontSize: 68,
  ),
  // Events
  onMouseHover((event) {
    final position = event.position;
    final dx = position.x * 10;
    final dy = position.y * 10;

    final opacityDistance = _calculateDistance(position);

    return Style(
      text.style.shadow.color.black.withOpacity(opacityDistance),
      text.style.shadow.offset(-dx, -dy),
      box.transform(_transformMatrix(position)),
      box.shadow.offset(dx, dy),
      box.gradient.radial(
        center: position,
      ),
    );
  }),

  (onPressed | onLongPressed)(
    box.shadow(
      blurRadius: 5,
      spreadRadius: 1,
      offset: Offset.zero,
      color: purpleAccent,
    ),
    box.border.all(color: Colors.white, width: 1),
    box.gradient.radial.colors([purpleAccent, purpleAccent]),
    text.style.shadow.offset.zero(),
    scale(0.95),
  ),
);

Widget mixDemo(WidgetOptions option) {
  return PressableBox(
    onPress: () {},
    style: style.animate(),
    child: const StyledText('Mix'),
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
