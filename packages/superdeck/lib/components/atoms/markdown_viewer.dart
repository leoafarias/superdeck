import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

import '../../helpers/constants.dart';
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
  Size? _size;

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
    return MeasureSingleWidgetSize(
      onChange: (size) {
        setState(() {
          _size = size;
        });
      },
      child: MarkdownBody(
        data: widget.content,
        extensionSet: md.ExtensionSet(
          md.ExtensionSet.gitHubFlavored.blockSyntaxes,
          <md.InlineSyntax>[
            md.EmojiSyntax(),
            ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
          ],
        ),
        imageBuilder: (uri, title, alt) {
          return _imageBuilder(uri, title, alt, size: _size ?? kResolution);
        },
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
      ),
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
  String? alt, {
  required Size size,
}) {
  return Builder(builder: (context) {
    final slideSpec = SlideSpec.of(context);

    return ConstrainedBox(
      constraints: calculateConstraints(size, slideSpec),
      child: CacheImage(
        uri: uri,
        spec: slideSpec.image,
      ),
    );
  });
}

class TextBuilder extends MarkdownElementBuilder {
  final MdTextSpec? spec;
  TextBuilder(this.spec);
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return Padding(
      padding: spec?.padding ?? EdgeInsets.zero,
      child: Text(
        text.text,
        style: spec?.textStyle,
      ),
    );
  }
}

class HeadingTextBuilder extends MarkdownElementBuilder {
  final MdHeadingSpec? spec;
  HeadingTextBuilder(this.spec);
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final level = int.parse(element.tag.substring(1));
    final style = spec?.textStyle;

    return Padding(
      padding: spec?.padding ?? EdgeInsets.zero,
      child: AutoSizeText(
        element.textContent,
        style: style?.copyWith(
          fontSize: style.fontSize! + (6 - level) * 4,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

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

class SampleCodeElementBuilder extends MarkdownElementBuilder {
  final MdCodeblockSpec? spec;
  SampleCodeElementBuilder(this.spec);
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
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
