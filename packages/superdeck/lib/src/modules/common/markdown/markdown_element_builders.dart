import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:mix/mix.dart';

import '../../../../superdeck.dart';
import '../../../components/atoms/cache_image_widget.dart';
import '../helpers/syntax_highlighter.dart';
import '../helpers/utils.dart';
import 'alert_block_syntax.dart';

class SpecMarkdownBuilders {
  final SlideSpec spec;

  const SpecMarkdownBuilders(this.spec);

  List<md.BlockSyntax> get blockSyntaxes {
    return [
      const CustomHeaderSyntax(),
      const AlertBlockSyntax(),
    ];
  }

  List<md.InlineSyntax> get inlineSyntaxes {
    return [
      CustomImageSyntax(),
    ];
  }

  Map<String, MarkdownElementBuilder> get builders {
    return {
      'h1': TextBuilder(spec.h1),
      'h2': TextBuilder(spec.h2),
      'h3': TextBuilder(spec.h3),
      'h4': TextBuilder(spec.h4),
      'h5': TextBuilder(spec.h5),
      'h6': TextBuilder(spec.h6),
      'alert': AlertElementBuilder(spec.alert),
      'p': TextBuilder(spec.p),
      'code': CodeElementBuilder(spec.code),
      'img': ImageElementBuilder(spec.image),
      'li': TextBuilder(spec.list?.text),
    };
  }

  Map<String, MarkdownPaddingBuilder> get paddingBuilders {
    return _kBlockTags.fold(
      <String, MarkdownPaddingBuilder>{},
      (map, tag) => map..[tag] = _ZeroPaddingBuilder(),
    );
  }

  Widget Function(bool) get checkboxBuilder {
    return (bool checked) {
      final icon = checked ? Icons.check_box : Icons.check_box_outline_blank;
      return IconSpecWidget(icon, spec: spec.checkbox?.icon);
    };
  }

  Widget Function(MarkdownBulletParameters params) get bulletBuilder {
    return (parameters) {
      final contents = switch (parameters.style) {
        BulletStyle.unorderedList => '•',
        BulletStyle.orderedList => '${parameters.index + 1}.',
      };
      return TextSpecWidget(spec: spec.list?.bullet, contents);
    };
  }
}

class _ZeroPaddingBuilder extends MarkdownPaddingBuilder {
  @override
  EdgeInsets getPadding() => EdgeInsets.zero;
}

String _transformLineBreaks(String text) {
  return text.replaceAll('<br>', '\n');
}

class TextBuilder extends MarkdownElementBuilder {
  final TextSpec? spec;
  TextBuilder(this.spec);
  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    final (:tag, :content) = _getTagAndContent(text.text);

    Widget textWidget = TextSpecWidget(
      _transformLineBreaks(content),
      spec: spec,
    );

    if (tag != null) {
      textWidget = Provider(
        data: _TextElementData(
          text: content,
          spec: spec ?? const TextSpec(),
          size: Size.zero,
        ),
        child: Hero(
          flightShuttleBuilder: (
            context,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            final fromBlock = Provider.of<_TextElementData>(fromHeroContext);
            final toBlock = Provider.of<_TextElementData>(toHeroContext);

            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return TextSpecWidget(
                  _lerpString(
                    fromBlock.text,
                    toBlock.text,
                    animation.value,
                  ),
                  spec: fromBlock.spec.lerp(
                    toBlock.spec,
                    animation.value,
                  ),
                );
              },
            );
          },
          tag: tag,
          child: textWidget,
        ),
      );
    }

    return _TextElementData(
      text: content,
      spec: spec,
      child: textWidget,
    );
  }
}

class _TextElementData {
  final String text;
  final TextSpec spec;
  final Size size;

  const _TextElementData({
    required this.text,
    required this.spec,
    required this.size,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _TextElementData &&
        other.text == text &&
        other.spec == spec &&
        other.size == size;
  }

  @override
  int get hashCode => text.hashCode ^ spec.hashCode ^ size.hashCode;
}

class ImageElementBuilder extends MarkdownElementBuilder {
  final ImageSpec spec;

  ImageElementBuilder(this.spec);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final src = element.attributes['src']!;
    final heroTag = element.attributes['hero'];

    final uri = Uri.parse(src);

