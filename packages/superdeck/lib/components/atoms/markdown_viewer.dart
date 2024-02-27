import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../helpers/scale.dart';
import '../../helpers/syntax_highlighter.dart';
import 'markdown_configs.dart';

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
  Widget build(context) {
    return buildMarkdown(context);
  }

  Widget buildMarkdown(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final config =
        isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;

    return MarkdownWidget(
      data: data,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      markdownGenerator: MarkdownGenerator(
        linesMargin: EdgeInsets.symmetric(vertical: 10.0.sh),
      ),
      config: config.copy(
        configs: [
          CustomH1Config(
            style: TextStyle(
              fontSize: Scale.scaleFont(72),
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomH2Config(
            style: TextStyle(
              fontSize: Scale.scaleFont(48),
            ),
          ),
          CustomH3Config(
            style: TextStyle(
              fontSize: Scale.scaleFont(36),
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomH4Config(
            style: TextStyle(
              fontSize: Scale.scaleFont(30),
            ),
          ),
          CustomH5Config(
            style: TextStyle(
              fontSize: Scale.scaleFont(24),
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomH6Config(
            style: TextStyle(
              fontSize: Scale.scaleFont(20),
            ),
          ),
          PreConfig(
            builder: _codeBuilder,
            textStyle: TextStyle(
              fontSize: Scale.scaleFont(16),
            ),
          ),
          PConfig(
            textStyle: TextStyle(
              fontSize: Scale.scaleFont(16),
            ),
          ),
          const ListConfig(),
          const TableConfig(),
          const ImgConfig(),
          const CodeConfig(style: TextStyle(backgroundColor: Colors.red)),
          const HrConfig(),
          const LinkConfig(),
          const BlockquoteConfig(),
        ],
      ),
    );
  }

  Widget _codeBuilder(String language, String value) {
    final textSpan = SyntaxHighlight.render(language, value);
    return Text.rich(textSpan);
  }
}
