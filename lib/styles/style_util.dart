import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:mix/mix.dart';

import '../superdeck.dart';

class SlideVariant extends Variant {
  const SlideVariant(super.name);
}

TextStyle get baseTextStyle =>
    const TextStyle().copyWith(fontSize: 22, height: 1.6);
TextStyle get monoTextStyle => const TextStyle().copyWith(fontSize: 16);
TextStyle get serifTextStyle => const TextStyle().copyWith(fontSize: 50);

TextStyle get headingTextStyle => baseTextStyle.copyWith(height: 1.2);

Style get defaultStyle => Style.create([
      $.outerContainer.color.black(),
      // $.innerContainer.color.transparent(),
      $.contentContainer.padding.all(40),
      // $.contentContainer.color(Colors.yellow),
      $.textStyle.as(baseTextStyle),
      $.headings.textStyle.as(headingTextStyle),
      $.h1.textStyle.fontSize(96),
      $.h1.padding.bottom(12),
      $.h2.textStyle.fontSize(72),
      $.h2.padding.bottom(9),
      $.h3.textStyle.fontSize(48),
      $.h3.padding.bottom(6),
      $.h4.textStyle.fontSize(36),
      $.h4.padding.bottom(4),
      $.h5.textStyle.fontSize(24),
      $.h5.padding.bottom(3),
      $.h6.textStyle.as(baseTextStyle),
      $.h6.padding.bottom(3),
      $.paragraph.textStyle.as(baseTextStyle),
      $.paragraph.padding.bottom(12),
      $.link.color(Colors.blue),
      $.list.textStyle.as(baseTextStyle),
      $.list.item.as(baseTextStyle),
      $.list.itemMarker.as(baseTextStyle),
      $.list.itemMarkerTrailingSpace(12),
      $.list.itemMinIndent(12),
      $.table.textStyle.as(baseTextStyle),
      $.table.head.as(baseTextStyle.copyWith(fontWeight: FontWeight.bold)),
      $.table.body.as(baseTextStyle),
      $.blockSpacing(20),
      $.table.cellPadding.all(12),
      $.table.border.all(color: Colors.grey, width: 2),
      $.table.rowDecoration.color(Colors.grey.withOpacity(0.1)),
      $.code.span.as(monoTextStyle),
      $.code.padding.all(24),
      $.code.decoration.color(const Color.fromARGB(255, 23, 23, 23)),
      $.code.decoration.borderRadius.circular(10),
      $.blockquote.textStyle.as(serifTextStyle),
      $.blockquote.textStyle.fontSize(32),
      $.blockquote.padding.bottom(12),
      $.blockquote.contentPadding.left(30),
      $.blockquote.decoration.border.left.color(Colors.grey),
      $.blockquote.decoration.border.left.width(4),
      $.divider.height(1),
      $.divider.color(Colors.grey),
      $.divider.thickness(2),
      $.image.fit.cover(),
    ]);

const $ = SlideStyleUtility(selfBuilder);

SlideStyleUtility styleSlide() {
  return const SlideStyleUtility(selfBuilder);
}

