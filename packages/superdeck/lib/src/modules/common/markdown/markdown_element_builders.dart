import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:mix/mix.dart';

import '../../../components/atoms/cache_image_widget.dart';
import '../helpers/constants.dart';
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

    final textWidget = TextSpecWidget(
      _transformLineBreaks(content),
      spec: spec,
    );

    if (tag != null) {
      return Hero(tag: tag, child: textWidget);
    }

    return textWidget;
  }
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
          flightShuttleBuilder: (flightContext, animation, flightDirection,
              fromHeroContext, toHeroContext) {
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return _buildImageWidget(uri);
              },
            );
          },
          tag: heroTag,
          child: imageWidget);
    }

    return imageWidget;
  }

  Widget _buildImageWidget(Uri uri) {
    return MeasureSizeBuilder(
      cacheKey: const Key('ImageElementBuilder'),
      builder: (measuredSize) {
        return Builder(
          builder: (context) {
            final finalSize = getSizeWithoutSpacing(
              measuredSize ?? kResolution,
              spec.contentBlock,
            );
            return ConstrainedBox(
              constraints: BoxConstraints.tight(finalSize),
              child: FittedBox(
                fit: BoxFit.contain,
                child: CacheImage(
                  uri: uri,
                  spec: spec.image,
                ),
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
