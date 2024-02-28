import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../helpers/scale.dart';
import '../../helpers/syntax_highlighter.dart';
import 'markdown_configs.dart';
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
        linesMargin: EdgeInsets.symmetric(vertical: 10.0.sv),
        generators: 
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
          const CodeConfig(style: TextStyle(backgroundColor: Colors.red)),
          const ListConfig(marker: _markerBuilder),
          // const TableConfig(),
          const ImgConfig(builder: _imageBuilder),
          // const HrConfig(),
          // const LinkConfig(),
          const BlockquoteConfig(),
        ],
      ),
    );
  }
}

Widget _codeBuilder(String language, String value) {
  final textSpan = SyntaxHighlight.render(language, value);
  return Text.rich(
    textSpan,
    style: TextStyle(fontSize: 24.0.sf),
  );
}

Widget _markerBuilder(bool hasMarker, int index, int depth) {
  return const Text('•');
}



Widget _imageBuilder(String src, Map<String, String> attributes) {
  double? width;
  double? height;
  if (attributes['width'] != null) width = double.parse(attributes['width']!);
  if (attributes['height'] != null) {
    height = double.parse(attributes['height']!);
  }
  final imageUrl = attributes['src'] ?? '';
  final alt = attributes['alt'] ?? '';
  final isNetImage = imageUrl.startsWith('http');

  return Builder(builder: (BuildContext context) {
    final constraints = SlideConstraints.of(context)!.constraints;
    final imgWidget = isNetImage
        ? Image.network(imageUrl,
            width: width,
            height: height,
            fit: BoxFit.scaleDown, errorBuilder: (ctx, error, stacktrace) {
            return buildErrorImage(imageUrl, alt, error);
          })
        : Image.asset(imageUrl,
            width: width,
            height: height,
            fit: BoxFit.scaleDown, errorBuilder: (ctx, error, stacktrace) {
            return buildErrorImage(imageUrl, alt, error);
          });
    // Max constraints passed down to the child
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
      ),
      child: imgWidget,
    );
  });
}

Widget buildErrorImage(String url, String alt, Object? error) {
  return ProxyRichText(
    TextSpan(children: [
      const WidgetSpan(
        child: Icon(
          Icons.broken_image,
          color: Colors.redAccent,
        ),
      ),
      TextSpan(text: alt),
    ]),
  );
}
