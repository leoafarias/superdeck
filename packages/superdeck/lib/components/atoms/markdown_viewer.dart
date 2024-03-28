import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_prism/flutter_prism.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:mix/mix.dart';

import '../../controllers/deck_controller.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../styles/style_spec.dart';
import '../../styles/style_util.dart';
import '../molecules/slide_view.dart';

class SlideContent extends StatelessWidget {
  const SlideContent(this.data, {required this.style, super.key});

  final String data;
  final SlideStyle style;

  @override
  Widget build(context) {
    final slideConstraints = SlideConstraints.of(context)?.constraints;

    return StyledWidgetBuilder(
        style: style.content,
        builder: (mix) {
          final spec = SlideSpec.of(mix);

          return MarkdownViewer(
            data,
            enableTaskList: true,
            enableSuperscript: false,
            enableSubscript: false,
            enableFootnote: false,
            enableImageSize: true,
            enableKbd: false,
            syntaxExtensions: const [],
            elementBuilders: const [],
            imageBuilder: (Uri uri, MarkdownImageInfo info) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: slideConstraints?.maxWidth ??
                      info.width ??
                      double.infinity,
                  maxHeight: slideConstraints?.maxHeight ??
                      info.height ??
                      double.infinity,
                ),
                child: _imageBuilder(uri, info),
              );
            },
            onTapLink: (href, title) {
              print({href, title});
            },
            highlightBuilder: (text, language, infoString) {
              // return [SyntaxHighlight.render(text, language ?? 'plain')];
              return _buildHighlight(context, text, language, infoString);
            },
            copyIconBuilder: (bool copied) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  copied ? Icons.check : Icons.copy,
                  color: spec.code?.copyIconColor ?? Colors.grey,
                  size: 28,
                ),
              );
            },
            styleSheet: spec.toStyle(),
          );
        });
  }
}

Widget _imageBuilder(Uri uri, MarkdownImageInfo info) {
  const boxFit = BoxFit.contain;

  //  check if its a local path or a network path
  if (uri.scheme == 'http' || uri.scheme == 'https') {
    return Image.network(
      uri.toString(),
      fit: boxFit,
      width: info.width,
      height: info.height,
    );
  }

  final assets = deckController.data().assets;

  final asset = assets.firstWhereOrNull(
    (element) => element.name == uri.toString(),
  );

  if (asset?.base64 != null) {
    return Image.memory(
      base64Decode(asset!.base64),
      fit: boxFit,
      width: info.width,
      height: info.height,
    );
  }

  return Image.asset(
    uri.toString(),
    fit: boxFit,
    width: info.width,
    height: info.height,
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

List<TextSpan> _buildHighlight(
  BuildContext context,
  String text,
  String? language,
  String? infoString,
) {
  final prism = Prism(
    mouseCursor: SystemMouseCursors.text,
    style: Theme.of(context).brightness == Brightness.dark
        ? const PrismStyle.dark()
        : const PrismStyle(),
  );

  final spans = prism.render(text, language ?? 'plain');
  return updateTextColor(
      spans, parseLineNumbers(infoString ?? ''), Colors.white.withOpacity(0.1));
}
