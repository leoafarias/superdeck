import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_deck/components/atoms/markdown_viewer.dart';
import 'package:dash_deck/helpers/enum_mappers.dart';
import 'package:dash_deck/helpers/scale.dart';
import 'package:dash_deck/providers/slide_data.provider.dart';
import 'package:dashdeck_core/dashdeck_core.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class SlideView extends StatelessWidget {
  const SlideView(
    this.slideData, {
    Key? key,
  }) : super(key: key);

  final SlideData slideData;

  @override
  Widget build(BuildContext context) {
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

    final alignment = ContentAlignmentData.fromContentAlignment(
      slideData.options.contentAlignment,
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

    if (slideData.options.layout == SlideLayout.none) {
      return current;
    }

    Widget imageWidget = const SizedBox(
      height: 0,
      width: 0,
    );

    if (slideData.options.image != null) {
      imageWidget = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(slideData.options.image!),
            fit: mapImageToBoxFit(slideData.options.imageFit),
          ),
        ),
      );
    }

    if (slideData.options.layout == SlideLayout.cover) {
      return Stack(
        fit: StackFit.expand,
        children: [
          imageWidget,
          current,
        ],
      );
    }

    if (slideData.options.layout == SlideLayout.contentRight) {
      return Row(
        children: [
          Expanded(child: imageWidget),
          Expanded(child: current),
        ],
      );
    }

    if (slideData.options.layout == SlideLayout.contentLeft) {
      return Row(
        children: [
          Expanded(child: current),
          Expanded(child: imageWidget),
        ],
      );
    }

    return SlideDataProvider(
      data: slideData,
      child: current,
    );
  }
}
