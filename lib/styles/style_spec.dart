import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

part 'style_spec.g.dart';

const _mdTextStyle = MixableFieldDto(type: 'MdTextStyleAttribute');
const _mdCode = MixableFieldDto(type: 'MdCodeAttribute');
const _mdList = MixableFieldDto(type: 'MdListAttribute');
const _mdTable = MixableFieldDto(type: 'MdTableAttribute');
const _mdDivider = MixableFieldDto(type: 'MdDividerAttribute');
const _mdBlockQuote = MixableFieldDto(type: 'MdBlockQuoteAttribute');

@MixableSpec()
final class MdDivider extends Spec<MdDivider> with _$MdDivider {
  @MixableProperty(utilities: [MixableUtility(alias: 'height')])
  final double? dividerHeight;
  @MixableProperty(utilities: [MixableUtility(alias: 'color')])
  final Color? dividerColor;
  @MixableProperty(utilities: [MixableUtility(alias: 'thickness')])
  final double? dividerThickness;

  const MdDivider({
    this.dividerHeight,
    this.dividerColor,
    this.dividerThickness,
  });
}

@MixableSpec()
final class MdTextStyle extends Spec<MdTextStyle> with _$MdTextStyle {
  final TextStyle? textStyle;

  final EdgeInsets? padding;

  const MdTextStyle({
    this.textStyle,
    this.padding,
  });
}

@MixableSpec()
final class MdList extends Spec<MdList> with _$MdList {
  @MixableProperty(utilities: [MixableUtility(alias: 'textStyle')])
  final TextStyle? list;
  @MixableProperty(utilities: [MixableUtility(alias: 'itemTextStyle')])
  final TextStyle? listItem;
  @MixableProperty(utilities: [MixableUtility(alias: 'itemMarkerTextStyle')])
  final TextStyle? listItemMarker;
  @MixableProperty(
      utilities: [MixableUtility(alias: 'itemMarkerTrailingSpace')])
  final double? listItemMarkerTrailingSpace;
  @MixableProperty(utilities: [MixableUtility(alias: 'itemMinIndent')])
  final double? listItemMinIndent;

  const MdList({
    this.list,
    this.listItem,
    this.listItemMarker,
    this.listItemMarkerTrailingSpace,
    this.listItemMinIndent,
  });
}

@MixableSpec()
final class MdBlockQuote extends Spec<MdBlockQuote> with _$MdBlockQuote {
  @MixableProperty(utilities: [MixableUtility(alias: 'textStyle')])
  final TextStyle? blockquote;
  @MixableProperty(utilities: [MixableUtility(alias: 'decoration')])
  final BoxDecoration? blockquoteDecoration;
  @MixableProperty(utilities: [MixableUtility(alias: 'padding')])
  final EdgeInsets? blockquotePadding;
  @MixableProperty(utilities: [MixableUtility(alias: 'contentPadding')])
  final EdgeInsets? blockquoteContentPadding;

  const MdBlockQuote({
    this.blockquote,
    this.blockquoteDecoration,
    this.blockquotePadding,
    this.blockquoteContentPadding,
  });
}

@MixableSpec()
final class MdTable extends Spec<MdTable> with _$MdTable {
  @MixableProperty(utilities: [MixableUtility(alias: 'textStyle')])
  final TextStyle? table;
  @MixableProperty(utilities: [MixableUtility(alias: 'headTextStyle')])
  final TextStyle? tableHead;
  @MixableProperty(utilities: [MixableUtility(alias: 'bodyTextStyle')])
  final TextStyle? tableBody;
  @MixableProperty(utilities: [MixableUtility(alias: 'border')])
  final TableBorder? tableBorder;
  @MixableProperty(utilities: [MixableUtility(alias: 'rowDecoration')])
  final BoxDecoration? tableRowDecoration;
  @MixableProperty(
      utilities: [MixableUtility(alias: 'rowDecorationAlternating')])
  final MarkdownAlternating? tableRowDecorationAlternating;
  @MixableProperty(
    utilities: [
      MixableUtility(
        alias: 'cellPadding',
      )
    ],
  )
  final EdgeInsets? tableCellPadding;
  @MixableProperty(utilities: [MixableUtility(alias: 'columnWidth')])
  final TableColumnWidth? tableColumnWidth;

  const MdTable({
    this.table,
    this.tableHead,
    this.tableBody,
    this.tableBorder,
    this.tableRowDecoration,
    this.tableRowDecorationAlternating,
    this.tableCellPadding,
    this.tableColumnWidth,
  });
}

@MixableSpec()
final class MdCode extends Spec<MdCode> with _$MdCode {
  @MixableProperty(utilities: [MixableUtility(alias: 'span')])
  final TextStyle? codeSpan;
  @MixableProperty(utilities: [
    MixableUtility(
      alias: 'padding',
    )
  ])
  final EdgeInsets? codeblockPadding;
  @MixableProperty(utilities: [MixableUtility(alias: 'decoration')])
  final BoxDecoration? codeblockDecoration;
  @MixableProperty(utilities: [MixableUtility(alias: 'block')])
  final TextStyle? codeBlock;

