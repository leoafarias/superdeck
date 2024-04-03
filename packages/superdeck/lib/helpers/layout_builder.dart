import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../components/molecules/code_preview.dart';
import '../components/molecules/slide_content.dart';
import '../models/config_model.dart';
import '../models/slide_options_model.dart';
import 'controller.dart';
import 'measure_size.dart';

abstract class SlideWidget<Config extends SlideOptions>
    extends StatelessWidget {
  final Config config;

  const SlideWidget({required this.config, super.key});

  SlideContent buildContent() {
    return SlideContent(
      key: ValueKey(config),
      content: config.content,
      alignment: config.contentAlignment,
    );
  }

  SlideContent buildContentSection(String content) {
    return SlideContent(
      key: ValueKey(content),
      content: content,
      alignment: config.contentAlignment,
    );
  }
}

class SimpleSlide extends SlideWidget<SimpleSlideOptions> {
  const SimpleSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}

class PreviewOptionsProvider extends InheritedWidget {
  final PreviewOptions options;

  const PreviewOptionsProvider({
    required this.options,
    required super.child,
    super.key,
  });

  static PreviewOptionsProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PreviewOptionsProvider>()!;
  }

  @override
  bool updateShouldNotify(PreviewOptionsProvider oldWidget) {
    return options != oldWidget.options;
  }
}

class PreviewSlide extends SlideWidget<PreviewSlideOptions> {
  const PreviewSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final options = config.widget;
    final position = options.position;

    final previewBuilders = SuperDeck.previewBuildersOf(context);

    final builder = previewBuilders[options.name]?.builder;

    List<Widget> children = [
      Expanded(child: buildContent()),
      Expanded(
        child: SlideConstraintBuilder(builder: (context, size) {
          return MediaQuery(
            data: MediaQueryData(size: size),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: size.width,
                maxHeight: size.height,
              ),
              child: PreviewOptionsProvider(
                options: options,
                child: CodePreview(
                  child: builder?.call(context, options),
                ),
              ),
            ),
          );
        }),
      )
    ];

    if (position == LayoutPosition.left || position == LayoutPosition.top) {
      children = children.reversed.toList();
    }

    final isVertical =
        position == LayoutPosition.top || position == LayoutPosition.bottom;

    if (isVertical) {
      children = children.map((child) {
        return Expanded(
          child: Row(children: [child]),
        );
      }).toList();
    }

    if (isVertical) {
      return Column(children: children);
    } else {
      return Row(children: children);
    }
  }
}

class ImageSlide extends SlideWidget<ImageSlideOptions> {
  const ImageSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final image = config.image;
    final position = image.position;

    Widget buildImage() {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(image.src),
            fit: image.fit.toBoxFit(),
          ),
        ),
      );
    }

    List<Widget> children = [
      Expanded(child: buildContent()),
      Expanded(child: buildImage())
    ];

    if (position == LayoutPosition.left || position == LayoutPosition.top) {
      children = children.reversed.toList();
    }

    final isVertical =
        position == LayoutPosition.top || position == LayoutPosition.bottom;

    if (isVertical) {
      children = children.map((child) {
        return Expanded(
          child: Row(children: [child]),
        );
      }).toList();
    }

    if (isVertical) {
      return Column(children: children);
    } else {
      return Row(children: children);
    }
  }
}

class TwoColumnSlide extends SlideWidget<TwoColumnSlideOptions> {
  const TwoColumnSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: config.contentAlignment.toMainAxisAlignment(),
      crossAxisAlignment: config.contentAlignment.toCrossAxisAlignment(),
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: buildContentSection(config.leftContent),
              ),
              Expanded(
                child: buildContentSection(config.rightContent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TwoColumnHeaderSlide extends SlideWidget<TwoColumnHeaderSlideOptions> {
  const TwoColumnHeaderSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: config.contentAlignment.toMainAxisAlignment(),
      crossAxisAlignment: config.contentAlignment.toCrossAxisAlignment(),
      children: [
        Row(
          children: [
            Expanded(child: buildContentSection(config.topContent)),
          ],
        ),
        Row(
          children: [
            Expanded(child: buildContentSection(config.leftContent)),
            Expanded(child: buildContentSection(config.rightContent)),
          ],
        ),
      ],
    );
  }
}
