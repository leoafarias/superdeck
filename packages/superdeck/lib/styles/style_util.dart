import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

import '../superdeck.dart';

class SlideVariant extends Variant {
  const SlideVariant(super.name);

  static const cover = SlideVariant('cover');
  static const quote = SlideVariant('quote');
  static const none = SlideVariant('none');
}

final baseTextStyle = const TextStyle().copyWith(fontSize: 22);
final monoTextStyle = GoogleFonts.jetBrainsMono().copyWith(fontSize: 22);
final serifTextStyle = GoogleFonts.playfairDisplay().copyWith(fontSize: 50);

Style get defaultStyle => Style.create([
      $.outerContainer.only(),
      $.innerContainer.only(),
      $.contentContainer.padding.all(40),
      $.textStyle.as(baseTextStyle),
      $.h1.textStyle.fontSize(72),
      $.h1.padding.bottom(12),
      $.h2.textStyle.fontSize(48),
      $.h2.padding.bottom(9),
      $.h3.textStyle.fontSize(36),
      $.h3.padding.bottom(6),
      $.h4.textStyle.fontSize(30),
      $.h4.padding.bottom(4),
      $.h5.textStyle.fontSize(24),
      $.h5.padding.bottom(3),
      $.h6.textStyle.as(baseTextStyle),
      $.h6.padding.bottom(3),
      // $.paragraph.textStyle.as(baseTextStyle),
      $.paragraph.padding.bottom(12),
      $.link.color(Colors.blue),
      $.list.list.as(baseTextStyle),
      $.list.listItem.as(baseTextStyle),
      $.list.listItemMarker.as(baseTextStyle),
      $.list.listItemMarkerTrailingSpace(12),
      $.list.listItemMinIndent(12),
      $.table.table.as(baseTextStyle),
      $.table.tableHead.as(baseTextStyle.copyWith(fontWeight: FontWeight.bold)),
      $.table.tableBody.as(baseTextStyle),
      $.table.tableCellPadding.all(12),
      $.table.tableBorder.all(color: Colors.grey, width: 2),
      $.table.tableRowDecoration.color(Colors.grey.withOpacity(0.1)),
      $.code.textStyle.as(monoTextStyle),
      $.code.codeblockPadding.all(24),
      $.code.codeblockDecoration.color(Colors.transparent),
      $.code.codeblockDecoration.border.color(Colors.grey),
      $.code.codeblockDecoration.border.width(2),
      $.code.codeblockDecoration.borderRadius.circular(10),
      $.blockquote.blockquote.as(serifTextStyle),
      $.blockquote.blockquotePadding.bottom(12),
      $.blockquote.blockquoteContentPadding.left(12),
      $.blockquote.blockquoteDecoration.border.left.color(Colors.grey),
      $.blockquote.blockquoteDecoration.border.left.width(4),
      $.divider.height(1),
      $.divider.color(Colors.grey),
      $.divider.thickness(2),
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
      (value) => only(textStyle: value),
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
    TextStyleDto? textStyle,
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
  }) {
    return builder(
      SlideSpecAttribute(
        textStyle: textStyle,
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
        dividerHeight: dividerHeight,
        dividerColor: dividerColor,
        dividerThickness: dividerThickness,
      ),
    );
  }
}

