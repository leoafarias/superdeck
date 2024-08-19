import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../models/options_model.dart';
import '../../providers/snapshot_provider.dart';
import '../../styles/style_spec.dart';
import '../atoms/cache_image_widget.dart';
import '../atoms/markdown_viewer.dart';

class SlideContent extends StatelessWidget {
  const SlideContent({
    required this.content,
    required this.options,
    super.key,
  });

  final String content;

  final ContentOptions? options;

  @override
  Widget build(context) {
    final spec = SlideSpec.of(context);
    final isCapturing = SnapshotProvider.isCapturingOf(context);
    final alignment = options?.align ?? ContentAlignment.center;

    Widget child = AnimatedBoxSpecWidget(
      duration: const Duration(milliseconds: 300),
      spec: spec.contentContainer,
      child: AnimatedMarkdownViewer(
        content: content,
        spec: spec,
        duration: Durations.medium1,
      ),
    );

    if (!isCapturing) {
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
    return AnimatedBoxSpecWidget(
      spec: spec.innerContainer,
      duration: const Duration(milliseconds: 300),
      child: Align(
        alignment: alignment.toAlignment(),
        child: child,
      ),
    );
  }
}

class ImageContent extends StatelessWidget {
  const ImageContent({
    required this.options,
    super.key,
  });

  final ImageOptions options;

  @override
  Widget build(context) {
    final spec = SlideSpec.of(context);
    final alignment = options.align ?? ContentAlignment.center;

    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        image: DecorationImage(
          alignment: alignment.toAlignment(),
          image: getImageProvider(options.src),
          fit: options.fit?.toBoxFit() ?? BoxFit.cover,
        ),
      ),
      child: AnimatedBoxSpecWidget(
        duration: const Duration(milliseconds: 300),
        spec: spec.contentContainer,
        child: Container(),
      ),
    );
  }
}
