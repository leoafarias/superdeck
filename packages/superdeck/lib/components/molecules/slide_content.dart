import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../providers/examples_provider.dart';
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
        alignment: toAlignment(alignment),
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
    final imageFit = options.fit ?? ImageFit.cover;

    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        image: DecorationImage(
            alignment: toAlignment(alignment),
            image: getImageProvider(options.src),
            fit: toBoxFit(imageFit)),
      ),
      child: AnimatedBoxSpecWidget(
        duration: const Duration(milliseconds: 300),
        spec: spec.contentContainer,
        child: Container(),
      ),
    );
  }
}

class WidgetContent extends StatelessWidget {
  const WidgetContent({
    required this.options,
    super.key,
  });

  final WidgetOptions options;

  @override
  Widget build(context) {
    final spec = SlideSpec.of(context);
    final alignment = options.align ?? ContentAlignment.center;

    final examples = ExamplesProvider.of(context);
    final widgetBuilder = examples[options.name];

    if (widgetBuilder == null) {
      return Container(
        color: Colors.red,
      );
    }

    return AnimatedBoxSpecWidget(
      duration: const Duration(milliseconds: 300),
      spec: spec.contentContainer,
      child: Container(
        alignment: toAlignment(alignment),
        child: Builder(
          builder: widgetBuilder,
        ),
      ),
    );
  }
}

BoxFit toBoxFit(ImageFit fit) {
  return switch (fit) {
    ImageFit.fill => BoxFit.fill,
    ImageFit.contain => BoxFit.contain,
    ImageFit.cover => BoxFit.cover,
    ImageFit.fitWidth => BoxFit.fitWidth,
    ImageFit.fitHeight => BoxFit.fitHeight,
    ImageFit.none => BoxFit.none,
    ImageFit.scaleDown => BoxFit.scaleDown,
  };
}

Alignment toAlignment(ContentAlignment alignment) {
  return switch (alignment) {
    ContentAlignment.topLeft => Alignment.topLeft,
    ContentAlignment.topCenter => Alignment.topCenter,
    ContentAlignment.topRight => Alignment.topRight,
    ContentAlignment.centerLeft => Alignment.centerLeft,
    ContentAlignment.center => Alignment.center,
    ContentAlignment.centerRight => Alignment.centerRight,
    ContentAlignment.bottomLeft => Alignment.bottomLeft,
    ContentAlignment.bottomCenter => Alignment.bottomCenter,
    ContentAlignment.bottomRight => Alignment.bottomRight,
  };
}
