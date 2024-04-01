import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

import '../superdeck.dart';

Style get defaultStyle {
  final baseTextStyle = GoogleFonts.inter().copyWith(fontSize: 22);
  final jetBrainsTextStyle = GoogleFonts.jetBrainsMono().copyWith(fontSize: 22);

  return Style(
    SlideSpecAttribute(
      outerContainer: const BoxSpecAttribute(
          // padding: SpacingDto.from(const EdgeInsets.all(20)),
          ),
      // innerContainer: BoxSpecAttribute(
      //   decoration: BoxDecorationDto(
      //     color: const ColorDto(Colors.grey),
      //     borderRadius: BorderRadiusGeometryDto.from(
      //       BorderRadius.circular(20),
      //     ),
      //   ),
      // ),
      contentContainer: BoxSpecAttribute(
        padding: SpacingDto.from(const EdgeInsets.all(40)),
        decoration: BoxDecorationDto(
          color: const ColorDto(Colors.transparent),
          border: BoxBorderDto.from(
            Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
      ),
      textStyle: TextStyleDto.as(baseTextStyle),
      headline1: MdTextStyleDto(
        textStyle: TextStyleDto.as(baseTextStyle.copyWith(fontSize: 72)),
        padding: const SpacingDto.only(bottom: 12),
      ),
      headline2: MdTextStyleDto(
        textStyle: TextStyleDto.as(baseTextStyle.copyWith(fontSize: 48)),
        padding: const SpacingDto.only(bottom: 9),
      ),
      headline3: MdTextStyleDto(
        textStyle: TextStyleDto.as(baseTextStyle.copyWith(fontSize: 36)),
        padding: const SpacingDto.only(bottom: 6),
      ),
      headline4: MdTextStyleDto(
        textStyle: TextStyleDto.as(baseTextStyle.copyWith(fontSize: 30)),
        padding: const SpacingDto.only(bottom: 4),
      ),
      headline5: MdTextStyleDto(
        textStyle: TextStyleDto.as(baseTextStyle.copyWith(fontSize: 24)),
        padding: const SpacingDto.only(bottom: 3),
      ),
      headline6: MdTextStyleDto(
        textStyle: TextStyleDto.as(baseTextStyle),
        padding: const SpacingDto.only(bottom: 3),
      ),
      paragraph: MdTextStyleDto(
        textStyle: TextStyleDto.as(baseTextStyle),
        padding: const SpacingDto.only(bottom: 12),
      ),
      link: TextStyleDto.as(baseTextStyle.copyWith(color: Colors.blue)),
      list: MdListDto(
        list: TextStyleDto.as(baseTextStyle),
        listItem: TextStyleDto.as(baseTextStyle),
        listItemMarker: TextStyleDto.as(baseTextStyle),
        listItemMinIndent: 12,
        listItemMarkerTrailingSpace: 12,
      ),
      table: MdTableDto(
        table: TextStyleDto.as(baseTextStyle),
        tableHead: TextStyleDto.as(
          baseTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        tableBody: TextStyleDto.as(baseTextStyle),
        tableCellPadding: SpacingDto.from(const EdgeInsets.all(12)),
        tableBorder: TableBorderDto.all(color: Colors.grey, width: 2),
        tableRowDecoration: BoxDecorationDto(
          color: ColorDto(
            Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
      code: MdCodeDto(
        codeSpan: TextStyleDto.as(jetBrainsTextStyle),
        codeblockPadding: SpacingDto.from(const EdgeInsets.all(24)),
        codeblockDecoration: BoxDecorationDto(
          color: const ColorDto(Colors.transparent),
          border: BoxBorderDto.from(
            Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          borderRadius: BorderRadiusGeometryDto.from(
            BorderRadius.circular(10),
          ),
        ),
      ),
      blockquote: MdBlockQuoteDto(
        blockquote: TextStyleDto.as(baseTextStyle),
        blockquotePadding: const SpacingDto.only(bottom: 12),
        blockquoteContentPadding: const SpacingDto.only(left: 12),
        blockquoteDecoration: BoxDecorationDto(
          border: BoxBorderDto.from(
            Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 2.0,
            ),
          ),
        ),
      ),
      divider: MdDividerDto(
        dividerHeight: 1,
        dividerColor: const ColorDto(Colors.grey),
        dividerThickness: 2,
      ),
    ),
  );
}

const $ = SlideStyleUtility(selfBuilder);

class SlideStyleUtility<T extends SpecAttribute>
    extends SpecUtility<T, SlideSpecAttribute> {
  const SlideStyleUtility(super.builder);

  TextStyleUtility<T> get textStyle {
    return TextStyleUtility(
      (value) => only(textStyle: value),
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

  T only({
    TextStyleDto? list,
    TextStyleDto? listItem,
    TextStyleDto? listItemMarker,
    double? listItemMarkerTrailingSpace,
  }) {
    return builder(
      MdListDto(
        list: list,
        listItem: listItem,
        listItemMarker: listItemMarker,
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

  T only({
    BorderSideDto? top,
    BorderSideDto? right,
    BorderSideDto? bottom,
    BorderSideDto? left,
    BorderSideDto? horizontalInside,
    BorderSideDto? verticalInside,
  }) {
    return builder(
      TableBorderDto(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        horizontalInside: horizontalInside,
        verticalInside: verticalInside,
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

  TextStyleUtility<T> get codeSpan {
    return TextStyleUtility<T>((value) => only(codeSpan: value));
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
    TextStyleDto? codeSpan,
    SpacingDto? codeblockPadding,
    BoxDecorationDto? codeblockDecoration,
    double? blockSpacing,
    ColorDto? copyIconColor,
  }) {
    return builder(
      MdCodeDto(
        codeSpan: codeSpan,
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
