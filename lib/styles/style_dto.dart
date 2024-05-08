import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:mix/mix.dart';

import 'style_spec.dart';

class MdTextStyleDto extends Dto<MdTextStyle> {
  final TextStyleDto? textStyle;
  final SpacingDto? padding;

  const MdTextStyleDto({
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
      textStyle: textStyle?.merge(other?.textStyle) ?? other?.textStyle,
      padding: padding?.merge(other?.padding) ?? other?.padding,
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

class MdListDto extends Dto<MdList> {
  final TextStyleDto? textStyle;
  final TextStyleDto? item;
  final TextStyleDto? itemMarker;
  final double? itemMarkerTrailingSpace;
  final double? itemMinIndent;

  const MdListDto({
    this.textStyle,
    this.item,
    this.itemMarker,
    this.itemMinIndent,
    this.itemMarkerTrailingSpace,
  });

  static MdListDto from(MdList style) {
    return MdListDto(
      textStyle: TextStyleDto.maybeAs(style.list),
      item: TextStyleDto.maybeAs(style.listItem),
      itemMinIndent: style.listItemMinIndent,
      itemMarker: TextStyleDto.maybeAs(style.listItemMarker),
      itemMarkerTrailingSpace: style.listItemMarkerTrailingSpace,
    );
  }

  static MdListDto? maybeFrom(MdList? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdListDto merge(MdListDto? other) {
    return MdListDto(
      textStyle: textStyle?.merge(other?.textStyle) ?? other?.textStyle,
      item: item?.merge(other?.item) ?? other?.item,
      itemMinIndent: other?.itemMinIndent ?? itemMinIndent,
      itemMarker: itemMarker?.merge(other?.itemMarker) ?? other?.itemMarker,
      itemMarkerTrailingSpace:
          other?.itemMarkerTrailingSpace ?? itemMarkerTrailingSpace,
    );
  }

  @override
  MdList resolve(MixData mix) {
    return MdList(
      list: textStyle?.resolve(mix),
      listItem: item?.resolve(mix),
      listItemMinIndent: itemMinIndent,
      listItemMarker: itemMarker?.resolve(mix),
      listItemMarkerTrailingSpace: itemMarkerTrailingSpace,
    );
  }

  @override
  get props =>
      [textStyle, item, itemMarker, itemMarkerTrailingSpace, itemMinIndent];
}

class MdDividerDto extends Dto<MdDivider> {
  final double? height;
  final ColorDto? color;
  final double? thickness;

  const MdDividerDto({
    this.height,
    this.color,
    this.thickness,
  });

  static MdDividerDto from(MdDivider style) {
    return MdDividerDto(
      height: style.dividerHeight,
      color: ColorDto.maybeFrom(style.dividerColor),
      thickness: style.dividerThickness,
    );
  }

  static MdDividerDto? maybeFrom(MdDivider? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdDividerDto merge(MdDividerDto? other) {
    return MdDividerDto(
      height: other?.height ?? height,
      color: color?.merge(other?.color) ?? other?.color,
      thickness: other?.thickness ?? thickness,
    );
  }

  @override
  MdDivider resolve(MixData mix) {
    return MdDivider(
      dividerHeight: height,
      dividerColor: color?.resolve(mix),
      dividerThickness: thickness,
    );
  }

  @override
  get props => [height, color, thickness];
}

class MdBlockQuoteDto extends Dto<MdBlockQuote> {
  final TextStyleDto? textStyle;
  final BoxDecorationDto? decoration;
  final SpacingDto? padding;
  final SpacingDto? contentPadding;

  const MdBlockQuoteDto({
    this.textStyle,
    this.decoration,
    this.padding,
    this.contentPadding,
  });

  static MdBlockQuoteDto from(MdBlockQuote style) {
    return MdBlockQuoteDto(
      textStyle: TextStyleDto.maybeAs(style.blockquote),
      decoration: BoxDecorationDto.maybeFrom(style.blockquoteDecoration),
      padding: SpacingDto.maybeFrom(style.blockquotePadding),
      contentPadding: SpacingDto.maybeFrom(style.blockquoteContentPadding),
    );
  }

  static MdBlockQuoteDto? maybeFrom(MdBlockQuote? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdBlockQuoteDto merge(MdBlockQuoteDto? other) {
    return MdBlockQuoteDto(
      textStyle: textStyle?.merge(other?.textStyle) ?? other?.textStyle,
      decoration: (decoration?.merge(other?.decoration) ?? other?.decoration)
          as BoxDecorationDto?,
      padding: padding?.merge(other?.padding) ?? other?.padding,
      contentPadding:
          contentPadding?.merge(other?.contentPadding) ?? other?.contentPadding,
    );
  }

  @override
  MdBlockQuote resolve(MixData mix) {
    return MdBlockQuote(
      blockquote: textStyle?.resolve(mix),
      blockquoteDecoration: decoration?.resolve(mix),
      blockquotePadding: padding?.resolve(mix) as EdgeInsets?,
      blockquoteContentPadding: contentPadding?.resolve(mix) as EdgeInsets?,
    );
  }

  @override
  get props => [textStyle, decoration, padding, contentPadding];
}

@immutable
class MdTableDto extends Dto<MdTable> {
  final TextStyleDto? textStyle;
  final TextStyleDto? head;
  final TextStyleDto? body;
  final TableBorderDto? border;
  final BoxDecorationDto? rowDecoration;
  final MarkdownAlternating? rowDecorationAlternating;
  final SpacingDto? cellPadding;
  final TableColumnWidth? columnWidth;

  const MdTableDto({
    this.textStyle,
    this.head,
    this.body,
    this.border,
    this.rowDecoration,
    this.rowDecorationAlternating,
    this.cellPadding,
    this.columnWidth,
  });

  static MdTableDto from(MdTable style) {
    return MdTableDto(
      textStyle: TextStyleDto.maybeAs(style.table),
      head: TextStyleDto.maybeAs(style.tableHead),
      body: TextStyleDto.maybeAs(style.tableBody),
      border: TableBorderDto.maybeFrom(style.tableBorder),
      rowDecoration: BoxDecorationDto.maybeFrom(style.tableRowDecoration),
      rowDecorationAlternating: style.tableRowDecorationAlternating,
      cellPadding: SpacingDto.maybeFrom(style.tableCellPadding),
      columnWidth: style.tableColumnWidth,
    );
  }

  static MdTableDto? maybeFrom(MdTable? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdTableDto merge(MdTableDto? other) {
    return MdTableDto(
      textStyle: textStyle?.merge(other?.textStyle) ?? other?.textStyle,
      head: head?.merge(other?.head) ?? other?.head,
      body: body?.merge(other?.body) ?? other?.body,
      border: other?.border ?? border,
      rowDecoration: (rowDecoration?.merge(other?.rowDecoration) ??
          other?.rowDecoration) as BoxDecorationDto?,
      rowDecorationAlternating:
          other?.rowDecorationAlternating ?? rowDecorationAlternating,
      cellPadding: cellPadding?.merge(other?.cellPadding) ?? other?.cellPadding,
      columnWidth: other?.columnWidth ?? columnWidth,
    );
  }

  @override
  MdTable resolve(MixData mix) {
    return MdTable(
      table: textStyle?.resolve(mix),
      tableHead: head?.resolve(mix),
      tableBody: body?.resolve(mix),
      tableBorder: border?.resolve(mix),
      tableRowDecoration: rowDecoration?.resolve(mix),
      tableRowDecorationAlternating: rowDecorationAlternating,
      tableCellPadding: cellPadding?.resolve(mix) as EdgeInsets?,
      tableColumnWidth: columnWidth,
    );
  }

  @override
  get props => [
        textStyle,
        head,
        body,
        border,
        rowDecoration,
        rowDecorationAlternating,
        cellPadding,
        columnWidth,
      ];
}

@immutable
class MdCodeDto extends Dto<MdCode> {
  final TextStyleDto? span;
  final TextStyleDto? textStyle;
  final SpacingDto? padding;
  final BoxDecorationDto? decoration;

  final ColorDto? copyIconColor;

  const MdCodeDto({
    this.textStyle,
    this.span,
    this.padding,
    this.decoration,
    this.copyIconColor,
  });

  static MdCodeDto from(MdCode style) {
    return MdCodeDto(
      span: TextStyleDto.maybeAs(style.codeSpan),
      padding: SpacingDto.maybeFrom(style.codeblockPadding),
      decoration: BoxDecorationDto.maybeFrom(style.codeblockDecoration),
      copyIconColor: ColorDto.maybeFrom(style.copyIconColor),
      textStyle: TextStyleDto.maybeAs(style.codeBlock),
    );
  }

  static MdCodeDto? maybeFrom(MdCode? style) {
    return style != null ? from(style) : null;
  }

  @override
  MdCodeDto merge(MdCodeDto? other) {
    return MdCodeDto(
      span: span?.merge(other?.span) ?? other?.span,
      padding: padding?.merge(other?.padding) ?? other?.padding,
      decoration: (decoration?.merge(other?.decoration) ?? other?.decoration)
          as BoxDecorationDto?,
      copyIconColor:
          copyIconColor?.merge(other?.copyIconColor) ?? other?.copyIconColor,
      textStyle: textStyle?.merge(other?.textStyle) ?? other?.textStyle,
    );
  }

  @override
  MdCode resolve(MixData mix) {
    return MdCode(
      codeSpan: span?.resolve(mix),
      codeblockPadding: padding?.resolve(mix) as EdgeInsets?,
      codeblockDecoration: decoration?.resolve(mix),
      copyIconColor: copyIconColor?.resolve(mix),
      codeBlock: textStyle?.resolve(mix),
    );
  }

  @override
  get props => [span, padding, decoration, copyIconColor, textStyle];
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
  TableBorderDto merge(TableBorderDto? other) {
    return TableBorderDto(
      top: top?.merge(other?.top) ?? other?.top,
      right: right?.merge(other?.right) ?? other?.right,
      bottom: bottom?.merge(other?.bottom) ?? other?.bottom,
      left: left?.merge(other?.left) ?? other?.left,
      horizontalInside: horizontalInside?.merge(other?.horizontalInside) ??
          other?.horizontalInside,
      verticalInside:
          verticalInside?.merge(other?.verticalInside) ?? other?.verticalInside,
      borderRadius:
          borderRadius?.merge(other?.borderRadius) ?? other?.borderRadius,
    );
  }

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
