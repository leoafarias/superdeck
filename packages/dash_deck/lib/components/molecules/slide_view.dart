import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_deck/components/atoms/markdown_viewer.dart';
import 'package:dash_deck/helpers/enum_mappers.dart';
import 'package:dash_deck/helpers/scale.dart';
import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class SlideView extends StatelessWidget {
  const SlideView(
    this.slideData, {
    super.key,
  });

  final SlideData slideData;

  @override
  Widget build(BuildContext context) {
    final hasBackground = slideData.options.background != null;
    final options = slideData.options;
    final alignment = ContentAlignmentData.fromContentAlignment(
      slideData.options.contentAlignment,
    );

    Widget current = LayoutBuilder(
      builder: (context, contraints) {
        return Box(
          style: StyleMix(
            paddingHorizontal(40.0.sh),
            paddingVertical(40.0.sv),
          ),
          child: MarkdownViewer(slideData.content ?? ""),
        );
      },
    );

    current = Column(
      mainAxisAlignment: alignment.mainAxisAlignment,
      crossAxisAlignment: alignment.crossAxisAlignment,
      children: [
        current,
      ],
    );

    if (slideData.options.scrollable) {
      current = SingleChildScrollView(
        child: current,
      );
    }

    Widget? imageWidget = const SizedBox(
      height: 0,
      width: 0,
    );

    if (hasBackground) {
      imageWidget = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(options.background!),
            fit: mapImageToBoxFit(options.backgroundFit),
          ),
        ),
      );
    }

    if (options.layout == SlideLayout.cover) {
      return Stack(
        fit: StackFit.expand,
        children: [
          imageWidget,
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

    if (options.layout == SlideLayout.contentRight) {
      return Row(
        children: [
          Expanded(child: imageWidget),
          Expanded(child: current),
        ],
      );
    }

    if (options.layout == SlideLayout.contentLeft) {
      return Row(
        children: [
          Expanded(child: current),
          Expanded(child: imageWidget),
        ],
      );
    }
    if (hasBackground) {
      return Row(
        children: [
          Expanded(child: current),
          Expanded(child: imageWidget),
        ],
      );
    }
    return current;
  }
}
