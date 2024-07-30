import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mix/mix.dart';
import 'package:mix_annotations/mix_annotations.dart';

part 'style_spec.g.dart';

const _mdHeading = MixableFieldDto(type: 'MdHeadingSpecAttribute');
const _mdParagraph = MixableFieldDto(type: 'MdParagraphSpecAttribute');
const _mdCode = MixableFieldDto(type: 'MdCodeblockSpecAttribute');
const _mdList = MixableFieldDto(type: 'MdListSpecAttribute');
const _mdTable = MixableFieldDto(type: 'MdTableSpecAttribute');

const _mdBlockQuote = MixableFieldDto(type: 'MdBlockquoteSpecAttribute');

@MixableSpec()
final class MdTextSpec extends Spec<MdTextSpec> with _$MdTextSpec {
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final WrapAlignment? alignment;

  const MdTextSpec({
    this.textStyle,
    this.padding,
    this.alignment,
  });
}

@MixableSpec()
final class MdHeadingSpec extends Spec<MdHeadingSpec> with _$MdHeadingSpec {
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final WrapAlignment? align;

  const MdHeadingSpec({
    this.textStyle,
    this.padding,
    this.align,
  });
}

@MixableSpec()
final class MdParagraphSpec extends Spec<MdParagraphSpec>
    with _$MdParagraphSpec {
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  const MdParagraphSpec({
    this.textStyle,
    this.padding,
  });
}

@MixableSpec()
final class MdListSpec extends Spec<MdListSpec> with _$MdListSpec {
  final double? indent;
  final TextStyle? bulletStyle;
  final EdgeInsets? bulletPadding;
  final WrapAlignment? orderedAlignment;
  final WrapAlignment? unorderedAlignment;

  const MdListSpec({
    this.indent,
    this.bulletStyle,
    this.bulletPadding,
    this.orderedAlignment,
    this.unorderedAlignment,
  });
}

@MixableSpec()
final class MdTableSpec extends Spec<MdTableSpec> with _$MdTableSpec {
  final TextStyle? headStyle;
  final TextStyle? bodyStyle;
  final TextAlign? headAlignment;
  final EdgeInsets? padding;
  final TableBorder? border;
  final TableColumnWidth? columnWidth;
  final EdgeInsets? cellPadding;

  final BoxDecoration? cellDecoration;
  final TableCellVerticalAlignment? verticalAlignment;

  const MdTableSpec({
    this.headStyle,
    this.bodyStyle,
    this.headAlignment,
    this.padding,
    this.border,
    this.columnWidth,
    this.cellPadding,
    this.cellDecoration,
    this.verticalAlignment,
  });
}

@MixableSpec()
final class MdBlockquoteSpec extends Spec<MdBlockquoteSpec>
    with _$MdBlockquoteSpec {
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final WrapAlignment? alignment;

  const MdBlockquoteSpec({
    this.textStyle,
    this.padding,
    this.decoration,
    this.alignment,
  });
}

@MixableSpec()
final class MdCodeblockSpec extends Spec<MdCodeblockSpec>
    with _$MdCodeblockSpec {
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final WrapAlignment? alignment;

  const MdCodeblockSpec({
    this.textStyle,
    this.padding,
    this.decoration,
    this.alignment,
  });
}

@MixableSpec()
final class SlideSpec extends Spec<SlideSpec> with _$SlideSpec {
  final WrapAlignment? textAlign;
  @MixableProperty(dto: _mdHeading)
  final MdHeadingSpec? h1;

  @MixableProperty(dto: _mdHeading)
  final MdHeadingSpec? h2;

  final TextStyle? a;
  final TextStyle? em;
  final TextStyle? strong;
  final TextStyle? del;
  final TextStyle? img;
  @MixableProperty(utilities: [MixableUtility(alias: 'divider')])
  final BoxDecoration? horizontalRuleDecoration;
  final TextScaler? textScaleFactor;

  @MixableProperty(dto: _mdHeading)
  final MdHeadingSpec? h3;

  @MixableProperty(dto: _mdHeading)
  final MdHeadingSpec? h4;

  @MixableProperty(dto: _mdHeading)
  final MdHeadingSpec? h5;

  @MixableProperty(dto: _mdHeading)
  final MdHeadingSpec? h6;

  @MixableProperty(dto: _mdParagraph)
  final MdParagraphSpec? paragraph;

  final TextStyle? link;
  final double? blockSpacing;

