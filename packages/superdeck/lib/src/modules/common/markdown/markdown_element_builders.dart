import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:mix/mix.dart';

import '../../../components/atoms/cache_image_widget.dart';
import '../helpers/measure_size.dart';
import '../helpers/syntax_highlighter.dart';
import '../helpers/utils.dart';
import '../styles/style_spec.dart';
import 'alert_block_syntax.dart';

class SpecMarkdownBuilders {
  final SlideSpec spec;

  const SpecMarkdownBuilders(this.spec);

  Map<String, MarkdownElementBuilder> get builders {
    return {
      'h1': HeadingTextBuilder(spec.h1),
      'h2': HeadingTextBuilder(spec.h2),
      'h3': HeadingTextBuilder(spec.h3),
      'h4': HeadingTextBuilder(spec.h4),
      'h5': HeadingTextBuilder(spec.h5),
      'h6': HeadingTextBuilder(spec.h6),
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

class HeadingTextBuilder extends MarkdownElementBuilder {
  final TextSpec? spec;
  HeadingTextBuilder(this.spec);
  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    return TextSpecWidget(
      _transformLineBreaks(text.text),
      spec: spec,
    );
  }
}

String _transformLineBreaks(String text) {
  return text.replaceAll('<br>', '\n');
}

class TextBuilder extends MarkdownElementBuilder {
  final TextSpec? spec;
  TextBuilder(this.spec);
  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    return TextSpecWidget(
      _transformLineBreaks(text.text),
      spec: spec,
    );
  }
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
    final uri = Uri.parse(element.attributes['src']!);

    return Builder(builder: (context) {
      final spacingSize = calculateSpecOffset(spec);
      return MeasureSizeBuilder(builder: (size) {
        return ConstrainedBox(
          constraints: BoxConstraints.tight((size - spacingSize) as Size),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CacheImage(
              uri: uri,
              spec: spec.image,
            ),
          ),
        );
      });
    });
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
