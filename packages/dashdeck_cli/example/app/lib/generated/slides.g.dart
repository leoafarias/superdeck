import 'package:dashdeck/dashdeck.dart';

import '../styles.dart';

const _slides = [
  Slide(
    id: 'slide_1',
    content:
        '# Flutter Design Systems Using Mix\n<!-- show -->\nLeo Farias \(@leoafarias\)',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.cover,
      image: 'https://media.giphy.com/media/hVbErjjtKCIHb24j4y/giphy.gif',
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Mixing\n\n\n```dart\n//@snippet\nfinal style = Mix\(\n    height\(50\),  \n    width\(100\),\n    bgColor\(Colors\.white\),\n    roundedTL\(20\), \n    roundedBR\(20\),\n    border\(\n        color: Colors\.black,\n        width: 4,\n    \),\n//@end-snippet\n\);\n\nreturn Box\(\n    mix: style\n\);\n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.contentLeft,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '#### Variants\n\n```dart\nfinal style = Mix\(\n    height\(100\),\n    width\(100\),\n    animated\(\),\n    rounded\(20\),\n    bgColor\(Colors\.black\),\n    textColor\(Colors\.white\),\n    align\(Alignment\.center\),\n    \(dark \| landscape\)\(\n        textColor\(Colors\.black\),\n    \),\n    dark\(  \n        bgColor\(Colors\.white\),\n    \),\n    landscape\(\n        bgColor\(Colors\.yellow\),\n    \)\n\);\n\nreturn Pressable\(\n    mix:style, \n    onPressed:\(\)\{\},  \n    child:TextMix\(\'Button\'\),\n\);\n\n```',
    options: SlideOptions(
      scrollable: true,
      layout: SlideLayout.contentLeft,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content:
        '## What is a Design System\?\n\nUm conjunto completo de padrões destinados a gerenciar o design em escala usando componentes e padrões reutilizáveis\.',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.contentLeft,
      image: 'https://media.giphy.com/media/6G48V62YlbZj1W6fso/giphy.gif',
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.bottomCenter,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content:
        '## Benefits\n\nUma linguagem unificada dentro e entre equipes multifuncionais\.\n\n- Consistência\n- Vocabulário compartilhado\n- Produto mais intuitivo\n- Aumenta a eficiência\n- Fonte central da verdade\n\n<!-- - One consistent product and service ecosystem\n- Rapid design and prototyping process\n- Easier handovers and improved collaboration\n- Allows to focus on development tasks not design -->',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.contentRight,
      image: 'https://media.giphy.com/media/yoJC2pxpca0K6v67qo/giphy.gif',
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content:
        '# Principles\n\n- Capacidade de escalar o sistema\n- Capacidade de colaborar e manter o sistema em tempo real\n- Sistema flexível o suficiente para se adaptar às demandas do projeto\.',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content: '# Flutter\n\n### Composition > Inheritance',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content:
        '## Flutter Design Primitives\n\n\n- Padding\n- Align\n- ColoredBox\n- DecoratedBox\n- Transform\n- e muitas outras\.\.\.',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content: '# Material Design',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Custom Widget \n\n```dart\nclass CustomWidget extends StatefulWidget \{\n  const CustomWidget\(\{\n    Key\? key,\n  \}\) : super\(key: key\);\n\n  @override\n  _CustomWidgetState createState\(\) => _CustomWidgetState\(\);\n\}\n\nclass _CustomWidgetState extends State<CustomWidget> \{\n  bool _isHover = false;\n  @override\n  void initState\(\) \{\n    super\.initState\(\);\n  \}\n\n  @override\n  Widget build\(BuildContext context\) \{\n    final colorScheme = Theme\.of\(context\)\.colorScheme;\n\n    return MouseRegion\(\n      onEnter: \(event\) \{\n        setState\(\(\) => _isHover = true\);\n      \},\n      onExit: \(event\) \{\n        setState\(\(\) => _isHover = false\);\n      \},\n      child: Material\(\n        elevation: _isHover \? 2 : 10,\n        child: AnimatedContainer\(\n          curve: Curves\.linear,\n          duration: const Duration\(milliseconds: 100\),\n          height: 100,\n          padding:\n              _isHover \? const EdgeInsets\.all\(20\) : const EdgeInsets\.all\(0\),\n          margin: const EdgeInsets\.symmetric\(vertical: 10\),\n          decoration: BoxDecoration\(\n            color: _isHover \? colorScheme\.secondary : colorScheme\.primary,\n            borderRadius: BorderRadius\.circular\(10\),\n          \),\n          child: Text\(\n            \'Custom Widget\',\n            style: Theme\.of\(context\)\.textTheme\.button\?\.copyWith\(\n                  color: _isHover\n                      \? colorScheme\.onSecondary\n                      : colorScheme\.onPrimary,\n                \),\n          \),\n        \),\n      \),\n    \);\n  \}\n\}\n```',
    options: SlideOptions(
      scrollable: true,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content:
        '# Mix\n\n## API simples para compor atributos de design e layout para widgets\.\n\nFacilmente estendido, substituído e combinado\n\n- Defina attributos fora do BuildContext\n- Defina e compartilhe BuildContext Design Tokens\n- Responda rapidamente às mudanças de requisitos\n- Crie designs e layouts adaptáveis com facilidade',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.cover,
      image: 'https://media.giphy.com/media/l3vRnoppYtfEbemBO/giphy.gif',
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.bottomCenter,
      styles: 'gradientMix',
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## With Mix\n\n```dart\nclass CustomMixWidget extends StatelessWidget \{\n  const CustomMixWidget\(\{Key\? key\}\) : super\(key: key\);\n\n  @override\n  Widget build\(BuildContext context\) \{\n    final style = Mix\(\n      height\(100\),\n      animated\(\),\n      marginY\(10\),\n      elevation\(10\),\n      rounded\(10\),\n      bgColor\(\$primary\),\n      textStyle\(\$button\),\n      textColor\(\$onPrimary\),\n      hover\(\n        elevation\(2\),\n        padding\(20\),\n        bgColor\(\$secondary\),\n        textColor\(\$onSecondary\),\n      \),\n    \);\n    return Box\(\n      mix: style,\n      child: const TextMix\(\'Custom Widget\'\),\n    \);\n  \}\n\}\n```',
    options: SlideOptions(
      scrollable: true,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Mixing\n\n```dart\nfinal style = Mix\(\n    height\(50\),  \n    width\(100\),\n    bgColor\(Colors\.white\),\n\);\n\nreturn Box\(\n    mix: style\n\);\n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.contentLeft,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Visual Composition\n\n\n\n```dart\nfinal style = Mix\(\n    height\(50\),  \n    width\(100\),\n    bgColor\(Colors\.white\),\n    roundedTL\(20\), \n    roundedBR\(20\),\n    border\(\n        color: Colors\.black,\n        width: 4,\n    \),\n\);\n\nreturn Box\(\n    mix: style\n\);\n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.contentLeft,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Inheritance\n\n```dart\n\nfinal base = Mix\(\n    height\(100\),\n    width\(100\),\n    bgColor\(Colors\.white\),  \n\);\n\n// final roundedElevation = base\.mix\(\n//    elevation\(4\),\n//    rounded\(10\),\n// \);\n\nfinal roundedElevation = Mix\(\n   apply\(base\),\n   elevation\(4\),\n   rounded\(10\),\n\);\n\nreturn Box\(mix: roundedElevation\);\n \n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.contentLeft,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Nesting\n\n```dart\nfinal style = Mix\(\n    height\(100\),\n    width\(100\),\n    bgColor\(Colors\.white\),\n    elevation\(4\),\n    rounded\(10\),\n    align\(Alignment\.center\),\n    textColor\(Colors\.black\)\n\);\n\nreturn Box\(\n    mix:style, \n    child:TextMix\(\'Box\'\),\n\);\n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.contentLeft,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content: '# Variants',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content:
        '### Reactive Variants\n\nAllows for reactive behavior based on BuildContext\n\n\n\n##### Pressable\n\nhover \| focus \| press \| disabled\n\n##### Breakpoints\n\nsmall \| medium \| large\n\n##### Orientation\n\nportrait \| landscape\n\n##### Theme\n\ndark \| light',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.contentLeft,
      image: 'https://media.giphy.com/media/3ov9jS8fcnj9LpzGFi/giphy.gif',
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '### Reactive Variants\n\n```dart\nfinal style = Mix\(\n    height\(100\),\n    width\(100\),\n    rounded\(20\),\n    elevation\(4\),\n    bgColor\(Colors\.white\),\n    textColor\(Colors\.black\),\n    align\(Alignment\.center\),\n    hover\(\n        bgColor\(Colors\.red\),\n        textColor\(Colors\.white\)\n    \),\n     press\(\n        bgColor\(Colors\.blue\),\n    \),\n\);\n\nreturn Pressable\(\n    mix:style, \n    onPressed:\(\)\{\},  \n    child:TextMix\(\'Button\'\),\n\);\n\n```',
    options: SlideOptions(
      scrollable: true,
      layout: SlideLayout.contentLeft,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Variant Operators\n\n```dart\nfinal style = Mix\(\n    \(hover & press\)\(\n        bgColor\(Colors\.purple\),\n    \)\n\);\n\n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content: '# Custom Variants',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '### Callable\n\n```dart\nfinal outlined = Variant\(\'outlined\'\);\n\nfinal style = Mix\(\n  bgColor\(Colors\.black\),\n  px\(10\),\n  py\(5\),\n  rounded\(10\),\n  textColor\(Colors\.white\),\n  outlined\(\n    bgColor\(Colors\.transparent\),\n    borderColor\(Colors\.black\),\n    textColor\(Colors\.black\),\n  \),\n\);\n\nreturn Pressable\(\n  mix: style,\n  variant: outlined,\n  onPressed: \(\) \{\},\n  child: const TextMix\(\'Outlined Button\'\),\n\);\n\n```',
    options: SlideOptions(
      scrollable: true,
      layout: SlideLayout.contentLeft,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.center,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '### Reactive\n\n```dart\nfinal dark = Variant\(\n  \'dark\',\n  shouldApply: \(BuildContext context\) \{\n    return Theme\.of\(context\)\.brightness == Brightness\.dark;\n  \},\n\);\n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content: '# Design Tokens',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Compatível com\n## Material Theme\n\n```dart\n\nfinal style = Mix\(\n    textStyle\(\$displayMedium\),\n    textColor\(\$primary\),\n\)\n\n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Spacing Tokens\n\n```dart\n\nfinal style = Mix\(\n    p\.large,\n    mx\.medium,\n\)\n\n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Custom Design Tokens\n\n```dart\nconst \$displayLarge = TextStyleToken\(\'displayLarge\'\);\n\n\nfinal TokenMap materialThemeTokens = \{\n  \$displayLarge: \(BuildContext context\) \{\n    return context\.textTheme\.displayLarge;\n  \},\n\}\n\nMixTheme\(\n    data: MixThemeData\(\n        designTokens: MixDesignTokens\(materialThemeTokens\)\n    \)\n\)\n\n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_2',
    content:
        '## Mix Theme\n\n```dart\nMixTheme\(\n  data: MixThemeData\(\n    space: MixThemeSpace\(\n      large: 16\.0, // 16px\n    \),\n    breakpoints: MixThemeBreakpoints\(\),\n    designTokens: MixDesignTokens\(\.\.\.\)\n  \),\n  child: \.\.;,\n\);\n```',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
  Slide(
    id: 'slide_1',
    content:
        '## Obrigado \n### @leoafarias\n### www\.fluttermix\.com\n### github\.com/leoafarias/mix',
    options: SlideOptions(
      scrollable: false,
      layout: SlideLayout.none,
      image: null,
      imageFit: ImageFit.cover,
      contentAlignment: ContentAlignment.topLeft,
      styles: null,
    ),
  ),
];
const _snippets = {};
final _mixes = {'slide_1': gradientMix};
