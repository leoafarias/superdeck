import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superdeck/superdeck.dart';

VariantAttribute get radStyle {
  return const SlideVariant('rad')(
    $deck.h1.textStyle.as(GoogleFonts.poppins()),
    $deck.h1.textStyle.fontSize(140),
    $deck.code.decoration.border.all(
      color: Colors.red,
      width: 3,
    ),
    $deck.code.decoration(
      color: Colors.black54,
    ),
    $deck.code.padding.all(40),

    $deck.outerContainer.margin.all(60),

    $deck.innerContainer.borderRadius(25),
    $deck.innerContainer.shadow(
      blurRadius: 0,
      spreadRadius: 10,
      color: Colors.red.withOpacity(1),
    ),
    $deck.innerContainer.gradient.radial(
      stops: [0.0, 1.0],
      radius: 0.7,
      colors: [Colors.purple, Colors.deepPurple],
    ),

    // Events
    $on.hover.event((e) {
      if (e == null) return const Style.empty();
      final position = e.position;
      final dx = position.x * 10;
      final dy = position.y * 10;

      return Style(
        $deck.innerContainer.transform(_transformMatrix(position)),
        $deck.innerContainer.shadow.offset(dx, dy),
        $deck.innerContainer.gradient.radial(
          center: position,
        ),
      );
    }),

    ($on.press | $on.longPress)(
      $deck.innerContainer.shadow(
        blurRadius: 5,
        spreadRadius: 1,
        offset: Offset.zero,
        color: Colors.purpleAccent,
      ),
      $deck.innerContainer.border.all(color: Colors.white, width: 1),
      $deck.innerContainer.gradient.radial
          .colors([Colors.purpleAccent, Colors.purpleAccent]),
    ),
  );
}

VariantAttribute get customStyle {
  return const SlideVariant('custom')(
    $deck.textStyle.as(GoogleFonts.poppins()),
    $deck.h1.textStyle.as(GoogleFonts.smooch()),
    $deck.h1.textStyle.fontSize(200),
    $deck.h1.textStyle.height(0),
    $deck.h1.textStyle.shadow(
      color: Colors.deepOrange,
      blurRadius: 20,
    ),
    $deck.h2.textStyle.fontSize(36),
    $deck.contentContainer.borderRadius(25),
    $deck.innerContainer.gradient.linear(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(0.5),
        Colors.deepPurple.withOpacity(0.9),
      ],
    ),
    $deck.contentContainer.padding.vertical(0),
    $deck.outerContainer.padding(40),
    $deck.outerContainer.gradient.linear(
      colors: [
        Colors.red,
        Colors.redAccent,
      ],
    ),
    $deck.innerContainer.borderRadius(25),
    $deck.innerContainer.border.all(
      color: Colors.deepOrange,
      width: 4,
    ),
    $deck.innerContainer.shadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 20,
      spreadRadius: 5,
    ),
  );
}

VariantAttribute get coverStyle {
  return const SlideVariant('cover')(
    $deck.h1.textStyle.as(GoogleFonts.poppins()),
    $deck.h1.textStyle.fontSize(100),
    $deck.contentContainer.gradient.linear(
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
    $deck.textStyle.height(0.6),
    $deck.h1.textStyle.fontSize(140),
    $deck.h1.textStyle.bold(),
    $deck.h1.textStyle.color(Colors.yellow),
    $deck.h2.textStyle.fontSize(140),
    $deck.h3.textStyle.fontSize(60),
    $deck.h3.textStyle.color(Colors.white),
    $deck.h3.textStyle.fontWeight(FontWeight.w100),
    $deck.contentContainer.gradient.linear(
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
    $deck.blockquote.textStyle.as(GoogleFonts.notoSerif()),
    $deck.blockquote.decoration.border.left(
      width: 4,
      color: Colors.red,
    ),
    $deck.paragraph.textStyle.fontSize(32),
    $deck.h6.textStyle.as(GoogleFonts.notoSerif()),
    $deck.h6.textStyle.fontSize(20),
  );
}

VariantAttribute get showSectionsStyle {
  return const SlideVariant('show_sections')(
    $deck.contentContainer.border.all(
      color: Colors.blue,
      width: 2,
    ),
  );
}

Style get style {
  return Style(
    $deck.textStyle.as(GoogleFonts.poppins()),
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
