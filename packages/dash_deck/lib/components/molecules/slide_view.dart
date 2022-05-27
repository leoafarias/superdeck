import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_deck/components/atoms/markdown_viewer.dart';
import 'package:dash_deck/helpers/enum_mappers.dart';
import 'package:dash_deck/helpers/scale.dart';
import 'package:dash_deck/models/slide_data.model.dart';
import 'package:dash_deck/providers/slide_data.provider.dart';
import 'package:dash_deck_core/models/slide_options.model.dart';
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
          mix: Mix(
            paddingHorizontal(40.0.sh),
            paddingVertical(40.0.sv),
            apply(slideData.mix),
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

    if (slideData.options.image == null && slideData.previewWidget == null) {
      throw Exception('image is required');
      // return current;
    }

    final previewWidget = slideData.previewWidget ??
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(slideData.options.image!),
              fit: mapImageToBoxFit(slideData.options.imageFit),
            ),
          ),
        );

    if (slideData.options.layout == SlideLayout.cover) {
      return Stack(
        fit: StackFit.expand,
        children: [
          previewWidget,
          current,
        ],
      );
    }

    if (slideData.options.layout == SlideLayout.contentRight) {
      return Row(
        children: [
          Expanded(child: previewWidget),
          Expanded(child: current),
        ],
      );
    }

    if (slideData.options.layout == SlideLayout.contentLeft) {
      return Row(
        children: [
          Expanded(child: current),
          Expanded(child: previewWidget),
        ],
      );
    }

    return SlideDataProvider(
      data: slideData,
      child: current,
    );
  }
}
