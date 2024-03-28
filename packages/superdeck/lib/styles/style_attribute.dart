import 'package:mix/mix.dart';

import 'style_dto.dart';
import 'style_spec.dart';

class SlideSpecAttribute extends SpecAttribute<SlideSpecAttribute, SlideSpec>
    with Mergeable<SlideSpecAttribute> {
  final TextStyleDto? textStyle;
  final MdTextStyleDto? headline1;
  final MdTextStyleDto? headline2;
  final MdTextStyleDto? headline3;
  final MdTextStyleDto? headline4;
  final MdTextStyleDto? headline5;
  final MdTextStyleDto? headline6;
  final MdTextStyleDto? paragraph;
  final TextStyleDto? link;
  final double? blockSpacing;
  final MdDividerDto? divider;
  final MdListDto? list;
  final MdTableDto? table;
  final MdCodeDto? code;
  final MdBlockQuoteDto? blockquote;
  final BoxSpecAttribute? innerContainer;
  final BoxSpecAttribute? outerContainer;

  const SlideSpecAttribute({
    this.textStyle,
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
    this.list,
    this.table,
    this.code,
    this.blockquote,
    this.innerContainer,
    this.outerContainer,
  });

  @override
  SlideSpecAttribute merge(SlideSpecAttribute? other) {
    return SlideSpecAttribute(
      textStyle: textStyle?.merge(other?.textStyle) ?? textStyle,
      headline1: headline1?.merge(other?.headline1) ?? headline1,
      headline2: headline2?.merge(other?.headline2) ?? headline2,
      headline3: headline3?.merge(other?.headline3) ?? headline3,
      headline4: headline4?.merge(other?.headline4) ?? headline4,
      headline5: headline5?.merge(other?.headline5) ?? headline5,
      headline6: headline6?.merge(other?.headline6) ?? headline6,
      paragraph: paragraph?.merge(other?.paragraph) ?? paragraph,
      link: link?.merge(other?.link) ?? link,
      blockSpacing: blockSpacing ?? other?.blockSpacing,
      divider: divider?.merge(other?.divider) ?? divider,
      list: list?.merge(other?.list) ?? list,
      table: table?.merge(other?.table) ?? table,
      code: code?.merge(other?.code) ?? code,
      blockquote: blockquote?.merge(other?.blockquote) ?? blockquote,
      innerContainer:
          innerContainer?.merge(other?.innerContainer) ?? innerContainer,
      outerContainer:
          outerContainer?.merge(other?.outerContainer) ?? outerContainer,
    );
  }

  @override
  SlideSpec resolve(MixData mix) {
    return SlideSpec(
      textStyle: textStyle?.resolve(mix),
      headline1: headline1?.resolve(mix),
      headline2: headline2?.resolve(mix),
      headline3: headline3?.resolve(mix),
      headline4: headline4?.resolve(mix),
      headline5: headline5?.resolve(mix),
      headline6: headline6?.resolve(mix),
      paragraph: paragraph?.resolve(mix),
      link: link?.resolve(mix),
      blockSpacing: blockSpacing,
      divider: divider?.resolve(mix),
      list: list?.resolve(mix),
      table: table?.resolve(mix),
      code: code?.resolve(mix),
      blockquote: blockquote?.resolve(mix),
      innerContainer: innerContainer?.resolve(mix),
      outerContainer: outerContainer?.resolve(mix),
    );
  }

  @override
  get props => [
        textStyle,
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
        table,
        code,
        blockquote,
        innerContainer,
        outerContainer,
      ];
}