class SlideStyleUtility<T extends SpecAttribute>
    extends SpecUtility<T, SlideSpecAttribute> {
  const SlideStyleUtility(super.builder);

  TextStyleUtility<T> get textStyle {
    return TextStyleUtility(
      (value) => only(
        paragraph: MdTextStyleDto(textStyle: value),
        headline1: MdTextStyleDto(textStyle: value),
        headline2: MdTextStyleDto(textStyle: value),
        headline3: MdTextStyleDto(textStyle: value),
        headline4: MdTextStyleDto(textStyle: value),
        headline5: MdTextStyleDto(textStyle: value),
        headline6: MdTextStyleDto(textStyle: value),
        list: MdListDto(textStyle: value),
        table: MdTableDto(textStyle: value),
        code: MdCodeDto(textStyle: value),
        blockquote: MdBlockQuoteDto(textStyle: value),
      ),
    );
  }

  MdTextStyleUtil<T> get headings {
    return MdTextStyleUtil(
      (value) => only(
        headline1: value,
        headline2: value,
        headline3: value,
        headline4: value,
        headline5: value,
        headline6: value,
      ),
    );
  }

  MdDividerUtil<T> get divider {
    return MdDividerUtil(
      (value) => only(divider: value),
    );
  }

  MdTextStyleUtil<T> get h1 {
    return MdTextStyleUtil(
      (value) => only(headline1: value),
    );
  }

  BoxSpecUtility<T> get innerContainer {
    return BoxSpecUtility(
      (value) => only(innerContainer: value),
    );
  }

  BoxSpecUtility<T> get outerContainer {
    return BoxSpecUtility(
      (value) => only(outerContainer: value),
    );
  }

  BoxSpecUtility<T> get contentContainer {
    return BoxSpecUtility(
      (value) => only(contentContainer: value),
    );
  }

  ImageUtility<T> get image {
    return ImageUtility(
      (value) => only(image: value),
    );
  }

  MdTextStyleUtil<T> get h2 {
    return MdTextStyleUtil(
      (value) => only(headline2: value),
    );
  }

  MdTextStyleUtil<T> get h3 {
    return MdTextStyleUtil(
      (value) => only(headline3: value),
    );
  }

  MdTextStyleUtil<T> get h4 {
    return MdTextStyleUtil(
      (value) => only(headline4: value),
    );
  }

  MdTextStyleUtil<T> get h5 {
    return MdTextStyleUtil(
      (value) => only(headline5: value),
    );
  }

  MdTextStyleUtil<T> get h6 {
    return MdTextStyleUtil(
      (value) => only(headline6: value),
    );
  }

  MdTextStyleUtil<T> get paragraph {
    return MdTextStyleUtil(
      (value) => only(paragraph: value),
    );
  }

  TextStyleUtility<T> get link {
    return TextStyleUtility(
      (value) => only(link: value),
    );
  }

  MdListUtil<T> get list {
    return MdListUtil(
      (value) => only(list: value),
    );
  }

  MdTableUtil<T> get table {
    return MdTableUtil(
      (value) => only(table: value),
    );
  }

  MdCodeUtil<T> get code {
    return MdCodeUtil(
      (value) => only(code: value),
    );
  }

  MdBlockQuoteUtil<T> get blockquote {
    return MdBlockQuoteUtil(
      (value) => only(blockquote: value),
    );
  }

  DoubleUtility<T> get blockSpacing {
    return DoubleUtility((value) => only(blockSpacing: value));
  }

  @override
  T only({
    MdTextStyleDto? headline1,
    MdTextStyleDto? headline2,
    MdTextStyleDto? headline3,
    MdTextStyleDto? headline4,
    MdTextStyleDto? headline5,
    MdTextStyleDto? headline6,
    MdTextStyleDto? paragraph,
    TextStyleDto? link,
    double? blockSpacing,
    MdListDto? list,
    MdTableDto? table,
    MdCodeDto? code,
    MdBlockQuoteDto? blockquote,
    BoxSpecAttribute? innerContainer,
    BoxSpecAttribute? outerContainer,
    BoxSpecAttribute? contentContainer,
    MdDividerDto? divider,
    ImageSpecAttribute? image,
  }) {
    return builder(
      SlideSpecAttribute(
        headline1: headline1,
        headline2: headline2,
        headline3: headline3,
        headline4: headline4,
        headline5: headline5,
        headline6: headline6,
        paragraph: paragraph,
        link: link,
        blockSpacing: blockSpacing,
        list: list,
        table: table,
        code: code,
        blockquote: blockquote,
        innerContainer: innerContainer,
        outerContainer: outerContainer,
        contentContainer: contentContainer,
        divider: divider,
        image: image,
      ),
    );
  }
}

class MdTextStyleUtil<T extends StyleAttribute>
    extends DtoUtility<T, MdTextStyleDto, MdTextStyle> {
  const MdTextStyleUtil(super.builder) : super(valueToDto: MdTextStyleDto.from);

  SpacingUtility<T> get padding {
    return SpacingUtility<T>((value) => only(padding: value));
  }

  TextStyleUtility<T> get textStyle {
    return TextStyleUtility<T>((value) => only(textStyle: value));
  }

  T only({
    TextStyleDto? textStyle,
    SpacingDto? padding,
  }) {
    return builder(
      MdTextStyleDto(
        textStyle: textStyle,
        padding: padding,
      ),
    );
  }

  T call({
    TextStyle? textStyle,
    EdgeInsets? padding,
  }) {
    return only(
      textStyle: TextStyleDto.maybeAs(textStyle),
      padding: SpacingDto.maybeFrom(padding),
    );
  }
}

