import 'package:flutter/material.dart';

import '../../helpers/measure_size.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../atoms/markdown_viewer.dart';
import '../atoms/slide_view.dart';

class SlidePreview extends StatelessWidget {
  const SlidePreview({
    super.key,
    required this.slide,
    required this.size,
    required this.sideWidth,
  });

  final Slide slide;

  final Size size;
  final double sideWidth;

  @override
  Widget build(BuildContext context) {
    final paddingSize = sideWidth / 20;

    final rightWidth = size.width - sideWidth;
    final rightHeight = size.height * (rightWidth / size.width);
    final rightSize = Size(rightWidth - (paddingSize * 2), rightHeight);

    return Container(
      color: const Color.fromARGB(144, 0, 0, 0),
      child: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(rightSize),
          child: Container(
            margin: EdgeInsets.all(paddingSize),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: SlideConstraintBuilder(
              builder: (context, _) {
                return SlideView(slide);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SlideMarkdownPreview extends StatelessWidget {
  const SlideMarkdownPreview({
    super.key,
    required this.slide,
  });

  final Slide slide;

  @override
  Widget build(BuildContext context) {
    final rawYaml = slide.raw ?? '';
    final options = '#### Options\n```yaml\n${rawYaml.trim()}\n```\n';
    final data = '#### Content\n```markdown\n${slide.data}\n```\n';
    return MixBuilder(
      style: defaultStyle.merge(
        Style(
          $.code.span.fontSize(14),
        ),
      ),
      builder: (mix) {
        return SlideConstraintBuilder(
          builder: (context, size) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(40.0),
              child: AnimatedMarkdownViewer(
                content: "$options\n$data\n",
                constraints: BoxConstraints(
                  maxHeight: size.height,
                  maxWidth: size.width,
                ),
                spec: SlideSpec.of(mix),
                assets: const [],
                duration: Duration.zero,
              ),
            );
          },
        );
      },
    );
  }
}
