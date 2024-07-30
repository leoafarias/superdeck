import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superdeck/styles/style_util.dart';
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

VariantAttribute get radStyle {
  return const SlideVariant('rad')(
    _h1.textStyle.as(GoogleFonts.poppins()),
    _h1.textStyle.fontSize(140),
    _code.decoration.border.all(
      color: Colors.white,
      width: 1,
    ),
    _code.decoration.color.black(),
    _code.padding.all(40),
    _outerContainer.margin.all(60),
    _innerContainer.borderRadius(25),
    _innerContainer.shadow(
      blurRadius: 0,
      spreadRadius: 10,
      color: Colors.red.withOpacity(1),
    ),
    _innerContainer.gradient.radial(
      stops: [0.0, 1.0],
      radius: 0.7,
      colors: [Colors.purple, Colors.deepPurple],
    ),
    $on.focus(
      _innerContainer.color.yellow(),
    ),
    $on.hover.event((e) {
      if (e == null) return const Style.empty();
      final position = e.position;
      final dx = position.x * 10;
      final dy = position.y * 10;

      return Style(
        _innerContainer.transform(_transformMatrix(position)),
        _innerContainer.shadow.offset(dx, dy),
        _innerContainer.gradient.radial(
          center: position,
        ),
      );
    }),
    ($on.press | $on.longPress)(
      _innerContainer.shadow(
        blurRadius: 5,
        spreadRadius: 1,
        offset: Offset.zero,
        color: Colors.purpleAccent,
      ),
      _innerContainer.border.all(color: Colors.white, width: 1),
      _innerContainer.gradient.radial
          .colors([Colors.purpleAccent, Colors.purpleAccent]),
    ),
  );
}

VariantAttribute get customStyle {
  return const SlideVariant('custom')(
    _textStyle.as(GoogleFonts.poppins()),
    _h1.textStyle.as(GoogleFonts.smooch()),
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

VariantAttribute get coverStyle {
  return const SlideVariant('cover')(
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

VariantAttribute get announcementStyle {
  return const SlideVariant('announcement')(
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

VariantAttribute get quoteStyle {
  return const SlideVariant('quote')(
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

VariantAttribute get showSectionsStyle {
  return const SlideVariant('show_sections')(
    _contentContainer.border.all(
      color: Colors.blue,
      width: 2,
    ),
  );
}

Style get style {
  return Style(
    _textStyle.as(GoogleFonts.poppins()),
    _code.textStyle.as(GoogleFonts.sourceCodePro()),
    customStyle,
    quoteStyle,
    showSectionsStyle,
    coverStyle,
    announcementStyle,
    radStyle,
  ).animate();
}

Matrix4 _transformMatrix(Alignment alignment) {
  final double rotateX = alignment.y * 0.2;
  final double rotateY = -alignment.x * 0.2;
  return Matrix4.identity()
    ..rotateX(rotateX)
    ..rotateY(rotateY)
    ..translate(0.0, 0.0, 100.0);
}