class MdDividerUtil<T extends StyleAttribute>
    extends DtoUtility<T, MdDividerDto, MdDivider> {
  const MdDividerUtil(super.builder) : super(valueToDto: MdDividerDto.from);

  DoubleUtility<T> get height {
    return DoubleUtility<T>((value) => only(dividerHeight: value));
  }

  ColorUtility<T> get color {
    return ColorUtility<T>((value) => only(dividerColor: value));
  }

  DoubleUtility<T> get thickness {
    return DoubleUtility<T>((value) => only(dividerThickness: value));
  }

  T only({
    double? dividerHeight,
    ColorDto? dividerColor,
    double? dividerThickness,
  }) {
    return builder(
      MdDividerDto(
        height: dividerHeight,
        color: dividerColor,
        thickness: dividerThickness,
      ),
    );
  }
}

class MdListUtil<T extends StyleAttribute>
    extends DtoUtility<T, MdListDto, MdList> {
  const MdListUtil(super.builder) : super(valueToDto: MdListDto.from);

  TextStyleUtility<T> get textStyle {
    return TextStyleUtility<T>((value) => only(textStyle: value));
  }

  TextStyleUtility<T> get item {
    return TextStyleUtility<T>((value) => only(item: value));
  }

  TextStyleUtility<T> get itemMarker {
    return TextStyleUtility<T>((value) => only(itemMarker: value));
  }

  DoubleUtility<T> get itemMarkerTrailingSpace {
    return DoubleUtility<T>((value) => only(itemMarkerTrailingSpace: value));
  }

  DoubleUtility<T> get itemMinIndent {
    return DoubleUtility<T>((value) => only(itemMinIndent: value));
  }

  T only({
    TextStyleDto? textStyle,
    TextStyleDto? item,
    TextStyleDto? itemMarker,
    double? itemMinIndent,
    double? itemMarkerTrailingSpace,
  }) {
    return builder(
      MdListDto(
        textStyle: textStyle,
        item: item,
        itemMarker: itemMarker,
        itemMinIndent: itemMinIndent,
        itemMarkerTrailingSpace: itemMarkerTrailingSpace,
      ),
    );
  }
}

class TableBorderUtility<T extends StyleAttribute>
    extends DtoUtility<T, TableBorderDto, TableBorder> {
  const TableBorderUtility(super.builder)
      : super(valueToDto: TableBorderDto.from);

  BorderSideUtility<T> get top {
    return BorderSideUtility<T>((value) => only(top: value));
  }

  BorderSideUtility<T> get right {
    return BorderSideUtility<T>((value) => only(right: value));
  }

  BorderSideUtility<T> get bottom {
    return BorderSideUtility<T>((value) => only(bottom: value));
  }

  BorderSideUtility<T> get left {
    return BorderSideUtility<T>((value) => only(left: value));
  }

  BorderSideUtility<T> get horizontalInside {
    return BorderSideUtility<T>((value) => only(horizontalInside: value));
  }

  BorderSideUtility<T> get verticalInside {
    return BorderSideUtility<T>((value) => only(verticalInside: value));
  }

  BorderSideUtility<T> get all {
    return BorderSideUtility<T>((value) => only(
          top: value,
          right: value,
          bottom: value,
          left: value,
          horizontalInside: value,
          verticalInside: value,
        ));
  }

  T only({
    BorderSideDto? top,
    BorderSideDto? right,
    BorderSideDto? bottom,
    BorderSideDto? left,
    BorderSideDto? horizontalInside,
    BorderSideDto? verticalInside,
    BorderRadiusGeometryDto? borderRadius,
  }) {
    return builder(
      TableBorderDto(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        horizontalInside: horizontalInside,
        verticalInside: verticalInside,
        borderRadius: borderRadius,
      ),
    );
  }
}

class MarkdownAlternatingUtility<T extends StyleAttribute>
    extends ScalarUtility<T, MarkdownAlternating> {
  const MarkdownAlternatingUtility(super.builder);

  T odd() => builder(MarkdownAlternating.odd);
  T even() => builder(MarkdownAlternating.even);
}

