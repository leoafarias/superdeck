import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mix/mix.dart';
import 'package:superdeck/superdeck.dart';

final _util = SlideSpecUtility.self;
final _h1 = _util.h1;
final _h2 = _util.h2;
final _h3 = _util.h3;

final _h6 = _util.h6;

final _paragraph = _util.paragraph;

final _code = _util.code;
final _blockquote = _util.blockquote;

final _outerContainer = _util.outerContainer;
final _contentContainer = _util.contentContainer;

final _textStyle = _util.textStyle;
final _innerContainer = _util.innerContainer;

Style get customStyle {
  return Style(
    _textStyle.as(GoogleFonts.poppins()),
    _h1.textStyle.as(GoogleFonts.smooch()),
    _code.textStyle.as(GoogleFonts.firaCode()),
    _code.decoration.color(Colors.black),
    _h1.textStyle.fontSize(200),
    _h1.textStyle.height(0),
    _h1.textStyle.shadow(
      color: Colors.deepOrange,
      blurRadius: 20,
    ),
    _h2.textStyle.fontSize(36),
    _contentContainer.borderRadius(25),
    _innerContainer.gradient.linear(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(0.5),
        Colors.deepPurple.withOpacity(0.9),
      ],
    ),
    _contentContainer.padding.vertical(0),
    _outerContainer.padding(40),
    _outerContainer.gradient.linear(
      colors: [
        Colors.red,
        Colors.redAccent,
      ],
    ),
    _innerContainer.borderRadius(25),
    _innerContainer.border.all(
      color: Colors.deepOrange,
      width: 4,
    ),
    _innerContainer.shadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 20,
      spreadRadius: 5,
    ),
  );
}

Style get coverStyle {
  return Style(
    _h1.textStyle.as(GoogleFonts.poppins()),
    _h1.textStyle.fontSize(100),
    _contentContainer.gradient.linear(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(0.5),
        Colors.black.withOpacity(0.95),
      ],
    ),
  );
}

Style get announcementStyle {
  return Style(
    _textStyle.height(0.6),
    _h1.textStyle.fontSize(140),
    _h1.textStyle.bold(),
    _h1.textStyle.color(Colors.yellow),
    _h2.textStyle.fontSize(140),
    _h3.textStyle.fontSize(60),
    _h3.textStyle.color(Colors.white),
    _h3.textStyle.fontWeight(FontWeight.w100),
    _contentContainer.gradient.linear(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(0.5),
        Colors.black.withOpacity(0.95),
      ],
    ),
  );
}

Style get quoteStyle {
  return Style(
    _blockquote.textStyle.as(GoogleFonts.notoSerif()),
    _blockquote.decoration.border.left(
      width: 4,
      color: Colors.red,
    ),
    _paragraph.textStyle.fontSize(32),
    _h6.textStyle.as(GoogleFonts.notoSerif()),
    _h6.textStyle.fontSize(20),
  );
}

Style get showSectionsStyle {
  return Style(
    _innerContainer.border.all(
      color: Colors.blue,
      width: 2,
    ),
    _innerContainer.borderRadius(10),
  );
}
