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
    return MarkdownBody(
      data: widget.content,
      extensionSet: md.ExtensionSet.gitHubFlavored,
      builders: _markdownBuilders(spec),
      paddingBuilders: _markdownPaddingBuilders(spec),
      checkboxBuilder: _markdownCheckboxBuilder(spec),
      bulletBuilder: _markdownBulletBuilder(spec),
      blockSyntaxes: const [AlertBlockSyntax()],
      styleSheet: _styleTween!.evaluate(animation)?.toStyle(),
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
    'li': TextBuilder(spec.p),
  };
}

Map<String, MarkdownPaddingBuilder> _markdownPaddingBuilders(SlideSpec spec) {
  return {
    'h1': ZeroPaddingBuilder(),
    'h2': ZeroPaddingBuilder(),
    'h3': ZeroPaddingBuilder(),
    'h4': ZeroPaddingBuilder(),
    'h5': ZeroPaddingBuilder(),
    'h6': ZeroPaddingBuilder(),
    'li': ZeroPaddingBuilder(),
    // 'p': ZeroPaddingBuilder(),
  };
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

    return Text(contents, style: spec.list?.bulletStyle);
  };
}

class ZeroPaddingBuilder extends MarkdownPaddingBuilder {
  @override
  EdgeInsets getPadding() {
    return EdgeInsets.zero;
  }
}

class HeadingTextBuilder extends MarkdownElementBuilder {
  final TextSpec? spec;
  HeadingTextBuilder(this.spec);
  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    return TextSpecWidget(
      text.text,
      spec: spec,
    );
  }
}

class TextBuilder extends MarkdownElementBuilder {
  final TextSpec? spec;
  TextBuilder(this.spec);
  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    return TextSpecWidget(
      text.text,
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
          child: Container(
            padding: spec?.padding,
            decoration: spec?.decoration,
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

List<TextSpan> updateTextColor(
  List<TextSpan> originalSpans,
  List<int> targetLines,
  Color newColor,
) {
  // Check if the target line is within the range of the list
  if (targetLines.isEmpty) {
    return originalSpans;
  }

  // Clone the original list to avoid mutating it directly
  List<TextSpan> updatedSpans = List<TextSpan>.from(originalSpans);

  // Detect line break from the list of text spans
  // This is done by checking if the previous span is a line break
  // If it is, then the current span is the start of a new line
  int line = 1;

  for (int i = 0; i < updatedSpans.length; i++) {
    if (i > 0) {
      final currentValue = updatedSpans[i].text ?? '';

      if (currentValue.startsWith('\n')) {
        line++;
      }
    }
    final originalSpan = originalSpans[i];

    final textStyle = originalSpan.style ?? const TextStyle();

    if (targetLines.contains(line)) {
      updatedSpans[i] = TextSpan(
        text: originalSpan.text,
        children: originalSpan.children,
        recognizer: originalSpan.recognizer,
        mouseCursor: originalSpan.mouseCursor,
        onEnter: originalSpan.onEnter,
        onExit: originalSpan.onExit,
        semanticsLabel: originalSpan.semanticsLabel,
        locale: originalSpan.locale,
        spellOut: originalSpan.spellOut,
        style: textStyle.copyWith(
          backgroundColor: newColor,
        ),
      );
    }
  }

  return updatedSpans;
}
