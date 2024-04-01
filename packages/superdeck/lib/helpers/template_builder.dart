import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/atoms/markdown_viewer.dart';
import '../models/config_model.dart';
import '../models/slide_options_model.dart';

enum BackgroundType { color, uri, none }

abstract class SlideWidget<Config extends SlideOptions>
    extends StatelessWidget {
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

class BaseSlide extends SlideWidget<BaseSlideOptions> {
  const BaseSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}

class ImageSlide extends SlideWidget<ImageSlideOptions> {
  const ImageSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final image = config.image;

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

    if (image.position == ImagePosition.left) {
      children = children.reversed.toList();
    }

    return Row(children: children);
  }
}

class TwoColumnSlide extends SlideWidget<TwoColumnSlideOptions> {
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

class TwoColumnHeaderSlide extends SlideWidget<TwoColumnHeaderSlideOptions> {
  const TwoColumnHeaderSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: buildContentSection(config.topContent)),
          ],
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