  @MixableProperty(dto: _mdBlockQuote)
  final MdBlockquoteSpec? blockquote;
  @MixableProperty(dto: _mdList)
  final MdListSpec? list;
  @MixableProperty(dto: _mdTable)
  final MdTableSpec? table;
  @MixableProperty(dto: _mdCode)
  final MdCodeblockSpec? code;
  final BoxSpec innerContainer;
  final BoxSpec outerContainer;
  final BoxSpec contentContainer;
  final ImageSpec image;
  final TextStyle? checkbox;

  static const of = _$SlideSpec.of;
  static const from = _$SlideSpec.from;

  const SlideSpec({
    this.h1,
    this.h2,
    this.h3,
    this.h4,
    this.h5,
    this.h6,
    this.paragraph,
    this.link,
    this.blockSpacing,
    this.blockquote,
    this.list,
    this.table,
    this.checkbox,
    this.code,
    this.a,
    this.em,
    this.strong,
    this.del,
    this.textAlign,
    this.img,
    this.horizontalRuleDecoration,
    this.textScaleFactor,
    BoxSpec? innerContainer,
    BoxSpec? outerContainer,
    BoxSpec? contentContainer,
    ImageSpec? image,
    super.animated,
  })  : outerContainer = outerContainer ?? const BoxSpec(),
        innerContainer = innerContainer ?? const BoxSpec(),
        contentContainer = contentContainer ?? const BoxSpec(),
        image = image ?? const ImageSpec();

  MarkdownStyleSheet toStyle() {
    return MarkdownStyleSheet(
      a: link,
      h1: h1?.textStyle,
      h1Padding: h1?.padding,
      h1Align: h1?.align ?? WrapAlignment.start,
      h2: h2?.textStyle,
      h2Padding: h2?.padding,
      h2Align: h2?.align ?? WrapAlignment.start,
      h3: h3?.textStyle,
      h3Padding: h3?.padding,
      h3Align: h3?.align ?? WrapAlignment.start,
      h4: h4?.textStyle,
      h4Padding: h4?.padding,
      h4Align: h4?.align ?? WrapAlignment.start,
      h5: h5?.textStyle,
      h5Padding: h5?.padding,
      h5Align: h5?.align ?? WrapAlignment.start,
      h6: h6?.textStyle,
      h6Padding: h6?.padding,
      h6Align: h6?.align ?? WrapAlignment.start,
      p: paragraph?.textStyle,
      pPadding: paragraph?.padding,
      textAlign: textAlign ?? WrapAlignment.start,
      blockSpacing: blockSpacing,
      blockquote: blockquote?.textStyle,
      blockquotePadding: blockquote?.padding,
      blockquoteDecoration: blockquote?.decoration,
      blockquoteAlign: blockquote?.alignment ?? WrapAlignment.start,
      listBullet: list?.bulletStyle,
      listBulletPadding: list?.bulletPadding,
      listIndent: list?.indent,
      orderedListAlign: list?.orderedAlignment ?? WrapAlignment.start,
      unorderedListAlign: list?.unorderedAlignment ?? WrapAlignment.start,
      tableHead: table?.headStyle,
      tableBody: table?.bodyStyle,
      tableHeadAlign: table?.headAlignment,
      tablePadding: table?.padding,
      tableBorder: table?.border,
      tableColumnWidth: table?.columnWidth,
      tableCellsPadding: table?.cellPadding,
      tableCellsDecoration: table?.cellDecoration,
      tableVerticalAlignment:
          table?.verticalAlignment ?? TableCellVerticalAlignment.middle,
      code: code?.textStyle,
      codeblockAlign: code?.alignment ?? WrapAlignment.start,
      codeblockPadding: code?.padding,
      codeblockDecoration: code?.decoration,
      checkbox: checkbox,
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
        paragraph: MdParagraphSpecAttribute(textStyle: value),
        h1: MdHeadingSpecAttribute(textStyle: value),
        h2: MdHeadingSpecAttribute(textStyle: value),
        h3: MdHeadingSpecAttribute(textStyle: value),
        h4: MdHeadingSpecAttribute(textStyle: value),
        h5: MdHeadingSpecAttribute(textStyle: value),
        h6: MdHeadingSpecAttribute(textStyle: value),
        list: MdListSpecAttribute(bulletStyle: value),
        table: MdTableSpecAttribute(bodyStyle: value, headStyle: value),
        code: MdCodeblockSpecAttribute(textStyle: value),
        blockquote: MdBlockquoteSpecAttribute(textStyle: value),
      ),
    );
  }

  MdHeadingSpecUtility<T> get headings {
    return MdHeadingSpecUtility(
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
