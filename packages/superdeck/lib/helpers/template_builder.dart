import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/atoms/markdown_viewer.dart';
import '../models/config_model.dart';
import '../models/slide_options_model.dart';

enum BackgroundType { color, uri, none }

abstract class SlideWidget<Config extends SlideConfig> extends StatelessWidget {
  final Config config;

  const SlideWidget({required this.config, super.key});

  SlideContent buildContent() {
    return SlideContent(
      content: config.content,
      alignment: config.contentAlignment,
    );
  }

  SlideContent buildContentSection(String content) {
    return SlideContent(
      content: content,
      alignment: config.contentAlignment,
    );
  }
}

class ImageSlide extends SlideWidget<ImageSlideConfig> {
  const ImageSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final image = config.image;

    final imageWidget = Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(image.src),
            fit: image.fit.toBoxFit(),
          ),
        ),
      ),
    );

    List<Widget> children = [
      Expanded(child: buildContent()),
    ];

    if (image.position == ImagePosition.left) {
      children.insert(0, imageWidget);
    } else {
      children.add(imageWidget);
    }

    return Row(
      children: children,
    );
  }
}

class BaseSlide extends SlideWidget<BaseSlideConfig> {
  const BaseSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}

class TwoColumnSlide extends SlideWidget<TwoColumnSlideConfig> {
  const TwoColumnSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildContentSection(config.leftContent),
        ),
        Expanded(
          child: buildContentSection(config.rightContent),
        ),
      ],
    );
  }
}

class TwoColumnHeaderSlide extends SlideWidget<TwoColumnHeaderSlideConfig> {
  const TwoColumnHeaderSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: buildContentSection(config.topContent)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(child: buildContentSection(config.leftContent)),
              Expanded(child: buildContentSection(config.rightContent)),
            ],
          ),
        ),
      ],
    );
  }
}
