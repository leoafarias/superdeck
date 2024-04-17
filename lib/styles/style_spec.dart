import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:mix/mix.dart';

import 'style_attribute.dart';

class MdDivider extends Spec<MdDivider> {
  final double? dividerHeight;
  final Color? dividerColor;
  final double? dividerThickness;

  const MdDivider({
    required this.dividerHeight,
    required this.dividerColor,
    required this.dividerThickness,
  });

  @override
  MdDivider lerp(
    MdDivider? other,
    double t,
  ) {
    return MdDivider(
      dividerHeight: lerpDouble(dividerHeight, other?.dividerHeight, t),
      dividerColor: Color.lerp(dividerColor, other?.dividerColor, t),
      dividerThickness:
          lerpDouble(dividerThickness, other?.dividerThickness, t),
    );
  }

  @override
  MdDivider copyWith({
    double? dividerHeight,
    Color? dividerColor,
    double? dividerThickness,
  }) {
    return MdDivider(
      dividerHeight: dividerHeight ?? this.dividerHeight,
      dividerColor: dividerColor ?? this.dividerColor,
      dividerThickness: dividerThickness ?? this.dividerThickness,
    );
  }

  @override
  get props => [dividerHeight, dividerColor, dividerThickness];
}

class MdTextStyle extends Spec<MdTextStyle> {
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  const MdTextStyle({
    required this.textStyle,
    required this.padding,
  });

  @override
  MdTextStyle lerp(
    MdTextStyle? other,
    double t,
  ) {
    return MdTextStyle(
      textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
      padding: EdgeInsets.lerp(padding, other?.padding, t),
    );
  }

  @override
  MdTextStyle copyWith({
    TextStyle? textStyle,
    EdgeInsets? padding,
  }) {
    return MdTextStyle(
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
    );
  }

  @override
  get props => [textStyle, padding];
}

class MdList extends Spec<MdList> {
  final TextStyle? list;
  final TextStyle? listItem;
  final TextStyle? listItemMarker;
  final double? listItemMarkerTrailingSpace;
  final double? listItemMinIndent;

  const MdList({
    required this.list,
    required this.listItem,
    required this.listItemMarker,
    required this.listItemMarkerTrailingSpace,
    required this.listItemMinIndent,
  });

  @override
  MdList lerp(
    MdList? other,
    double t,
  ) {
    return MdList(
      list: TextStyle.lerp(list, other?.list, t),
      listItem: TextStyle.lerp(listItem, other?.listItem, t),
      listItemMarker: TextStyle.lerp(listItemMarker, other?.listItemMarker, t),
      listItemMinIndent:
          lerpDouble(listItemMinIndent, other?.listItemMinIndent, t),
      listItemMarkerTrailingSpace: lerpDouble(
          listItemMarkerTrailingSpace, other?.listItemMarkerTrailingSpace, t),
    );
  }