class MdListUtil<T extends StyleAttribute>
    extends DtoUtility<T, MdListDto, MdList> {
  const MdListUtil(super.builder) : super(valueToDto: MdListDto.from);

  TextStyleUtility<T> get list {
    return TextStyleUtility<T>((value) => only(list: value));
  }

  TextStyleUtility<T> get listItem {
    return TextStyleUtility<T>((value) => only(listItem: value));
  }

  TextStyleUtility<T> get listItemMarker {
    return TextStyleUtility<T>((value) => only(listItemMarker: value));
  }

  DoubleUtility<T> get listItemMarkerTrailingSpace {
    return DoubleUtility<T>(
        (value) => only(listItemMarkerTrailingSpace: value));
  }

  DoubleUtility<T> get listItemMinIndent {
    return DoubleUtility<T>((value) => only(listItemMinIndent: value));
  }

  T only({
    TextStyleDto? list,
    TextStyleDto? listItem,
    TextStyleDto? listItemMarker,
    double? listItemMinIndent,
    double? listItemMarkerTrailingSpace,
  }) {
    return builder(
      MdListDto(
        list: list,
        listItem: listItem,
        listItemMarker: listItemMarker,
        listItemMinIndent: listItemMinIndent,
        listItemMarkerTrailingSpace: listItemMarkerTrailingSpace,
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

  TextStyleUtility<T> get table {
    return TextStyleUtility<T>((value) => only(table: value));
  }

  TextStyleUtility<T> get tableHead {
    return TextStyleUtility<T>((value) => only(tableHead: value));
  }

  TextStyleUtility<T> get tableBody {
    return TextStyleUtility<T>((value) => only(tableBody: value));
  }

  TableBorderUtility<T> get tableBorder {
    return TableBorderUtility<T>((value) => only(tableBorder: value));
  }

  BoxDecorationUtility<T> get tableRowDecoration {
    return BoxDecorationUtility<T>((value) => only(tableRowDecoration: value));
  }

  MarkdownAlternatingUtility<T> get tableRowDecorationAlternating {
    return MarkdownAlternatingUtility<T>(
      (value) => only(tableRowDecorationAlternating: value),
    );
  }

  SpacingUtility<T> get tableCellPadding {
    return SpacingUtility<T>((value) => only(tableCellPadding: value));
  }

  T tableColumnWidth(TableColumnWidth value) {
    return only(tableColumnWidth: value);
  }

  T only({
    TextStyleDto? table,
    TextStyleDto? tableHead,
    TextStyleDto? tableBody,
    TableBorderDto? tableBorder,
    BoxDecorationDto? tableRowDecoration,
    MarkdownAlternating? tableRowDecorationAlternating,
    SpacingDto? tableCellPadding,
    TableColumnWidth? tableColumnWidth,
  }) {
    return builder(
      MdTableDto(
        table: table,
        tableHead: tableHead,
        tableBody: tableBody,
        tableBorder: tableBorder,
        tableRowDecoration: tableRowDecoration,
        tableRowDecorationAlternating: tableRowDecorationAlternating,
        tableCellPadding: tableCellPadding,
        tableColumnWidth: tableColumnWidth,
      ),
    );
  }
}

class MdCodeUtil<T extends StyleAttribute>
    extends DtoUtility<T, MdCodeDto, MdCode> {
  const MdCodeUtil(super.builder) : super(valueToDto: MdCodeDto.from);

  TextStyleUtility<T> get textStyle {
    return TextStyleUtility<T>((value) => only(textStyle: value));
  }

  SpacingUtility<T> get codeblockPadding {
    return SpacingUtility<T>((value) => only(codeblockPadding: value));
  }

  BoxDecorationUtility<T> get codeblockDecoration {
    return BoxDecorationUtility<T>((value) => only(codeblockDecoration: value));
  }

  ColorUtility<T> get copyIconColor {
    return ColorUtility<T>((value) => only(copyIconColor: value));
  }

  T only({
    TextStyleDto? textStyle,
    SpacingDto? codeblockPadding,
    BoxDecorationDto? codeblockDecoration,
    double? blockSpacing,
    ColorDto? copyIconColor,
  }) {
    return builder(
      MdCodeDto(
        codeSpan: textStyle,
        codeblockPadding: codeblockPadding,
        codeblockDecoration: codeblockDecoration,
        copyIconColor: copyIconColor,
      ),
    );
  }
}

class MdBlockQuoteUtil<T extends StyleAttribute>
    extends DtoUtility<T, MdBlockQuoteDto, MdBlockQuote> {
  const MdBlockQuoteUtil(super.builder)
      : super(valueToDto: MdBlockQuoteDto.from);

  TextStyleUtility<T> get blockquote {
    return TextStyleUtility<T>((value) => only(blockquote: value));
  }

  BoxDecorationUtility<T> get blockquoteDecoration {
    return BoxDecorationUtility<T>(
        (value) => only(blockquoteDecoration: value));
  }

  SpacingUtility<T> get blockquotePadding {
    return SpacingUtility<T>((value) => only(blockquotePadding: value));
  }

  SpacingUtility<T> get blockquoteContentPadding {
    return SpacingUtility<T>((value) => only(blockquoteContentPadding: value));
  }

  T only({
    TextStyleDto? blockquote,
    BoxDecorationDto? blockquoteDecoration,
    SpacingDto? blockquotePadding,
    SpacingDto? blockquoteContentPadding,
  }) {
    return builder(
      MdBlockQuoteDto(
        blockquote: blockquote,
        blockquoteDecoration: blockquoteDecoration,
        blockquotePadding: blockquotePadding,
        blockquoteContentPadding: blockquoteContentPadding,
      ),
    );
  }
}
