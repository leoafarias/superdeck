import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../models/options_model.dart';
import '../../providers/slide_provider.dart';
import '../../styles/style_spec.dart';
import '../atoms/markdown_viewer.dart';

class SlideContent extends StatelessWidget {
  const SlideContent({
    required this.data,
    required this.options,
    super.key,
  });

  final String data;
  final ContentOptions? options;

  @override
  Widget build(context) {
    final spec = SlideSpec.of(context);

    final alignment = options?.alignment ?? ContentAlignment.center;

    final assets = SlideProvider.assetsOf(context);
    final isExporting = SlideProvider.isSnapshotOf(context);

    Widget child = IntrinsicWidth(
      child: AnimatedMarkdownViewer(
        content: data,
        spec: spec,
        assets: assets,
        duration: Durations.medium1,
      ),
    );

    if (!isExporting) {
      child = SingleChildScrollView(
        child: child,
      );
    } else {
      child = Wrap(
        clipBehavior: Clip.hardEdge,
        children: [
          child,
        ],
      );
    }

    return AnimatedMixedBox(
      duration: const Duration(milliseconds: 300),
      spec: spec.contentContainer.copyWith(
        alignment: alignment.toAlignment(),
      ),
      child: child,
    );
  }
}
