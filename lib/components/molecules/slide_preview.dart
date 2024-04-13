import 'package:flutter/material.dart';

import '../../helpers/measure_size.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../models/slide_model.dart';
import '../atoms/slide_view.dart';

class SlidePreview extends StatelessWidget {
  const SlidePreview({
    super.key,
    required this.slides,
    required this.controller,
  });

  final List<Slide> slides;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SlideConstraintBuilder(
      builder: (context, _) {
        return PageView.builder(
          controller: controller,
          itemCount: slides.length,
          itemBuilder: (context, idx) {
            final slide = slides[idx];
            return RepaintBoundary(
              key: slide.key,
              child: SlideView(slide),
            );
          },
        );
      },
    );
  }
}

class SlideMarkdownPreview extends StatelessWidget {
  const SlideMarkdownPreview({
    super.key,
    required this.slides,
    required this.controller,
  });

  final List<Slide> slides;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        controller: controller,
        itemCount: slides.length,
        itemBuilder: (context, idx) {
          final slide = slides[idx];
          final textSpans = SyntaxHighlight.render(slide.raw ?? '', 'markdown');

          return Container(
            color: Colors.black,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: textSpans,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
