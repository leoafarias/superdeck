import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'style_spec.dart';

TextStyle get _baseTextStyle =>
    const TextStyle().copyWith(fontSize: 20, height: 1.4, color: Colors.white);
TextStyle get _monoTextStyle => _baseTextStyle.copyWith(fontSize: 16);
TextStyle get _serifTextStyle => _baseTextStyle.copyWith(fontSize: 50);

TextStyle get headingTextStyle => _baseTextStyle.copyWith(height: 1.2);

const onGist = Variant('gist');
const onDebug = Variant('debug');
const onImage = Variant('image');

class DeckStyle {
  DeckStyle();
  SlideSpecUtility<SlideSpecAttribute> get $ => SlideSpecUtility.self;

  Style build() {
    final containers = [
      $.slideContainer.color.transparent(),
      $.contentContainer.padding.all(40),
      $.section.image(
        $.contentContainer.padding.all(0),
      ),
      $.debug(
        $.slideContainer.border.color(Colors.yellow),
        $.contentContainer.border.color(Colors.blue),
      ),
      $.section.gist(
        $.contentContainer.chain
          ..margin.all(0)
          ..padding.all(0),
      ),
    ];

    final alertStyle = [
      // Heading
      $.alert.all.heading.chain
        ..capitalize()
        ..style.as(_baseTextStyle)
        ..style.bold(),
      // Container
      $.alert.all.container.chain
        ..padding.horizontal(24)
        ..padding.vertical(8)
        ..margin.bottom(12)
        ..color.withOpacity(0.05)
        ..border.left.width(4),
      // Description
      $.alert.all.description.chain
        ..style.as(_baseTextStyle)
        ..textAlign.left()
        ..style.height(1.6)
        ..style.fontSize(16),
      // Remaining
      $.alert.all.chain
        ..containerFlex.gap(12)
        ..containerFlex.crossAxisAlignment.start()
        ..headingFlex.gap(8),
      // Types
      $.alert.note.color(Colors.blue),
      $.alert.tip.color(Colors.green),
      $.alert.important.color(Colors.deepPurpleAccent),
      $.alert.warning.color(Colors.amber),
      $.alert.caution.color(Colors.redAccent),
    ];

    final typography = [
      $.headingTextStyle.style.as(headingTextStyle),
      $.baseTextStyle.as(_baseTextStyle),
      $.p.chain
        ..style.as(_baseTextStyle)
        ..wrap.padding.bottom(12),
      $.h1.chain
        ..style.fontSize(96)
        ..wrap.padding.bottom(12),
      $.h2.chain
        ..style.fontSize(72)
        ..wrap.padding.bottom(9),
      $.h3.chain
        ..style.fontSize(48)
        ..wrap.padding.bottom(6),
      $.h4.chain
        ..style.fontSize(36)
        ..wrap.padding.bottom(4),
      $.h5.chain
        ..style.fontSize(24)
        ..wrap.padding.bottom(3),
      $.h6.chain
        ..style.as(_baseTextStyle)
        ..wrap.padding.bottom(3),
    ];

    final codeStyle = $.code.chain
      ..textStyle.as(_monoTextStyle)
      ..padding.all(24)
      ..decoration.color(const Color.fromARGB(255, 23, 23, 23))
      ..decoration.borderRadius.circular(10);

    final tableStyle = $.table.chain
      ..headStyle.as(_baseTextStyle)
      ..headStyle.fontWeight.bold()
      ..bodyStyle.as(_baseTextStyle)
      ..cellPadding.all(12)
      ..border.all(color: Colors.grey, width: 2)
      ..cellDecoration.color(Colors.grey.withOpacity(0.1));

    final blockquoteStyle = $.blockquote.chain
      ..textStyle.as(_serifTextStyle)
      ..textStyle.fontSize(32)
      ..padding(
        bottom: 12,
        left: 30,
      )
      ..decoration.border.left(
            color: Colors.grey,
            width: 4,
          );

    final MarkdownListSpecUtility<SlideSpecAttribute> listStyle = $.list.chain
      ..bulletPadding.left(0)
      ..bulletStyle.as(_baseTextStyle);

    return Style.create([
      ...containers,
      ...typography,
      codeStyle,
      listStyle,
      ...alertStyle,

      $.link.color(const Color.fromARGB(255, 66, 82, 96)),
      $.list.bulletStyle.as(_baseTextStyle),
      $.checkbox.textStyle.as(_baseTextStyle),

      tableStyle,
      blockquoteStyle,
      // divider
      $.divider.border(width: 2, color: Colors.grey),
      $.image.fit.cover(),
    ]);
  }
}

class SlideSpecSectionsUtility {
  const SlideSpecSectionsUtility();

  final gist = const Variant('gist');

  final image = const Variant('image');
}

extension SlideSpecUtilityX<T extends Attribute> on SlideSpecUtility<T> {
  Variant get debug => const Variant('debug');
  TextStyleUtility<T> get baseTextStyle {
    return TextStyleUtility(
      (value) => only(
        p: TextSpecAttribute(style: value),
        h1: TextSpecAttribute(style: value),
        h2: TextSpecAttribute(style: value),
        h3: TextSpecAttribute(style: value),
        h4: TextSpecAttribute(style: value),
        h5: TextSpecAttribute(style: value),
        h6: TextSpecAttribute(style: value),
        list: MarkdownListSpecAttribute(bulletStyle: value),
        table: MarkdownTableSpecAttribute(bodyStyle: value, headStyle: value),
        code: MarkdownCodeblockSpecAttribute(textStyle: value),
        blockquote: MarkdownBlockquoteSpecAttribute(textStyle: value),
      ),
    );
  }

  SlideSpecSectionsUtility get section => const SlideSpecSectionsUtility();

  TextSpecUtility<T> get headingTextStyle {
    return TextSpecUtility(
      (value) => only(
        h1: value,
        h2: value,
        h3: value,
        h4: value,
        h5: value,
        h6: value,
      ),
    );
  }
}
