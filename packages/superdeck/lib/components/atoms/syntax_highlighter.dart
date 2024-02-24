import 'package:superdeck/helpers/scale.dart';
import 'package:superdeck/helpers/syntax_highlighter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class DartSyntaxBuilder extends SyntaxHighlighter {
  final BuildContext context;
  DartSyntaxBuilder(this.context);
  @override
  TextSpan format(String source) {
    return TextSpan(
      style: GoogleFonts.jetBrainsMonoTextTheme()
          .bodyMedium!
          .copyWith(fontSize: 16.0.sf),
      children: [DDSyntaxHighlight.highlight(source)],
    );
  }
}
