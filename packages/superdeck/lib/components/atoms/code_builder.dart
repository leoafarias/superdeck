import 'package:flutter/material.dart';
import 'package:flutter_prism/flutter_prism.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

class CodeBlockBuilder extends MarkdownElementBuilder {
  CodeBlockBuilder({
    TextStyle? textStyle,
    super.context,
    this.padding,
    this.decoration,
    this.highlightBuilder,
    this.copyIconBuilder,
    this.copyIconColor,
  }) : super(
            textStyle: TextStyle(
          color: MediaQuery.platformBrightnessOf(context!) == Brightness.dark
              ? const Color(0xffcccccc)
              : const Color(0xff333333),
        ).merge(textStyle));

  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final MarkdownHighlightBuilder? highlightBuilder;
  final CopyIconBuilder? copyIconBuilder;
  final Color? copyIconColor;

  @override
  final matchTypes = ['codeBlock'];

  @override
  bool replaceLineEndings(String type) => false;

  @override
  TextAlign textAlign(parent) => TextAlign.start;

  @override
  TextSpan buildText(text, parent) {
    final textContent = text.trimRight();
    final style = const TextStyle(fontFamily: 'monospace').merge(parent.style);

    final spans = _buildHighlight(
      context!,
      textContent,
      parent.attributes['language'],
      parent.attributes['infoString'],
    );

    if (spans.isEmpty) {
      return const TextSpan(text: '');
    }

    return TextSpan(
        children: spans, style: style, mouseCursor: renderer.mouseCursor);
  }

  @override
  Widget buildWidget(element, parent) {
    Color backgroundColor;
    if (darkMode) {
      backgroundColor = const Color(0xff101010);
    } else {
      backgroundColor = const Color(0xfff0f0f0);
    }

    const defaultPadding = EdgeInsets.all(15.0);
    final defaultDecoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(5),
    );

    Widget child;
    if (element.children.isNotEmpty) {
      final textWidget = element.children.single;
      child = Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: padding ?? defaultPadding,
          child: textWidget,
        ),
      );
    } else {
      child = const SizedBox(height: 15);
    }

    return Container(
      width: double.infinity,
      decoration: decoration ?? defaultDecoration,
      child: child,
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

  List<TextSpan> newSpans = [];

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

    newSpans.add(originalSpan);

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

//  Similar to the updatedTextColor function
// I want you to add every new line to a new TextSpan(children: [TextSpan])
// Everytime you encounter a new line, you create a new TextSpan and start to add the children to it

List<TextSpan> _addTextSpansPerLine(
  List<TextSpan> originalSpans,
) {
  //  Each span is a line
  List<TextSpan> lineSpans = [];

  // New spans to be added to each line after
  List<TextSpan> newSpans = [];

  // Clone the original list to avoid mutating it directly
  List<TextSpan> updatedSpans = List<TextSpan>.from(originalSpans);

  // Detect line break from the list of text spans
  // This is done by checking if the previous span is a line break
  // If it is, then the current span is the start of a new line

  for (int i = 0; i < updatedSpans.length; i++) {
    // Detect if the current span is a line break
    // If it is, then the current span is the start of a new line
    // Add the lineSpans to the newSpans and reset the lineSpans
    if (i > 0) {
      final currentValue = updatedSpans[i].text ?? '';

      if (currentValue.startsWith('\n')) {
        lineSpans.add(TextSpan(children: newSpans));
        newSpans = [];
      } else {
        newSpans.add(updatedSpans[i]);
      }
    }

    // Add the last lineSpans to the newSpans
    if (i == updatedSpans.length - 1) {
      lineSpans.add(TextSpan(children: newSpans));
    }
  }

  return lineSpans;
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

  return prism.render(text, language ?? 'plain');
}
