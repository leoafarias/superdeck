import 'package:dash_deck/components/atoms/syntax_highlighter.dart';
import 'package:dash_deck/helpers/scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

MarkdownStyleSheet markdownStyleSheet(BuildContext context) {
  final theme = Theme.of(context);
  final tt = theme.textTheme;
  final ss = MarkdownStyleSheet.fromTheme(theme);

  EdgeInsets scaleEdgeInsets(EdgeInsets edgeInsets) {
    return EdgeInsets.only(
      top: edgeInsets.top.sh,
      bottom: edgeInsets.bottom.sh,
      left: edgeInsets.left.sv,
      right: edgeInsets.right.sv,
    );
  }

  return ss.copyWith(
    codeblockPadding: EdgeInsets.symmetric(
      vertical: 20.0.sv,
      horizontal: 20.0.sh,
    ),
    codeblockDecoration: const BoxDecoration(
      color: Colors.black,
    ),
    code: ss.code?.copyWith(
      fontSize: Scale.scaleFont(14),
      height: 1.6,
    ),
    h1: tt.displayLarge,
    h1Padding: scaleEdgeInsets(ss.h1Padding!),
    h2: tt.displayMedium,
    h2Padding: scaleEdgeInsets(ss.h2Padding!),
    h3: tt.displaySmall,
    h3Padding: scaleEdgeInsets(ss.h3Padding!),
    h4: tt.headlineLarge,
    h4Padding: scaleEdgeInsets(ss.h4Padding!),
    h5: tt.headlineMedium,
    h5Padding: scaleEdgeInsets(ss.h5Padding!),
    h6: tt.headlineSmall,
    h6Padding: scaleEdgeInsets(ss.h6Padding!),
    p: tt.bodyLarge,
    pPadding: scaleEdgeInsets(ss.pPadding!),
    blockquote: tt.bodyLarge,
    blockSpacing: Scale.scaleHeight(ss.blockSpacing),
    blockquotePadding: scaleEdgeInsets(ss.blockquotePadding!),
    blockquoteDecoration: const BoxDecoration(color: Colors.transparent),
    listBullet: tt.bodyLarge,
    listBulletPadding: scaleEdgeInsets(ss.listBulletPadding!),
    tableCellsPadding: scaleEdgeInsets(ss.tableCellsPadding!),
    listIndent: Scale.scaleWidth(ss.listIndent),
  );
}

class MarkdownViewer extends StatelessWidget {
  const MarkdownViewer(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: data,
      styleSheet: markdownStyleSheet(context),
      selectable: false,
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubWeb.blockSyntaxes,
        [md.EmojiSyntax(), ...md.ExtensionSet.gitHubWeb.inlineSyntaxes],
      ),
      syntaxHighlighter: DartSyntaxBuilder(),
    );
  }
}