  final Color? copyIconColor;

  const MdCode({
    this.codeSpan,
    this.codeblockPadding,
    this.codeblockDecoration,
    this.copyIconColor,
    this.codeBlock,
  });
}

@MixableSpec()
final class SlideSpec extends Spec<SlideSpec> with _$SlideSpec {
  @MixableProperty(dto: _mdTextStyle, utilities: [MixableUtility(alias: 'h1')])
  final MdTextStyle? headline1;
  @MixableProperty(dto: _mdTextStyle, utilities: [MixableUtility(alias: 'h2')])
  final MdTextStyle? headline2;
  @MixableProperty(dto: _mdTextStyle, utilities: [MixableUtility(alias: 'h3')])
  final MdTextStyle? headline3;
  @MixableProperty(dto: _mdTextStyle, utilities: [MixableUtility(alias: 'h4')])
  final MdTextStyle? headline4;
  @MixableProperty(dto: _mdTextStyle, utilities: [MixableUtility(alias: 'h5')])
  final MdTextStyle? headline5;
  @MixableProperty(dto: _mdTextStyle, utilities: [MixableUtility(alias: 'h6')])
  final MdTextStyle? headline6;
  @MixableProperty(dto: _mdTextStyle)
  final MdTextStyle? paragraph;
  final TextStyle? link;
  final double? blockSpacing;
  @MixableProperty(dto: _mdDivider)
  final MdDivider? divider;
  @MixableProperty(dto: _mdBlockQuote)
  final MdBlockQuote? blockquote;
  @MixableProperty(dto: _mdList)
  final MdList? list;
  @MixableProperty(dto: _mdTable)
  final MdTable? table;
  @MixableProperty(dto: _mdCode)
  final MdCode? code;
  final BoxSpec innerContainer;
  final BoxSpec outerContainer;
  final BoxSpec contentContainer;
  final ImageSpec image;

  static const of = _$SlideSpec.of;
  static const from = _$SlideSpec.from;

  const SlideSpec({
    this.headline1,
    this.headline2,
    this.headline3,
    this.headline4,
    this.headline5,
    this.headline6,
    this.paragraph,
    this.link,
    this.blockSpacing,
    this.divider,
    this.blockquote,
    this.list,
    this.table,
    this.code,
    BoxSpec? innerContainer,
    BoxSpec? outerContainer,
    BoxSpec? contentContainer,
    ImageSpec? image,
    super.animated,
  })  : outerContainer = outerContainer ?? const BoxSpec(),
        innerContainer = innerContainer ?? const BoxSpec(),
        contentContainer = contentContainer ?? const BoxSpec(),
        image = image ?? const ImageSpec();

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
}

extension on MixData {
  Spec specOf<Spec, A extends SpecAttribute<Spec>>(Spec fallback) {
    return resolvableOf<Spec, A>() ?? fallback;
  }
}

extension SlideSpecUtilityX<T extends Attribute> on SlideSpecUtility<T> {
  TextStyleUtility<T> get textStyle {
    return TextStyleUtility(
      (value) => only(
        paragraph: MdTextStyleAttribute(textStyle: value),
        headline1: MdTextStyleAttribute(textStyle: value),
        headline2: MdTextStyleAttribute(textStyle: value),
        headline3: MdTextStyleAttribute(textStyle: value),
        headline4: MdTextStyleAttribute(textStyle: value),
        headline5: MdTextStyleAttribute(textStyle: value),
        headline6: MdTextStyleAttribute(textStyle: value),
        list: MdListAttribute(list: value),
        table: MdTableAttribute(table: value),
        code: MdCodeAttribute(codeBlock: value),
        blockquote: MdBlockQuoteAttribute(blockquote: value),
      ),
    );
  }

  MdTextStyleUtility<T> get headings {
    return MdTextStyleUtility(
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
}

@MixableEnumUtility(generateCallMethod: false)
class MarkdownAlternatingUtility<T extends Attribute>
    extends MixUtility<T, MarkdownAlternating>
    with _$MarkdownAlternatingUtility<T> {
  const MarkdownAlternatingUtility(super.builder);
}

@MixableClassUtility()
class TableColumnWidthUtility<T extends Attribute>
    extends MixUtility<T, TableColumnWidth> with _$TableColumnWidthUtility<T> {
  const TableColumnWidthUtility(super.builder);
}

@MixableClassUtility()
class TableBorderUtility<T extends Attribute> extends MixUtility<T, TableBorder>
    with _$TableBorderUtility<T> {
  const TableBorderUtility(super.builder);
}