    final widget = Builder(builder: (context) {
      final block = Provider.of<BlockData>(context);
      final contentOffset = getSizeWithoutSpacing(block.spec.contentBlock);
      final imageOffset = getTotalModifierSpacing(block.spec.image);

      final totalSize = Size(
        block.size.width - contentOffset.dx - imageOffset.dx,
        block.size.height - contentOffset.dy - imageOffset.dy,
      );
      return AnimatedContainer(
        duration: Durations.medium1,
        constraints: BoxConstraints.tight(totalSize),
        child: FittedBox(
          fit: BoxFit.contain,
          child: CachedImage(
            uri: uri,
            spec: block.spec.image,
          ),
        ),
      );
    });

    if (heroTag != null) {
      return Hero(
        tag: heroTag,
        child: widget,
      );
    }

    return widget;
  }
}

class _ImageElementData {
  final SlideSpec spec;
  final Size size;
  final Uri uri;

  const _ImageElementData({
    required this.size,
    required this.spec,
    required this.uri,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ImageElementData &&
        other.spec == spec &&
        other.size == size &&
        other.uri == uri;
  }

  @override
  int get hashCode => spec.hashCode ^ size.hashCode ^ uri.hashCode;
}

({
  String? tag,
  String content,
}) _getTagAndContent(String text) {
  text = text.trim();
  final regExp = RegExp(r'{\.(.*?)}');

  final match = regExp.firstMatch(text);

  final tag = match?.group(1);

  final content = text.replaceAll(regExp, '').trim();

  return (
    tag: tag,
    content: content,
  );
}

class CodeElementBuilder extends MarkdownElementBuilder {
  final MarkdownCodeblockSpec? spec;
  CodeElementBuilder(this.spec);
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = 'dart';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }

    return Row(
      children: [
        Expanded(
          child: BoxSpecWidget(
            spec: spec?.container,
            child: RichText(
              text: TextSpan(
                style: spec?.textStyle,
                children: SyntaxHighlight.render(
                  element.textContent.trim(),
                  language,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final _kBlockTags = <String>[
  'p',
  'h1',
  'h2',
  'h3',
  'h4',
  'h5',
  'h6',
  'ul',
  'ol',
  'li',
  'blockquote',
  'pre',
  'ol',
  'ul',
  'hr',
  'table',
  'thead',
  'tbody',
  'tr',
  'section',
];

class CustomHeaderSyntax extends md.HeaderSyntax {
  const CustomHeaderSyntax();

  @override
  md.Node parse(md.BlockParser parser) {
    final element = super.parse(parser) as md.Element;

    final tag = _getTagAndContent(parser.lines.first.content).tag;
    if (tag != null) {
      element.attributes['hero'] = tag;
    }
    return element;
  }
}

class CustomImageSyntax extends md.InlineSyntax {
  CustomImageSyntax() : super(_pattern);

  static const String _pattern = r'!\[(.*?)\]\((.*?)\)(?:\s*\{\.([^\}]+)\})?';

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final altText = match.group(1)!;
    final url = match.group(2)!;
    final tag = match.group(3);

    final element = md.Element.empty('img');
    element.attributes['src'] = url;
    element.attributes['alt'] = altText;

    if (tag != null) {
      element.attributes['hero'] = tag;
    }

    parser.addNode(element);
    return true;
  }
}

String _lerpString(String start, String end, double t) {
  // Clamp t between 0 and 1
  t = t.clamp(0.0, 1.0);

  StringBuffer result = StringBuffer();

  if (t <= 0.5) {
    // First half: reduce start string to empty
    double progress = t / 0.5; // Normalize t to range [0,1] over [0,0.5]
    int startLength = start.length;
    int numCharsToShow = ((1 - progress) * startLength).round();

    // Take the first numCharsToShow characters from start string
    if (numCharsToShow > 0) {
      result.write(start.substring(0, numCharsToShow));
    }
  } else {
    // Second half: build up end string from empty
    double progress =
        (t - 0.5) / 0.5; // Normalize t to range [0,1] over [0.5,1]
    int endLength = end.length;
    int numCharsToShow = (progress * endLength).round();

    // Take the first numCharsToShow characters from end string
    if (numCharsToShow > 0) {
      result.write(end.substring(0, numCharsToShow));
    }
  }

  return result.toString();
}

typedef HeroFlightShuttleBuilder = Widget Function(
  Animation<double> animation,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
  Widget child,
);
