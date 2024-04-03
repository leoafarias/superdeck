import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers/controller.dart';
import '../../helpers/measure_size.dart';
import '../../models/slide_options_model.dart';
import '../../styles/style_spec.dart';
import '../atoms/markdown_viewer.dart';

class SlideContent extends StatelessWidget {
  const SlideContent({
    required this.content,
    required this.alignment,
    super.key,
  });

  final String content;

  final ContentAlignment alignment;

  @override
  Widget build(context) {
    final mix = MixProvider.of(context);
    final spec = SlideSpec.of(mix);
    final container = spec.contentContainer;

    final assets = SuperDeck.assetsOf(context);

    return SlideConstraintBuilder(
      builder: (context, size) {
        return Column(
          mainAxisAlignment: alignment.toMainAxisAlignment(),
          crossAxisAlignment: alignment.toCrossAxisAlignment(),
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: size.height,
                maxWidth: size.width,
              ),
              child: SingleChildScrollView(
                child: AnimatedMixedBox(
                  duration: const Duration(milliseconds: 300),
                  spec: spec.contentContainer,
                  child: AnimatedMarkdownViewer(
                    content: content,
                    spec: spec,
                    assets: assets,
                    constraints: _calculateConstraints(size, container),
                    duration: const Duration(milliseconds: 300),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

BoxConstraints _calculateConstraints(Size size, BoxSpec spec) {
  final padding = spec.padding ?? EdgeInsets.zero;
  final margin = spec.margin ?? EdgeInsets.zero;

  double horizontalBorder = 0.0;
  double verticalBorder = 0.0;

  if (spec.decoration is BoxDecoration) {
    final border = (spec.decoration as BoxDecoration).border;
    if (border != null) {
      horizontalBorder = border.dimensions.horizontal;
      verticalBorder = border.dimensions.vertical;
    }
  }

  final horizontalSpacing =
      padding.horizontal + margin.horizontal + horizontalBorder;
  final verticalSpacing = padding.vertical + margin.vertical + verticalBorder;

  return BoxConstraints(
    maxHeight: size.height - verticalSpacing,
    maxWidth: size.width - horizontalSpacing,
  );
}
