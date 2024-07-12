import 'package:flutter/material.dart';

import '../superdeck.dart';

class SlideVariant extends Variant {
  const SlideVariant(super.name);
}

TextStyle get baseTextStyle =>
    const TextStyle().copyWith(fontSize: 22, height: 1.4, color: Colors.white);
TextStyle get monoTextStyle => baseTextStyle.copyWith(fontSize: 16);
TextStyle get serifTextStyle => baseTextStyle.copyWith(fontSize: 50);

TextStyle get headingTextStyle => baseTextStyle.copyWith(height: 1.2);

final _util = SlideSpecUtility.self;
final _h1 = _util.h1;
final _h2 = _util.h2;
final _h3 = _util.h3;
final _h4 = _util.h4;
final _h5 = _util.h5;
final _h6 = _util.h6;
final _headings = _util.headings;
final _paragraph = _util.paragraph;
final _link = _util.link;
final _list = _util.list;
final _table = _util.table;
final _code = _util.code;
final _blockquote = _util.blockquote;
final _divider = _util.divider;
final _image = _util.image;
final _outerContainer = _util.outerContainer;
final _contentContainer = _util.contentContainer;
final _blockSpacing = _util.blockSpacing;
final _textStyle = _util.textStyle;

Style get defaultStyle => Style.create([
      _outerContainer.color.black(),
      // $.innerContainer.color.transparent(),
      _contentContainer.padding.all(40),
      // $.contentContainer.color(Colors.yellow),
      _textStyle.as(baseTextStyle),
      _headings.textStyle.as(headingTextStyle),
      _h1.textStyle.fontSize(96),
      _h1.padding.bottom(12),
      _h2.textStyle.fontSize(72),
      _h2.padding.bottom(9),
      _h3.textStyle.fontSize(48),
      _h3.padding.bottom(6),
      _h4.textStyle.fontSize(36),
      _h4.padding.bottom(4),
      _h5.textStyle.fontSize(24),
      _h5.padding.bottom(3),
      _h6.textStyle.as(baseTextStyle),
      _h6.padding.bottom(3),
      _paragraph.textStyle.as(baseTextStyle),
      _paragraph.padding.bottom(12),
      _link.color(const Color.fromARGB(255, 66, 82, 96)),
      _list.textStyle.as(baseTextStyle),
      _list.itemTextStyle.as(baseTextStyle),
      _list.itemMarkerTextStyle.as(baseTextStyle),
      _list.itemMarkerTrailingSpace(12),
      _list.itemMinIndent(12),
      _table.textStyle.as(baseTextStyle),
      _table.headTextStyle
          .as(baseTextStyle.copyWith(fontWeight: FontWeight.bold)),
      _table.bodyTextStyle.as(baseTextStyle),
      _blockSpacing(20),
      _table.cellPadding.all(12),
      _table.border.all(color: Colors.grey, width: 2),
      _table.rowDecoration.color(Colors.grey.withOpacity(0.1)),
      _code.span.as(monoTextStyle),
      _code.padding.all(24),
      _code.decoration.color(const Color.fromARGB(255, 23, 23, 23)),
      _code.decoration.borderRadius.circular(10),
      _blockquote.textStyle.as(serifTextStyle),
      _blockquote.textStyle.fontSize(32),
      _blockquote.padding.bottom(12),
      _blockquote.contentPadding.left(30),
      _blockquote.decoration.border.left.color(Colors.grey),
      _blockquote.decoration.border.left.width(4),
      _divider.height(1),
      _divider.color(Colors.grey),
      _divider.thickness(2),
      _image.fit.cover(),
    ]);
