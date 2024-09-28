import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:mix/mix.dart';

import '../../../components/atoms/cache_image_widget.dart';
import '../helpers/constants.dart';
import '../helpers/controller.dart';
import '../helpers/measure_size.dart';
import '../helpers/syntax_highlighter.dart';
import '../helpers/utils.dart';
import '../styles/style_spec.dart';
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
      'img': ImageElementBuilder(spec),
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
      textWidget = Hero(
        flightShuttleBuilder: (
          context,
          animation,
          flightDirection,
          fromHeroContext,
          toHeroContext,
        ) {
          final fromBlock = Controller.of<_ElementController>(fromHeroContext);
          final toBlock = Controller.of<_ElementController>(toHeroContext);

          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return TextSpecWidget(
                lerpString(fromBlock.text, toBlock.text, animation.value),
                spec: fromBlock.spec!.lerp(toBlock.spec, animation.value),
              );
            },
          );
        },
        tag: tag,
        child: textWidget,
      );
    }

    return Provider(
      controller: _ElementController(content, spec),
      child: textWidget,
    );
  }
}

class _ElementController extends Controller {
  final String text;
  final TextSpec? spec;

  _ElementController(this.text, this.spec);
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

class ImageElementBuilder extends MarkdownElementBuilder {
  final SlideSpec spec;

  ImageElementBuilder(this.spec);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final src = element.attributes['src'];
    final heroTag = element.attributes['hero'];

    if (src == null) {
      // Handle missing 'src' attribute, e.g., return an error widget or placeholder
      return null;
    }

    final uri = Uri.parse(src);
    final imageWidget = _buildImageWidget(uri);

    if (heroTag != null) {
      return Hero(
        tag: heroTag,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildImageWidget(Uri uri) {
    return MeasureSizeBuilder(
      cacheKey: Key('image_${uri.toString()}'),
      builder: (measuredSize) {
        return Builder(
          builder: (context) {
            final finalSize = getSizeWithoutSpacing(
              measuredSize ?? kResolution,
              spec.contentBlock,
            );
            return ConstrainedBox(
              constraints: BoxConstraints.tight(finalSize),
              child: CacheDecorationImage(
                uri: uri,
                fit: BoxFit.contain,
                spec: spec.image,
              ),
            );
          },
        );
      },
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

String lerpString(String start, String end, double t) {
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