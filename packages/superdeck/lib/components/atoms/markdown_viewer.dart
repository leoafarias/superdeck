import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:mix/mix.dart';

import '../../helpers/syntax_highlighter.dart';
import '../../models/slide_asset_model.dart';
import '../../styles/style_spec.dart';

class AnimatedMarkdownViewer extends ImplicitlyAnimatedWidget {
  final String content;
  final SlideSpec spec;
  final List<SlideAsset> assets;
  final BoxConstraints constraints;

  const AnimatedMarkdownViewer({
    super.key,
    required this.content,
    required this.spec,
    required super.duration,
    required this.assets,
    required this.constraints,
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
    return MarkdownViewer(
      widget.content,
      enableTaskList: true,
      enableSuperscript: false,
      enableSubscript: false,
      enableFootnote: false,
      enableImageSize: true,
      enableKbd: false,
      syntaxExtensions: const [],
      elementBuilders: const [],
      imageBuilder: _imageBuilder(widget.assets, widget.constraints),
      onTapLink: (href, title) {
        print({href, title});
      },
      highlightBuilder: (text, language, infoString) {
        return [
          TextSpan(
            style: _styleTween!.evaluate(animation).code?.codeSpan ??
                const TextStyle(),
            children: SyntaxHighlight.render(text, language ?? 'simple'),
          ),
        ];
      },
      copyIconBuilder: (bool copied) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            copied ? Icons.check : Icons.copy,
            color: _styleTween!.evaluate(animation).code?.copyIconColor ??
                Colors.grey,
            size: 28,
          ),
        );
      },
      styleSheet: _styleTween!.evaluate(animation).toStyle(),
    );
  }
}

class SlideSpecTween extends Tween<SlideSpec> {
  SlideSpecTween({super.begin, super.end});
  @override
  SlideSpec lerp(double t) {
    return begin?.lerp(end!, t) ?? end ?? const SlideSpec.empty();
  }
}

Widget Function(Uri, MarkdownImageInfo) _imageBuilder(
    List<SlideAsset> assets, BoxConstraints constraints) {
  return (
    Uri uri,
    MarkdownImageInfo info,
  ) {
    const boxFit = BoxFit.contain;

    Widget current;

    //  check if its a local path or a network path
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      current = CachedNetworkImage(
        imageUrl: uri.toString(),
        fit: boxFit,
        width: info.width,
        height: info.height,
      );
    } else {
      final asset =
          assets.firstWhereOrNull((element) => element.name == uri.toString());

      if (asset?.base64 != null) {
        current = Image.memory(
          base64Decode(asset!.base64),
          fit: boxFit,
          width: info.width,
          height: info.height,
        );
      } else {
        current = Image.asset(
          uri.toString(),
          fit: boxFit,
          width: info.width,
          height: info.height,
        );
      }
    }

    return ConstrainedBox(constraints: constraints, child: current);
  };
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

/// Parses a block padding, including:
///
/// 1. Remove `top` when it is the first child.
/// 2. Remove `bottom` when it is the last child.
EdgeInsets? parseBlockPadding(EdgeInsets? padding, SiblingPosition position) {
  if (padding == null || padding == EdgeInsets.zero) {
    return null;
  }

  final isLast = position.index + 1 == position.total;
  final isFirst = position.index == 0;

  if (!isLast && !isFirst) {
    return padding;
  }

  var top = padding.top;
  var bottom = padding.bottom;

  if (isFirst && isLast) {
    top = 0;
    bottom = 0;
  } else if (isFirst) {
    top = 0;
  } else if (isLast) {
    bottom = 0;
  }

  return padding.copyWith(
    top: top,
    bottom: bottom,
    left: padding.left,
    right: padding.right,
  );
}
