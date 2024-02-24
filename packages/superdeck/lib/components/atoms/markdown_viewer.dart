import 'package:superdeck/components/atoms/syntax_highlighter.dart';
import 'package:superdeck/helpers/scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

MarkdownStyleSheet markdownStyleSheet(BuildContext context) {
  final theme = Theme.of(context);
  final tt = theme.textTheme;
  var ss = MarkdownStyleSheet.largeFromTheme(theme);

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
    codeblockDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Colors.grey[900]!,
        width: 1,
      ),
      color: Colors.black,
    ),

    h1: tt.displayLarge,
    h1Padding: scaleEdgeInsets(ss.h1Padding!.copyWith(top: 15, bottom: 10)),
    h2: tt.displayMedium,
    h2Padding: scaleEdgeInsets(ss.h2Padding!.copyWith(top: 15, bottom: 10)),
    h3: tt.displaySmall,
    h3Padding: scaleEdgeInsets(ss.h3Padding!.copyWith(top: 15, bottom: 10)),
    h4: tt.headlineLarge,
    h4Padding: scaleEdgeInsets(ss.h4Padding!.copyWith(top: 15, bottom: 10)),
    h5: tt.headlineMedium,
    h5Padding: scaleEdgeInsets(ss.h5Padding!.copyWith(top: 15, bottom: 10)),
    h6: tt.headlineSmall,
    h6Padding: scaleEdgeInsets(ss.h6Padding!.copyWith(top: 15, bottom: 10)),
    // Content Elements
    p: tt.bodyMedium,
    pPadding: scaleEdgeInsets(ss.pPadding!),
    code: tt.bodyMedium?.copyWith(
      backgroundColor: Colors.grey[900],
    ),
    listBullet: tt.bodyMedium,
    listBulletPadding: scaleEdgeInsets(ss.listBulletPadding!),
    tableCellsPadding: scaleEdgeInsets(ss.tableCellsPadding!),
    tableHead: tt.bodyMedium,
    tableBody: tt.bodySmall,
    listIndent: Scale.scaleWidth(ss.listIndent),
    // QUOTES
    blockquoteDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.purple[100],
    ),
    blockquote: tt.bodySmall,

    blockquotePadding: scaleEdgeInsets(ss.blockquotePadding!),
  );
}

class _ContentPadding extends StatelessWidget {
  const _ContentPadding({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: 40.0.sh,
      vertical: 40.0.sh,
    );

    return Padding(
      padding: padding,
      child: child,
    );
  }
}

class SlideContent extends StatelessWidget {
  const SlideContent(this.data, {Key? key}) : super(key: key);
  final String data;
  @override
  Widget build(BuildContext context) {
    return _ContentPadding(child: MarkdownView(data));
  }
}

class MarkdownView extends StatelessWidget {
  const MarkdownView(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: data,
      styleSheet: markdownStyleSheet(context),
      selectable: true,
      imageBuilder: (uri, title, alt) {
        return LayoutBuilder(
          builder: (context, constraints) {
            Widget image;
            if (uri.scheme == 'resource') {
              // Load from asset
              String assetPath = uri.path;
              image = Image.asset(
                assetPath,
                fit: BoxFit.contain, // Maintain aspect ratio
              );
            } else {
              // Default behavior for network images
              image = Image.network(
                uri.toString(),
                fit: BoxFit.contain, // Maintain aspect ratio
              );
            }
            return Container(
              padding: const EdgeInsets.all(20.0),
              width: constraints.maxWidth,
              height: constraints.maxWidth *
                  (9 / 16), // Assuming a 16:9 aspect ratio
              child: image,
            );
          },
        );
      },
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubWeb.blockSyntaxes,
        [md.EmojiSyntax(), ...md.ExtensionSet.gitHubWeb.inlineSyntaxes],
      ),
      syntaxHighlighter: DartSyntaxBuilder(context),
    );
  }
}
