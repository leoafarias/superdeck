import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prism/flutter_prism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

import '../../helpers/scale.dart';
import '../../helpers/service_locator.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../providers/superdeck_provider.dart';
import 'slide_wrapper.dart';

class SlideContent extends StatelessWidget {
  const SlideContent(this.data, {Key? key}) : super(key: key);
  final String data;
  @override
  Widget build(BuildContext context) {
    return MarkdownView(data);
  }
}

class MarkdownView extends StatelessWidget {
  const MarkdownView(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(context) {
    final slideConstraints = SlideConstraints.of(context)?.constraints;
    final baseTextStyle = GoogleFonts.inter().copyWith(fontSize: 22.sf);
    final jetBrainsTextStyle =
        GoogleFonts.jetBrainsMono().copyWith(fontSize: 22.sf);
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
            maxWidth:
                slideConstraints?.maxWidth ?? info.width ?? double.infinity,
            maxHeight:
                slideConstraints?.maxHeight ?? info.height ?? double.infinity,
          ),
          child: _imageBuilder(uri, info),
        );
      },
      onTapLink: (href, title) {
        print({href, title});
      },
      highlightBuilder: (text, language, infoString) {
        return _buildHighlight(context, text, language, infoString);
      },
      copyIconBuilder: _copyIconBuilder,
      styleSheet: MarkdownStyle(
        textStyle: baseTextStyle,
        blockSpacing: 8.sf,
        headline1: baseTextStyle.copyWith(
          fontSize: 72.sf,
          fontWeight: FontWeight.bold,
        ),
        headline2: baseTextStyle.copyWith(
          fontSize: 48.sf,
        ),
        headline3: baseTextStyle.copyWith(
          fontSize: 36.sf,
          fontWeight: FontWeight.bold,
        ),
        headline4: baseTextStyle.copyWith(
          fontSize: 30.sf,
        ),
        headline5: baseTextStyle.copyWith(
          fontSize: 24.sf,
          fontWeight: FontWeight.bold,
        ),
        headline6: baseTextStyle.copyWith(
          fontWeight: FontWeight.bold,
        ),
        paragraph: baseTextStyle,
        link: baseTextStyle.copyWith(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        // PADDING
        h1Padding: EdgeInsets.only(bottom: 12.sf),
        h2Padding: EdgeInsets.only(bottom: 9.sf),
        h3Padding: EdgeInsets.only(bottom: 6.sf),
        h4Padding: EdgeInsets.only(bottom: 4.sf),
        h5Padding: EdgeInsets.only(bottom: 3.sf),
        h6Padding: EdgeInsets.only(bottom: 3.sf),
        paragraphPadding: EdgeInsets.only(bottom: 12.sf),
        // BLOCKQUOTE
        blockquote: baseTextStyle,
        blockquotePadding: EdgeInsets.only(bottom: 12.sf),
        blockquoteContentPadding: EdgeInsets.only(left: 12.sf),
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 10.sh,
            ),
          ),
          // color: Colors.grey.withOpacity(0.1),
          // borderRadius: BorderRadius.circular(10.sf),
        ),
        // CODE
        codeSpan: jetBrainsTextStyle,
        codeblockPadding: EdgeInsets.all(24.sh),
        codeBlock: jetBrainsTextStyle,
        copyIconColor: Colors.grey,
        codeblockDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.grey,
            width: 1.sh,
          ),
          borderRadius: BorderRadius.circular(10.sf),
        ),
        // LIST
        list: baseTextStyle.copyWith(),
        listItem: baseTextStyle.copyWith(),
        listItemMarker: baseTextStyle.copyWith(),
        listItemMarkerTrailingSpace: 12.sf,

        listItemMinIndent: 12.sf,

        // TABLE
        tableCellPadding: EdgeInsets.all(12.sf),
        tableBorder: TableBorder.all(
          color: Colors.grey,
          width: 2.sh,
        ),
        tableRowDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
        ),
        table: baseTextStyle.copyWith(),
        tableHead: baseTextStyle.copyWith(fontWeight: FontWeight.bold),
        tableBody: baseTextStyle.copyWith(),

        // DIVIDER
        dividerHeight: 0.sv,
        dividerColor: Colors.grey,
        dividerThickness: 2.sv,
      ),
    );
  }
}

Widget _copyIconBuilder(bool copied) {
  return Padding(
    padding: EdgeInsets.all(16.0.sh),
    child: Icon(
      copied ? Icons.check : Icons.copy,
      color: Colors.grey,
      size: 28.sf,
    ),
  );
}

Widget _imageBuilder(Uri uri, MarkdownImageInfo info) {
  final controller = getIt<SuperDeckController>();

  //  check if its a local path or a network path
  if (uri.scheme == 'http' || uri.scheme == 'https') {
    return Image.network(
      uri.toString(),
      fit: BoxFit.scaleDown,
      width: info.width,
      height: info.height,
    );
  }

  final assets = controller.data().assets;

  final asset = assets.firstWhereOrNull(
    (element) => element.name == uri.toString(),
  );

  // get a base64imagestring and convert it to an image
  Image base64StringToImage(String base64Image) {
    return Image.memory(
      base64Decode(base64Image),
      fit: BoxFit.scaleDown,
      width: info.width,
      height: info.height,
    );
  }

  if (asset?.base64 != null) {
    return base64StringToImage(asset!.base64);
  }

  return Image.asset(
    uri.toString(),
    fit: BoxFit.contain,
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
