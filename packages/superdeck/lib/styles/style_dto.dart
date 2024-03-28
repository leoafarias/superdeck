import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:mix/mix.dart';

import 'style_spec.dart';

class MdTextStyleDto extends Dto<MdTextStyle> with Mergeable<MdTextStyleDto> {
  final TextStyleDto? textStyle;
  final SpacingDto? padding;

  MdTextStyleDto({
    this.textStyle,
    this.padding,
  });

  static MdTextStyleDto from(MdTextStyle style) {
    return MdTextStyleDto(
      textStyle: TextStyleDto.maybeAs(style.textStyle),
      padding: SpacingDto.maybeFrom(style.padding),
    );
  }

  static MdTextStyleDto? maybeFrom(MdTextStyle? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdTextStyleDto merge(MdTextStyleDto? other) {
    return MdTextStyleDto(
      textStyle: textStyle?.merge(other?.textStyle) ?? textStyle,
      padding: padding?.merge(other?.padding) ?? padding,
    );
  }

  @override
  MdTextStyle resolve(MixData mix) {
    return MdTextStyle(
      textStyle: textStyle?.resolve(mix),
      padding: padding?.resolve(mix) as EdgeInsets?,
    );
  }

  @override
  get props => [textStyle, padding];
}

class MdListDto extends Dto<MdList> with Mergeable<MdListDto> {
  final TextStyleDto? list;
  final TextStyleDto? listItem;
  final TextStyleDto? listItemMarker;
  final double? listItemMarkerTrailingSpace;
  final double? listItemMinIndent;

  MdListDto({
    this.list,
    this.listItem,
    this.listItemMarker,
    this.listItemMinIndent,
    this.listItemMarkerTrailingSpace,
  });

  static MdListDto from(MdList style) {
    return MdListDto(
      list: TextStyleDto.maybeAs(style.list),
      listItem: TextStyleDto.maybeAs(style.listItem),
      listItemMinIndent: style.listItemMinIndent,
      listItemMarker: TextStyleDto.maybeAs(style.listItemMarker),
      listItemMarkerTrailingSpace: style.listItemMarkerTrailingSpace,
    );
  }

  static MdListDto? maybeFrom(MdList? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdListDto merge(MdListDto? other) {
    return MdListDto(
      list: list?.merge(other?.list) ?? list,
      listItem: listItem?.merge(other?.listItem) ?? listItem,
      listItemMinIndent: other?.listItemMinIndent ?? listItemMinIndent,
      listItemMarker:
          listItemMarker?.merge(other?.listItemMarker) ?? listItemMarker,
      listItemMarkerTrailingSpace:
          other?.listItemMarkerTrailingSpace ?? listItemMarkerTrailingSpace,
    );
  }

  @override
  MdList resolve(MixData mix) {
    return MdList(
      list: list?.resolve(mix),
      listItem: listItem?.resolve(mix),
      listItemMinIndent: listItemMinIndent,
      listItemMarker: listItemMarker?.resolve(mix),
      listItemMarkerTrailingSpace: listItemMarkerTrailingSpace,
    );
  }

  @override
  get props => [
        list,
        listItem,
        listItemMarker,
        listItemMarkerTrailingSpace,
        listItemMinIndent
      ];
}

class MdDividerDto extends Dto<MdDivider> with Mergeable<MdDividerDto> {
  final double? dividerHeight;
  final ColorDto? dividerColor;
  final double? dividerThickness;

  MdDividerDto({
    this.dividerHeight,
    this.dividerColor,
    this.dividerThickness,
  });

  static MdDividerDto from(MdDivider style) {
    return MdDividerDto(
      dividerHeight: style.dividerHeight,
      dividerColor: ColorDto.maybeFrom(style.dividerColor),
      dividerThickness: style.dividerThickness,
    );
  }

