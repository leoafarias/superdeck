import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_deck/components/atoms/markdown_viewer.dart';
import 'package:dash_deck/helpers/enum_mappers.dart';
import 'package:dash_deck/helpers/scale.dart';
import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:flutter/material.dart';

abstract class SlideLayoutBuilder<S extends Slide> extends StatelessWidget {
  final S slide;
  const SlideLayoutBuilder(this.slide, {super.key});

  @override
  Widget build(BuildContext context);
}

class ImageSlideWidget extends SlideLayoutBuilder<ImageSlide> {
  const ImageSlideWidget(super.slide, {super.key});

  @override
  Widget build(BuildContext context) {
    final imageUri = slide.image;
    final imageFit = slide.imageFit == null
        ? BoxFit.contain
        : mapImageToBoxFit(slide.imageFit!);

    Widget imageWidget = const SizedBox(
      height: 0,
      width: 0,
    );

    imageWidget = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUri),
          fit: imageFit,
        ),
      ),
    );

    List<Widget> children = [
      Expanded(child: imageWidget),
      Expanded(child: MarkdownViewer(slide.content)),
    ];

    if (slide.imagePosition == ImagePosition.right) {
      children = children.reversed.toList();
    }

    return Row(
      children: children,
    );
  }
}

class FullSlideWidget extends SlideLayoutBuilder<FullSlide> {
  const FullSlideWidget(super.slide, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MarkdownViewer(slide.content),
    );
  }
}

class SlideWidget extends SlideLayoutBuilder<Slide> {
  const SlideWidget(super.slide, {super.key});

  @override
  Widget build(BuildContext context) {
    final flexAlignment =
        FlexAlignment.fromContentAlignment(slide.contentAlignment);
    return Column(
      mainAxisAlignment: flexAlignment.mainAxisAlignment,
      crossAxisAlignment: flexAlignment.crossAxisAlignment,
      children: [MarkdownViewer(slide.content)],
    );
  }
}

class CoverSlideWidget extends SlideLayoutBuilder<CoverSlide> {
  const CoverSlideWidget(super.slide, {super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundUri = slide.background;
    final flexAlignment =
        FlexAlignment.fromContentAlignment(slide.contentAlignment);

    Widget backgroundWidget = const SizedBox(
      height: 0,
      width: 0,
    );

    if (backgroundUri != null) {
      backgroundWidget = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(backgroundUri),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    final current = Column(
      mainAxisAlignment: flexAlignment.mainAxisAlignment,
      crossAxisAlignment: flexAlignment.crossAxisAlignment,
      children: [MarkdownViewer(slide.content)],
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        backgroundWidget,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0.sh),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
          child: current,
        ),
      ],
    );
  }
}

class TwoColumnSlideWidget extends SlideLayoutBuilder<TwoColumnSlide> {
  const TwoColumnSlideWidget(super.slide, {super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MarkdownViewer(slide.leftContent),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MarkdownViewer(slide.rightContent),
        ),
      ),
    ];

    return Row(
      children: children,
    );
  }
}

class TwoColumnHeaderSlideWidget
    extends SlideLayoutBuilder<TwoColumnHeaderSlide> {
  const TwoColumnHeaderSlideWidget(super.slide, {super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MarkdownViewer(slide.leftContent),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MarkdownViewer(slide.rightContent),
        ),
      ),
    ];

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MarkdownViewer(slide.topContent),
            )
          ],
        ),
        Row(
          children: children,
        ),
      ],
    );
  }
}
