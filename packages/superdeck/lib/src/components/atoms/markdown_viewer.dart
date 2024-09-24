import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:mix/mix.dart';

import '../../modules/common/helpers/syntax_highlighter.dart';
import '../../modules/common/styles/style_spec.dart';
import '../markdown/alert_block_syntax.dart';
import '../molecules/block_widget.dart';
import 'cache_image_widget.dart';

class MarkdownViewer extends ImplicitlyAnimatedWidget {
  final String content;
  final SlideSpec spec;

  const MarkdownViewer({
    super.key,
    required this.content,
    required this.spec,
    required super.duration,
    super.curve = Curves.linear,
  });

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _MarkdownViewerState();
}

class _MarkdownViewerState extends AnimatedWidgetBaseState<MarkdownViewer> {
  SlideSpecTween? _styleTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _styleTween = visitor(
      _styleTween,
      widget.spec,
      (dynamic value) => SlideSpecTween(begin: value),
    ) as SlideSpecTween?;
  }

  @override
  Widget build(BuildContext context) {
    final spec = _styleTween!.evaluate(animation) ?? const SlideSpec();
    return _MarkdownBuilder(
      content: widget.content,
      spec: spec,
    );
  }
}

class _MarkdownBuilder extends StatelessWidget {
  final String content;
  final SlideSpec spec;

  const _MarkdownBuilder({
    required this.content,
    required this.spec,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: MarkdownBody(
        data: content,
        extensionSet: md.ExtensionSet.gitHubWeb,
        builders: _markdownBuilders(spec),
        paddingBuilders: _markdownPaddingBuilders(spec),
        checkboxBuilder: _markdownCheckboxBuilder(spec),
        bulletBuilder: _markdownBulletBuilder(spec),
        blockSyntaxes: const [AlertBlockSyntax()],
        styleSheet: spec.toStyle(),
      ),
    );
  }
}

Map<String, MarkdownElementBuilder> _markdownBuilders(SlideSpec spec) {
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
    'img': ImageElementBuilder(spec.image),
    'li': TextBuilder(spec.list?.text),
  };
}

Map<String, MarkdownPaddingBuilder> _markdownPaddingBuilders(SlideSpec spec) {
  return _kBlockTags.fold(
    <String, MarkdownPaddingBuilder>{},
    (map, tag) => map..[tag] = ZeroPaddingBuilder(),
  );
}

Widget Function(bool) _markdownCheckboxBuilder(SlideSpec spec) {
  return (bool checked) {
    final icon = checked ? Icons.check_box : Icons.check_box_outline_blank;
    return IconSpecWidget(icon, spec: spec.checkbox?.icon);
  };
}

Widget Function(MarkdownBulletParameters params) _markdownBulletBuilder(
  SlideSpec spec,
) {
  return (parameters) {
    final contents = switch (parameters.style) {
      BulletStyle.unorderedList => '•',
      BulletStyle.orderedList => '${parameters.index + 1}.',
    };

    return TextSpecWidget(spec: spec.list?.bullet, contents);
  };
}

class ZeroPaddingBuilder extends MarkdownPaddingBuilder {
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
  final ImageSpec? spec;
  ImageElementBuilder(this.spec);
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final uri = Uri.parse(element.attributes['src']!);

    return Builder(builder: (context) {
      final size = BlockProvider.of(context).size;

      return ConstrainedBox(
        constraints: BoxConstraints.tight(size),
        child: FittedBox(
          fit: BoxFit.contain,
          child: CacheImage(
            uri: uri,
            spec: spec ?? const ImageSpec(),
          ),
        ),
      );
    });
  }
}

final _classRegex = RegExp(r'^(.*?)(\s*\{\.([^\}\s]+)\})\s*$');

class SdHeaderSyntax extends md.HeaderSyntax {
  const SdHeaderSyntax();

  @override
  bool canParse(md.BlockParser parser) {
    return pattern.hasMatch(parser.current.content) &&
        _classRegex.hasMatch(parser.current.content);
  }

  @override
  md.Node parse(md.BlockParser parser) {
    final match = _classRegex.firstMatch(parser.current.content)!;
    parser.advance();

    final className = match[3];

    final element = super.parse(parser) as md.Element;

    return element..generatedId = className;
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
