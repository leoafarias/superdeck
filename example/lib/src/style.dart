import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superdeck/superdeck.dart';

VariantAttribute get radStyle {
  return const SlideVariant('rad')(
    $.h1.textStyle.as(GoogleFonts.poppins()),
    $.h1.textStyle.fontSize(140),
    $.code.decoration.border.all(
      color: Colors.red,
      width: 3,
    ),
    $.code.decoration(
      color: Colors.black54,
    ),
    $.code.padding.all(40),

    $.outerContainer.margin.all(60),

    $.innerContainer.borderRadius(25),
    $.innerContainer.shadow(
      blurRadius: 0,
      spreadRadius: 10,
      color: Colors.red.withOpacity(1),
    ),
    $.innerContainer.gradient.radial(
      stops: [0.0, 1.0],
      radius: 0.7,
      colors: [Colors.purple, Colors.deepPurple],
    ),

    // Events
    onMouseHover((event) {
      final position = event.position;
      final dx = position.x * 10;
      final dy = position.y * 10;

      return Style(
        $.innerContainer.transform(_transformMatrix(position)),
        $.innerContainer.shadow.offset(dx, dy),
        $.innerContainer.gradient.radial(
          center: position,
        ),
      );
    }),

    (onPressed | onLongPressed)(
      $.innerContainer.shadow(
        blurRadius: 5,
        spreadRadius: 1,
        offset: Offset.zero,
        color: Colors.purpleAccent,
      ),
      $.innerContainer.border.all(color: Colors.white, width: 1),
      $.innerContainer.gradient.radial
          .colors([Colors.purpleAccent, Colors.purpleAccent]),
    ),
  );
}

VariantAttribute get customStyle {
  return const SlideVariant('custom')(
    $.textStyle.as(GoogleFonts.poppins()),
    $.h1.textStyle.as(GoogleFonts.smooch()),
    $.h1.textStyle.fontSize(200),
    $.h1.textStyle.height(0),
    $.h1.textStyle.shadow(
      color: Colors.deepOrange,
      blurRadius: 20,
    ),
    $.h2.textStyle.fontSize(36),
    $.contentContainer.borderRadius(25),
    $.innerContainer.gradient.linear(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(0.5),
        Colors.deepPurple.withOpacity(0.9),
      ],
    ),
    $.contentContainer.padding.vertical(0),
    $.outerContainer.padding(40),
    $.outerContainer.gradient.linear(
      colors: [
        Colors.red,
        Colors.redAccent,
      ],
    ),
    $.innerContainer.borderRadius(25),
    $.innerContainer.border.all(
      color: Colors.deepOrange,
      width: 4,
    ),
    $.innerContainer.shadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 20,
      spreadRadius: 5,
    ),
  );
}

VariantAttribute get coverStyle {
  return const SlideVariant('cover')(
    $.h1.textStyle.as(GoogleFonts.poppins()),
    $.h1.textStyle.fontSize(100),
    $.contentContainer.gradient.linear(
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
    $.textStyle.height(0.6),
    $.h1.textStyle.fontSize(140),
    $.h1.textStyle.bold(),
    $.h1.textStyle.color(Colors.yellow),
    $.h2.textStyle.fontSize(140),
    $.h3.textStyle.fontSize(60),
    $.h3.textStyle.color(Colors.white),
    $.h3.textStyle.fontWeight(FontWeight.w100),
    $.contentContainer.gradient.linear(
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

VariantAttribute get showSectionsStyle {
  return const SlideVariant('show_sections')(
    $.contentContainer.border.all(
      color: Colors.blue,
      width: 2,
    ),
  );
}

Style get style {
  return Style(
    $.textStyle.as(GoogleFonts.poppins()),
    customStyle,
    quoteStyle,
    showSectionsStyle,
    coverStyle,
    announcementStyle,
    radStyle,
  );
}

Matrix4 _transformMatrix(Alignment alignment) {
  final double rotateX = alignment.y * 0.2;
  final double rotateY = -alignment.x * 0.2;
  return Matrix4.identity()
    ..rotateX(rotateX)
    ..rotateY(rotateY)
    ..translate(0.0, 0.0, 100.0);
}