class MdTableUtil<T extends StyleAttribute>
    extends DtoUtility<T, MdTableDto, MdTable> {
  const MdTableUtil(super.builder) : super(valueToDto: MdTableDto.from);

  TextStyleUtility<T> get textStyle {
    return TextStyleUtility<T>((value) => only(textStyle: value));
  }

  TextStyleUtility<T> get head {
    return TextStyleUtility<T>((value) => only(head: value));
  }

  TextStyleUtility<T> get body {
    return TextStyleUtility<T>((value) => only(body: value));
  }

  TableBorderUtility<T> get border {
    return TableBorderUtility<T>((value) => only(border: value));
  }

  BoxDecorationUtility<T> get rowDecoration {
    return BoxDecorationUtility<T>((value) => only(rowDecoration: value));
  }

  MarkdownAlternatingUtility<T> get rowDecorationAlternating {
    return MarkdownAlternatingUtility<T>(
      (value) => only(rowDecorationAlternating: value),
    );
  }

  SpacingUtility<T> get cellPadding {
    return SpacingUtility<T>((value) => only(cellPadding: value));
  }

  T tableColumnWidth(TableColumnWidth value) {
    return only(columnWidth: value);
  }

  T only({
    TextStyleDto? textStyle,
    TextStyleDto? head,
    TextStyleDto? body,
    TableBorderDto? border,
    BoxDecorationDto? rowDecoration,
    MarkdownAlternating? rowDecorationAlternating,
    SpacingDto? cellPadding,
    TableColumnWidth? columnWidth,
  }) {
    return builder(
      MdTableDto(
        textStyle: textStyle,
        head: head,
        body: body,
        border: border,
        rowDecoration: rowDecoration,
        rowDecorationAlternating: rowDecorationAlternating,
        cellPadding: cellPadding,
        columnWidth: columnWidth,
      ),
    );
  }
}

class MdCodeUtil<T extends StyleAttribute>
    extends DtoUtility<T, MdCodeDto, MdCode> {
  const MdCodeUtil(super.builder) : super(valueToDto: MdCodeDto.from);

  TextStyleUtility<T> get span {
    return TextStyleUtility<T>((value) => only(span: value));
  }

  TextStyleUtility<T> get textStyle {
    return TextStyleUtility<T>((value) => only(textStyle: value));
  }

  SpacingUtility<T> get padding {
    return SpacingUtility<T>((value) => only(padding: value));
  }

  BoxDecorationUtility<T> get decoration {
    return BoxDecorationUtility<T>((value) => only(decoration: value));
  }
  // codeSpan

  ColorUtility<T> get copyIconColor {
    return ColorUtility<T>((value) => only(copyIconColor: value));
  }

  T only({
    TextStyleDto? span,
    SpacingDto? padding,
    BoxDecorationDto? decoration,
    ColorDto? copyIconColor,
    TextStyleDto? textStyle,
  }) {
    return builder(
      MdCodeDto(
        span: span,
        padding: padding,
        decoration: decoration,
        copyIconColor: copyIconColor,
        textStyle: textStyle,
      ),
    );
  }
}

class MdBlockQuoteUtil<T extends StyleAttribute>
    extends DtoUtility<T, MdBlockQuoteDto, MdBlockQuote> {
  const MdBlockQuoteUtil(super.builder)
      : super(valueToDto: MdBlockQuoteDto.from);

  TextStyleUtility<T> get textStyle {
    return TextStyleUtility<T>((value) => only(textStyle: value));
  }

  BoxDecorationUtility<T> get decoration {
    return BoxDecorationUtility<T>((value) => only(decoration: value));
  }

  SpacingUtility<T> get padding {
    return SpacingUtility<T>((value) => only(padding: value));
  }

  SpacingUtility<T> get contentPadding {
    return SpacingUtility<T>((value) => only(contentPadding: value));
  }

  T only({
    TextStyleDto? textStyle,
    BoxDecorationDto? decoration,
    SpacingDto? padding,
    SpacingDto? contentPadding,
  }) {
    return builder(
      MdBlockQuoteDto(
        textStyle: textStyle,
        decoration: decoration,
        padding: padding,
        contentPadding: contentPadding,
      ),
    );
  }
}
