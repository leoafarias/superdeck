import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mix/mix.dart';
import 'package:superdeck/superdeck.dart';

class CoverStyle extends DeckStyle {
  CoverStyle();

  @override
  Style build() {
    return super.build().merge(
          Style(
            $.h1.chain
              ..style.as(GoogleFonts.poppins())
              ..style.fontSize(100),
            $.contentContainer.gradient.linear(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.95),
              ],
            ),
          ),
        );
  }
}

class AnnouncementStyle extends DeckStyle {
  AnnouncementStyle();
  @override
  Style build() {
    return super.build().merge(
          Style(
            $.baseTextStyle.height(0.6),
            $.h1.chain
              ..style.fontSize(140)
              ..style.bold()
              ..style.color(const Color.fromARGB(255, 201, 195, 139)),
            $.h2.style.fontSize(140),
            $.h3.chain
              ..style.fontSize(60)
              ..style.color(Colors.white)
              ..style.fontWeight(FontWeight.w100),
            $.contentContainer.gradient.linear(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.95),
              ],
            ),
          ),
        );
  }
}

class QuoteStyle extends DeckStyle {
  QuoteStyle();
  @override
  Style build() {
    return super.build().merge(
          Style(
            $.blockquote.chain
              ..textStyle.as(GoogleFonts.notoSerif())
              ..decoration.border.left(
                    width: 4,
                    color: Colors.red,
                  ),
            $.p.style.fontSize(32),
            $.h6.chain
              ..style.as(GoogleFonts.notoSerif())
              ..style.fontSize(20),
          ),
        );
  }
}

class ShowSectionsStyle extends DeckStyle {
  ShowSectionsStyle();
  @override
  Style build() {
    return super.build().merge(
          Style(
            $.slideContainer.chain
              ..borderRadius(10)
              ..border.all(
                color: Colors.blue,
                width: 2,
              ),
          ),
        );
  }
}