  static MdDividerDto? maybeFrom(MdDivider? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdDividerDto merge(MdDividerDto? other) {
    return MdDividerDto(
      dividerHeight: other?.dividerHeight ?? dividerHeight,
      dividerColor: dividerColor?.merge(other?.dividerColor) ?? dividerColor,
      dividerThickness: other?.dividerThickness ?? dividerThickness,
    );
  }

  @override
  MdDivider resolve(MixData mix) {
    return MdDivider(
      dividerHeight: dividerHeight,
      dividerColor: dividerColor?.resolve(mix),
      dividerThickness: dividerThickness,
    );
  }

  @override
  get props => [dividerHeight, dividerColor, dividerThickness];
}

class MdBlockQuoteDto extends Dto<MdBlockQuote>
    with Mergeable<MdBlockQuoteDto> {
  final TextStyleDto? blockquote;
  final BoxDecorationDto? blockquoteDecoration;
  final SpacingDto? blockquotePadding;
  final SpacingDto? blockquoteContentPadding;

  MdBlockQuoteDto({
    this.blockquote,
    this.blockquoteDecoration,
    this.blockquotePadding,
    this.blockquoteContentPadding,
  });

  static MdBlockQuoteDto from(MdBlockQuote style) {
    return MdBlockQuoteDto(
      blockquote: TextStyleDto.maybeAs(style.blockquote),
      blockquoteDecoration:
          BoxDecorationDto.maybeFrom(style.blockquoteDecoration),
      blockquotePadding: SpacingDto.maybeFrom(style.blockquotePadding),
      blockquoteContentPadding:
          SpacingDto.maybeFrom(style.blockquoteContentPadding),
    );
  }

  static MdBlockQuoteDto? maybeFrom(MdBlockQuote? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdBlockQuoteDto merge(MdBlockQuoteDto? other) {
    return MdBlockQuoteDto(
      blockquote: blockquote?.merge(other?.blockquote) ?? blockquote,
      blockquoteDecoration: blockquoteDecoration
              ?.merge(other?.blockquoteDecoration) as BoxDecorationDto? ??
          blockquoteDecoration,
      blockquotePadding: blockquotePadding?.merge(other?.blockquotePadding) ??
          blockquotePadding,
      blockquoteContentPadding:
          blockquoteContentPadding?.merge(other?.blockquoteContentPadding) ??
              blockquoteContentPadding,
    );
  }

  @override
  MdBlockQuote resolve(MixData mix) {
    return MdBlockQuote(
      blockquote: blockquote?.resolve(mix),
      blockquoteDecoration: blockquoteDecoration?.resolve(mix),
      blockquotePadding: blockquotePadding?.resolve(mix) as EdgeInsets?,
      blockquoteContentPadding:
          blockquoteContentPadding?.resolve(mix) as EdgeInsets?,
    );
  }

  @override
  get props => [
        blockquote,
        blockquoteDecoration,
        blockquotePadding,
        blockquoteContentPadding
      ];
}

class MdTableDto extends Dto<MdTable> with Mergeable<MdTableDto> {
  final TextStyleDto? table;
  final TextStyleDto? tableHead;
  final TextStyleDto? tableBody;
  final TableBorderDto? tableBorder;
  final BoxDecorationDto? tableRowDecoration;
  final MarkdownAlternating? tableRowDecorationAlternating;
  final SpacingDto? tableCellPadding;
  final TableColumnWidth? tableColumnWidth;

  MdTableDto({
    this.table,
    this.tableHead,
    this.tableBody,
    this.tableBorder,
    this.tableRowDecoration,
    this.tableRowDecorationAlternating,
    this.tableCellPadding,
    this.tableColumnWidth,
  });

  static MdTableDto from(MdTable style) {
    return MdTableDto(
      table: TextStyleDto.maybeAs(style.table),
      tableHead: TextStyleDto.maybeAs(style.tableHead),
      tableBody: TextStyleDto.maybeAs(style.tableBody),
      tableBorder: TableBorderDto.maybeFrom(style.tableBorder),
      tableRowDecoration: BoxDecorationDto.maybeFrom(style.tableRowDecoration),
      tableRowDecorationAlternating: style.tableRowDecorationAlternating,
      tableCellPadding: SpacingDto.maybeFrom(style.tableCellPadding),
      tableColumnWidth: style.tableColumnWidth,
    );
  }

  static MdTableDto? maybeFrom(MdTable? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdTableDto merge(MdTableDto? other) {
    return MdTableDto(
      table: table?.merge(other?.table) ?? table,
      tableHead: tableHead?.merge(other?.tableHead) ?? tableHead,
      tableBody: tableBody?.merge(other?.tableBody) ?? tableBody,
      tableBorder: other?.tableBorder ?? tableBorder,
      tableRowDecoration: tableRowDecoration?.merge(other?.tableRowDecoration)
              as BoxDecorationDto? ??
          tableRowDecoration,
      tableRowDecorationAlternating:
          other?.tableRowDecorationAlternating ?? tableRowDecorationAlternating,
      tableCellPadding:
          tableCellPadding?.merge(other?.tableCellPadding) ?? tableCellPadding,
      tableColumnWidth: other?.tableColumnWidth ?? tableColumnWidth,
    );
  }

  @override
  MdTable resolve(MixData mix) {
    return MdTable(
      table: table?.resolve(mix),
      tableHead: tableHead?.resolve(mix),
      tableBody: tableBody?.resolve(mix),
      tableBorder: tableBorder?.resolve(mix),
      tableRowDecoration: tableRowDecoration?.resolve(mix),
      tableRowDecorationAlternating: tableRowDecorationAlternating,
      tableCellPadding: tableCellPadding?.resolve(mix) as EdgeInsets?,
      tableColumnWidth: tableColumnWidth,
    );
  }

  @override
  get props => [
        table,
        tableHead,
        tableBody,
        tableBorder,
        tableRowDecoration,
        tableRowDecorationAlternating,
        tableCellPadding,
        tableColumnWidth,
      ];
}

class MdCodeDto extends Dto<MdCode> with Mergeable<MdCodeDto> {
  final TextStyleDto? codeSpan;
  final SpacingDto? codeblockPadding;
  final BoxDecorationDto? codeblockDecoration;

  final ColorDto? copyIconColor;

  MdCodeDto({
    this.codeSpan,
    this.codeblockPadding,
    this.codeblockDecoration,
    this.copyIconColor,
  });

  static MdCodeDto from(MdCode style) {
    return MdCodeDto(
      codeSpan: TextStyleDto.maybeAs(style.codeSpan),
      codeblockPadding: SpacingDto.maybeFrom(style.codeblockPadding),
      codeblockDecoration:
          BoxDecorationDto.maybeFrom(style.codeblockDecoration),
      copyIconColor: ColorDto.maybeFrom(style.copyIconColor),
    );
  }

  static MdCodeDto? maybeFrom(MdCode? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdCodeDto merge(MdCodeDto? other) {
    return MdCodeDto(
      codeSpan: codeSpan?.merge(other?.codeSpan) ?? codeSpan,
      codeblockPadding:
          codeblockPadding?.merge(other?.codeblockPadding) ?? codeblockPadding,
      codeblockDecoration: codeblockDecoration
              ?.merge(other?.codeblockDecoration) as BoxDecorationDto? ??
          codeblockDecoration,
      copyIconColor:
          copyIconColor?.merge(other?.copyIconColor) ?? copyIconColor,
    );
  }

  @override
  MdCode resolve(MixData mix) {
    return MdCode(
      codeSpan: codeSpan?.resolve(mix),
      codeblockPadding: codeblockPadding?.resolve(mix) as EdgeInsets?,
      codeblockDecoration: codeblockDecoration?.resolve(mix),
      copyIconColor: copyIconColor?.resolve(mix),
    );
  }

  @override
  get props => [codeSpan, codeblockPadding, codeblockDecoration, copyIconColor];
}

class TableBorderDto extends Dto<TableBorder> {
  final BorderSideDto? top;
  final BorderSideDto? right;
  final BorderSideDto? bottom;
  final BorderSideDto? left;
  final BorderSideDto? horizontalInside;
  final BorderSideDto? verticalInside;
  final BorderRadiusGeometryDto? borderRadius;

  static TableBorderDto from(TableBorder border) {
    return TableBorderDto(
      top: BorderSideDto.from(border.top),
      right: BorderSideDto.from(border.right),
      bottom: BorderSideDto.from(border.bottom),
      left: BorderSideDto.from(border.left),
      horizontalInside: BorderSideDto.from(border.horizontalInside),
      verticalInside: BorderSideDto.from(border.verticalInside),
      borderRadius: BorderRadiusGeometryDto.from(border.borderRadius),
    );
  }

  factory TableBorderDto.all({
    Color color = const Color(0xFF000000),
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    final side = BorderSideDto(
      color: ColorDto(color),
      width: width,
      style: style,
    );
    return TableBorderDto(
      top: side,
      right: side,
      bottom: side,
      left: side,
      horizontalInside: side,
      verticalInside: side,
      borderRadius: BorderRadiusGeometryDto.from(borderRadius),
    );
  }
  static TableBorderDto? maybeFrom(TableBorder? border) {
    return border != null ? from(border) : null;
  }

  const TableBorderDto({
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.horizontalInside,
    this.verticalInside,
    this.borderRadius,
  });

  @override
  TableBorder resolve(MixData mix) {
    return TableBorder(
      top: top?.resolve(mix) ?? BorderSide.none,
      right: right?.resolve(mix) ?? BorderSide.none,
      bottom: bottom?.resolve(mix) ?? BorderSide.none,
      left: left?.resolve(mix) ?? BorderSide.none,
      horizontalInside: horizontalInside?.resolve(mix) ?? BorderSide.none,
      verticalInside: verticalInside?.resolve(mix) ?? BorderSide.none,
      borderRadius:
          borderRadius?.resolve(mix) as BorderRadius? ?? BorderRadius.zero,
    );
  }

  @override
  get props => [
        top,
        right,
        bottom,
        left,
        horizontalInside,
        verticalInside,
        borderRadius
      ];
}
