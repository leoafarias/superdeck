import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

import '../../helpers/measure_size.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../helpers/utils.dart';
import '../../superdeck.dart';
import 'cache_image_widget.dart';

class AnimatedMarkdownViewer extends ImplicitlyAnimatedWidget {
  final String content;
  final SlideSpec spec;

  const AnimatedMarkdownViewer({
    super.key,
    required this.content,
    required this.spec,
    required super.duration,
    super.curve = Curves.linear,
  });

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedMarkdownViewerState();
}

class _AnimatedMarkdownViewerState
    extends AnimatedWidgetBaseState<AnimatedMarkdownViewer> {
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
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        <md.InlineSyntax>[
          md.EmojiSyntax(),
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
        ],
      ),
      imageBuilder: _imageBuilder,
      builders: {
        'code': CodeElementBuilder(spec.code),
      },
      bulletBuilder: (parameters) {
        if (parameters.style == BulletStyle.orderedList) {
          final index = parameters.index + 1;
          return Text(
            '$index .',
            style: spec.list?.bulletStyle,
          );
        } else {
          return Text('•', style: spec.list?.bulletStyle);
        }
      },
      styleSheet: _styleTween!.evaluate(animation)?.toStyle(),
    );
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

Widget _imageBuilder(
  Uri uri,
  String? title,
  String? alt,
) {
  Size? size;
  return StatefulBuilder(builder: (context, setState) {
    final slideSpec = SlideSpec.of(context);

    Widget image = CacheImage(
      url: uri.toString(),
      spec: slideSpec.image,
    );

    if (size != null) {
      return ConstrainedBox(
        constraints: calculateConstraints(size!, slideSpec),
        child: image,
      );
    } else {
      return MeasureSingleWidgetSize(
        onChange: (newSize) => setState(() => size = newSize),
        child: image,
      );
    }
  });
}

class TextBuilder extends MarkdownElementBuilder {
  final TextSpec? spec;
  TextBuilder(this.spec);
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return TextSpecWidget(text.text, spec: spec);
  }
}

final List<String> _kBlockTags = <String>[
  'p',
  'h1',
  'h2',
  'h3',
  'h4',
  'h5',
  'h6',
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

const List<String> _kListTags = <String>['ul', 'ol'];

class CodeElementBuilder extends MarkdownElementBuilder {
  final MdCodeblockSpec? spec;
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
