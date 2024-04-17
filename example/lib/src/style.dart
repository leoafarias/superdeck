import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superdeck/superdeck.dart';

VariantAttribute get coverStyle {
  return SlideVariant.cover(
    $.textStyle.as(GoogleFonts.poppins()),
    $.h1.textStyle.as(GoogleFonts.smooch()),
    $.h1.textStyle.fontSize(220),
    $.h1.textStyle.height(1),
    $.h1.textStyle.shadow(
      color: Colors.deepOrange,
      blurRadius: 20,
    ),
    $.contentContainer.borderRadius(25),
    $.contentContainer.gradient.linear(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(0.5),
        Colors.deepPurple.withOpacity(0.9),
      ],
    ),
    $.outerContainer.padding(40),
    $.outerContainer.gradient.linear(
      colors: [
        Colors.red,
        Colors.blue,
      ],
    ),
    $.innerContainer.borderRadius(25),
    $.innerContainer.shadow(
      color: Colors.black.withOpacity(0.7),
      blurRadius: 20,
      spreadRadius: 5,
    ),
  );
}

Style get style {
  return Style(
    coverStyle,
  );
}
