import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/syntax_highlighter.dart';
import '../../helpers/utils.dart';
import '../../models/asset_model.dart';
import '../../superdeck.dart';
import 'slide_view.dart';

class AnimatedMarkdownViewer extends ImplicitlyAnimatedWidget {
  final String content;
  final SlideSpec spec;
  final List<SlideAsset> assets;

  const AnimatedMarkdownViewer({
    super.key,
    required this.content,
    required this.spec,
    required super.duration,
    required this.assets,
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
      imageBuilder: _imageBuilder,
      onTapLink: (href, title) {
        print({href, title});
      },
      highlightBuilder: (text, language, infoString) {
        return [
          TextSpan(
            style: _styleTween!.evaluate(animation).code?.codeSpan ??
                const TextStyle(),
            children: SyntaxHighlight.render(text, language),
          ),
        ];
      },
      copyIconBuilder: (bool copied) {
        return const SizedBox();
        // return Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Icon(
        //     copied ? Icons.check : Icons.copy,
        //     color: _styleTween!.evaluate(animation).code?.copyIconColor ??
        //         Colors.grey,
        //     size: 24,
        //   ),
        // );
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

Widget _imageBuilder(
  Uri uri,
  MarkdownImageInfo info,
) {
  return Builder(
    builder: (context) {
      final size = SlideConstraints.of(context).biggest;
      final assets = superDeck.assets.watch(context);
      final spec = SlideSpec.of(context);
      final imageSpec = spec.image;
      final constraints = calculateConstraints(size, spec.contentContainer);
      return ConstrainedBox(
        constraints: constraints,
        child: AnimatedMixedImage(
          image: getImageProvider(uri.path, assets),
          spec: imageSpec.copyWith(
            width: info.width ?? imageSpec.width,
            height: info.height ?? imageSpec.height,
          ),
        ),
      );
    },
  );
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