  @override
  MdList copyWith({
    TextStyle? list,
    TextStyle? listItem,
    TextStyle? listItemMarker,
    double? listItemMinIndent,
    double? listItemMarkerTrailingSpace,
  }) {
    return MdList(
      list: list ?? this.list,
      listItem: listItem ?? this.listItem,
      listItemMinIndent: listItemMinIndent ?? this.listItemMinIndent,
      listItemMarker: listItemMarker ?? this.listItemMarker,
      listItemMarkerTrailingSpace:
          listItemMarkerTrailingSpace ?? this.listItemMarkerTrailingSpace,
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

class MdBlockQuote extends Spec<MdBlockQuote> {
  final TextStyle? blockquote;
  final BoxDecoration? blockquoteDecoration;
  final EdgeInsets? blockquotePadding;
  final EdgeInsets? blockquoteContentPadding;

  const MdBlockQuote({
    required this.blockquote,
    required this.blockquoteDecoration,
    required this.blockquotePadding,
    required this.blockquoteContentPadding,
  });

  @override
  MdBlockQuote lerp(
    MdBlockQuote? other,
    double t,
  ) {
    return MdBlockQuote(
      blockquote: TextStyle.lerp(blockquote, other?.blockquote, t),
      blockquoteDecoration: BoxDecoration.lerp(
          blockquoteDecoration, other?.blockquoteDecoration, t),
      blockquotePadding:
          EdgeInsets.lerp(blockquotePadding, other?.blockquotePadding, t),
      blockquoteContentPadding: EdgeInsets.lerp(
          blockquoteContentPadding, other?.blockquoteContentPadding, t),
    );
  }

  @override
  MdBlockQuote copyWith({
    TextStyle? blockquote,
    BoxDecoration? blockquoteDecoration,
    EdgeInsets? blockquotePadding,
    EdgeInsets? blockquoteContentPadding,
  }) {
    return MdBlockQuote(
      blockquote: blockquote ?? this.blockquote,
      blockquoteDecoration: blockquoteDecoration ?? this.blockquoteDecoration,
      blockquotePadding: blockquotePadding ?? this.blockquotePadding,
      blockquoteContentPadding:
          blockquoteContentPadding ?? this.blockquoteContentPadding,
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

class MdTable extends Spec<MdTable> {
  final TextStyle? table;
  final TextStyle? tableHead;
  final TextStyle? tableBody;
  final TableBorder? tableBorder;
  final BoxDecoration? tableRowDecoration;
  final MarkdownAlternating? tableRowDecorationAlternating;
  final EdgeInsets? tableCellPadding;
  final TableColumnWidth? tableColumnWidth;

  const MdTable({
    required this.table,
    required this.tableHead,
    required this.tableBody,
    required this.tableBorder,
    required this.tableRowDecoration,
    required this.tableRowDecorationAlternating,
    required this.tableCellPadding,
    required this.tableColumnWidth,
  });

  @override
  MdTable lerp(
    MdTable? other,
    double t,
  ) {
    return MdTable(
      table: TextStyle.lerp(table, other?.table, t),
      tableHead: TextStyle.lerp(tableHead, other?.tableHead, t),
      tableBody: TextStyle.lerp(tableBody, other?.tableBody, t),
      tableBorder: TableBorder.lerp(tableBorder, other?.tableBorder, t),
      tableRowDecoration:
          BoxDecoration.lerp(tableRowDecoration, other?.tableRowDecoration, t),
      tableRowDecorationAlternating:
          tableRowDecorationAlternating ?? other?.tableRowDecorationAlternating,
      tableCellPadding:
          EdgeInsets.lerp(tableCellPadding, other?.tableCellPadding, t),
      tableColumnWidth: t < 0.5 ? tableColumnWidth : other?.tableColumnWidth,
    );
  }

  @override
  MdTable copyWith({
    TextStyle? table,
    TextStyle? tableHead,
    TextStyle? tableBody,
    TableBorder? tableBorder,
    BoxDecoration? tableRowDecoration,
    MarkdownAlternating? tableRowDecorationAlternating,
    EdgeInsets? tableCellPadding,
    TableColumnWidth? tableColumnWidth,
  }) {
    return MdTable(
      table: table ?? this.table,
      tableHead: tableHead ?? this.tableHead,
      tableBody: tableBody ?? this.tableBody,
      tableBorder: tableBorder ?? this.tableBorder,
      tableRowDecoration: tableRowDecoration ?? this.tableRowDecoration,
      tableRowDecorationAlternating:
          tableRowDecorationAlternating ?? this.tableRowDecorationAlternating,
      tableCellPadding: tableCellPadding ?? this.tableCellPadding,
      tableColumnWidth: tableColumnWidth ?? this.tableColumnWidth,
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

class MdCode extends Spec<MdCode> {
  final TextStyle? codeSpan;
  final EdgeInsets? codeblockPadding;
  final BoxDecoration? codeblockDecoration;
  final TextStyle? codeBlock;

  final Color? copyIconColor;

  const MdCode({
    required this.codeSpan,
    required this.codeblockPadding,
    required this.codeblockDecoration,
    required this.copyIconColor,
    required this.codeBlock,
  });

  @override
  MdCode lerp(
    MdCode? other,
    double t,
  ) {
    return MdCode(
      codeSpan: TextStyle.lerp(codeSpan, other?.codeSpan, t),
      codeblockPadding:
          EdgeInsets.lerp(codeblockPadding, other?.codeblockPadding, t),
      codeblockDecoration: BoxDecoration.lerp(
          codeblockDecoration, other?.codeblockDecoration, t),
      copyIconColor: Color.lerp(copyIconColor, other?.copyIconColor, t),
      codeBlock: TextStyle.lerp(codeBlock, other?.codeBlock, t),
    );
  }

  @override
  MdCode copyWith({
    TextStyle? codeSpan,
    EdgeInsets? codeblockPadding,
    BoxDecoration? codeblockDecoration,
    Color? copyIconColor,
    TextStyle? codeBlock,
  }) {
    return MdCode(
      codeSpan: codeSpan ?? this.codeSpan,
      codeblockPadding: codeblockPadding ?? this.codeblockPadding,
      codeblockDecoration: codeblockDecoration ?? this.codeblockDecoration,
      copyIconColor: copyIconColor ?? this.copyIconColor,
      codeBlock: codeBlock ?? this.codeBlock,
    );
  }

  @override
  get props => [
        codeSpan,
        codeblockPadding,
        codeblockDecoration,
        copyIconColor,
        codeBlock
      ];
}

class SlideSpec extends Spec<SlideSpec> {
  final MdTextStyle? headline1;
  final MdTextStyle? headline2;
  final MdTextStyle? headline3;
  final MdTextStyle? headline4;
  final MdTextStyle? headline5;
  final MdTextStyle? headline6;
  final MdTextStyle? paragraph;
  final TextStyle? link;
  final double? blockSpacing;
  final MdDivider? divider;
  final MdBlockQuote? blockquote;
  final MdList? list;
  final MdTable? table;
  final MdCode? code;
  final BoxSpec? _innerContainer;
  final BoxSpec? _outerContainer;
  final BoxSpec? _contentContainer;
  final ImageSpec? _image;

  const SlideSpec({
    required this.headline1,
    required this.headline2,
    required this.headline3,
    required this.headline4,
    required this.headline5,
    required this.headline6,
    required this.paragraph,
    required this.link,
    required this.blockSpacing,
    required this.divider,
    required this.blockquote,
    required this.list,
    required this.table,
    required this.code,
    required BoxSpec? innerContainer,
    required BoxSpec? outerContainer,
    required BoxSpec? contentContainer,
    required ImageSpec? image,
  })  : _outerContainer = outerContainer,
        _innerContainer = innerContainer,
        _contentContainer = contentContainer,
        _image = image;

  const SlideSpec.empty()
      : headline1 = null,
        headline2 = null,
        headline3 = null,
        headline4 = null,
        headline5 = null,
        headline6 = null,
        paragraph = null,
        link = null,
        blockSpacing = null,
        divider = null,
        blockquote = null,
        list = null,
        table = null,
        code = null,
        _innerContainer = null,
        _outerContainer = null,
        _contentContainer = null,
        _image = null;

  static SlideSpec of(BuildContext context) {
    final mix = MixProvider.of(context);
    return fromMix(mix);
  }

  static SlideSpec fromMix(MixData mix) {
    return mix.specOf<SlideSpec, SlideSpecAttribute>(const SlideSpec.empty());
  }

  BoxSpec get innerContainer => _innerContainer ?? const BoxSpec.empty();

  BoxSpec get outerContainer => _outerContainer ?? const BoxSpec.empty();

  BoxSpec get contentContainer => _contentContainer ?? const BoxSpec.empty();

  ImageSpec get image => _image ?? const ImageSpec.empty();

  @override
  SlideSpec lerp(
    SlideSpec? other,
    double t,
  ) {
    if (other == null) return this;

    return SlideSpec(
      headline1: headline1?.lerp(other.headline1, t),
      headline2: headline2?.lerp(other.headline2, t),
      headline3: headline3?.lerp(other.headline3, t),
      headline4: headline4?.lerp(other.headline4, t),
      headline5: headline5?.lerp(other.headline5, t),
      headline6: headline6?.lerp(other.headline6, t),
      paragraph: paragraph?.lerp(other.paragraph, t),
      link: TextStyle.lerp(link, other.link, t),
      blockSpacing: lerpDouble(blockSpacing, other.blockSpacing, t),
      divider: divider?.lerp(other.divider, t),
      list: list?.lerp(other.list, t),
      blockquote: blockquote?.lerp(other.blockquote, t),
      table: table?.lerp(other.table, t),
      code: code?.lerp(other.code, t),
      innerContainer: _innerContainer?.lerp(other._innerContainer, t),
      outerContainer: _outerContainer?.lerp(other._outerContainer, t),
      contentContainer: _contentContainer?.lerp(other._contentContainer, t),
      image: _image?.lerp(other._image, t),
    );
  }

  MarkdownStyle toStyle() {
    return MarkdownStyle(
      headline1: headline1?.textStyle,
      h1Padding: headline1?.padding ?? EdgeInsets.zero,
      headline2: headline2?.textStyle,
      h2Padding: headline2?.padding ?? EdgeInsets.zero,
      headline3: headline3?.textStyle,
      h3Padding: headline3?.padding ?? EdgeInsets.zero,
      headline4: headline4?.textStyle,
      h4Padding: headline4?.padding ?? EdgeInsets.zero,
      headline5: headline5?.textStyle,
      h5Padding: headline5?.padding ?? EdgeInsets.zero,
      headline6: headline6?.textStyle,
      h6Padding: headline6?.padding ?? EdgeInsets.zero,
      paragraph: paragraph?.textStyle,
      paragraphPadding: paragraph?.padding ?? EdgeInsets.zero,
      link: link,
      dividerHeight: divider?.dividerHeight ?? 1.0,
      dividerColor: divider?.dividerColor ?? Colors.black,
      dividerThickness: divider?.dividerThickness ?? 1.0,
      blockquote: blockquote?.blockquote,
      blockquoteDecoration: blockquote?.blockquoteDecoration,
      blockquotePadding: blockquote?.blockquotePadding ?? EdgeInsets.zero,
      blockquoteContentPadding:
          blockquote?.blockquoteContentPadding ?? EdgeInsets.zero,
      list: list?.list,
      listItem: list?.listItem,
      listItemMarker: list?.listItemMarker,
      listItemMarkerTrailingSpace: list?.listItemMarkerTrailingSpace ?? 4.0,
      listItemMinIndent: list?.listItemMinIndent ?? 16.0,
      table: table?.table,
      tableHead: table?.tableHead,
      tableBody: table?.tableBody,
      tableBorder: table?.tableBorder,
      tableRowDecoration: table?.tableRowDecoration,
      tableRowDecorationAlternating: table?.tableRowDecorationAlternating,
      tableCellPadding: table?.tableCellPadding,
      tableColumnWidth: table?.tableColumnWidth,
      codeSpan: code?.codeSpan,
      codeBlock: code?.codeSpan,
      codeblockPadding: code?.codeblockPadding,
      codeblockDecoration: code?.codeblockDecoration,
      blockSpacing: blockSpacing ?? 8,
      copyIconColor: code?.copyIconColor ?? Colors.black,
    );
  }

  @override
  SlideSpec copyWith({
    TextStyle? textStyle,
    MdTextStyle? headline1,
    MdTextStyle? headline2,
    MdTextStyle? headline3,
    MdTextStyle? headline4,
    MdTextStyle? headline5,
    MdTextStyle? headline6,
    MdTextStyle? paragraph,
    TextStyle? link,
    double? blockSpacing,
    MdDivider? divider,
    MdList? list,
    MdBlockQuote? blockquote,
    MdTable? table,
    MdCode? code,
    BoxSpec? innerContainer,
    BoxSpec? outerContainer,
    BoxSpec? contentContainer,
    ImageSpec? image,
  }) {
    return SlideSpec(
      headline1: headline1 ?? this.headline1,
      headline2: headline2 ?? this.headline2,
      headline3: headline3 ?? this.headline3,
      headline4: headline4 ?? this.headline4,
      headline5: headline5 ?? this.headline5,
      headline6: headline6 ?? this.headline6,
      paragraph: paragraph ?? this.paragraph,
      link: link ?? this.link,
      blockSpacing: blockSpacing ?? this.blockSpacing,
      divider: divider ?? this.divider,
      list: list ?? this.list,
      blockquote: blockquote ?? this.blockquote,
      table: table ?? this.table,
      code: code ?? this.code,
      innerContainer: innerContainer ?? _innerContainer,
      outerContainer: outerContainer ?? _outerContainer,
      contentContainer: contentContainer ?? _contentContainer,
      image: image ?? _image,
    );
  }

  @override
  get props => [
        headline1,
        headline2,
        headline3,
        headline4,
        headline5,
        headline6,
        paragraph,
        link,
        blockSpacing,
        divider,
        list,
        blockquote,
        table,
        code,
        _innerContainer,
        _outerContainer,
        _contentContainer,
        _image,
      ];
}

extension on MixData {
  Spec specOf<Spec, A extends SpecAttribute<A, Spec>>(Spec fallback) {
    return resolvableOf<Spec, A>() ?? fallback;
  }
}
