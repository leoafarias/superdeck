import 'package:flutter/material.dart';

import '../components/atoms/cache_image_widget.dart';
import '../components/molecules/code_preview.dart';
import '../components/molecules/slide_content.dart';
import '../providers/slide_provider.dart';
import '../superdeck.dart';
import 'constants.dart';
import 'measure_size.dart';

const _defaultFlex = 1;

abstract class SlideBuilder<T extends Slide> extends StatelessWidget {
  final T config;
  final SlideSpec spec;

  const SlideBuilder({required this.config, super.key, required this.spec});

  Widget buildContent() {
    return _buildContent(
      config.data,
      config.contentOptions,
    );
  }

  @protected
  Widget _buildContent(String content, ContentOptions? options) {
    return SlideContent(
      data: content,
      options: options,
      spec: spec,
    );
  }

  Widget buildContentSection(SectionData section) {
    return Expanded(
      flex: section.options.flex ?? _defaultFlex,
      child: _buildContent(section.content, section.options),
    );
  }
}

class SimpleSlideBuilder extends SlideBuilder<SimpleSlide> {
  const SimpleSlideBuilder({
    required super.config,
    super.key,
    required super.spec,
  });

  @override
  Widget build(BuildContext context) => buildContent();
}

class InvalidSlideBuilder extends SlideBuilder<InvalidSlide> {
  const InvalidSlideBuilder({
    required super.config,
    super.key,
    required super.spec,
  });

  @override
  Widget build(BuildContext context) {
    const red = Color.fromARGB(255, 166, 6, 6);

    final s = SlideSpecUtility.self;

    final style = Style(
      s.paragraph.textStyle.color(Colors.white),
      s.h1.textStyle.color(const Color.fromARGB(255, 71, 1, 1)),
      s.h1.textStyle.fontSize(36.0),
      s.h1.textStyle.bold(),
      s.h2.padding.top(0),
      s.h2.textStyle.bold(),
      s.h2.textStyle.color.yellow(),
      s.code.textStyle.color.yellow(),
      s.code.textStyle.backgroundColor(const Color.fromARGB(255, 84, 6, 6)),
    );

    return SpecBuilder(
        style: style,
        builder: (context) {
          //  Maybe there are no validation errors just return the content
          return Container(
            decoration: BoxDecoration(
              color: red,
              border: Border.all(color: red, width: 20),
            ),
            child: buildContent(),
          );
        });
  }
}

abstract class SplitSlideBuilder<T extends SplitSlide> extends SlideBuilder<T> {
  const SplitSlideBuilder({
    required super.config,
    super.key,
    required super.spec,
  });

  Widget buildSplitSlide(Widget side) {
    final position = config.options.position;
    final flex = config.options.flex;

    List<Widget> children = [
      buildContentSection((
        content: config.data,
        options: config.contentOptions ?? const ContentOptions(),
      )),
      Expanded(flex: flex, child: side),
    ];

    if (position == LayoutPosition.left || position == LayoutPosition.top) {
      children = children.reversed.toList();
    }

    final isVertical =
        position == LayoutPosition.top || position == LayoutPosition.bottom;

    if (isVertical) {
      return Column(children: children);
    } else {
      return Row(children: children);
    }
  }
}

class WidgetSlideBuilder extends SplitSlideBuilder<WidgetSlide> {
  const WidgetSlideBuilder({
    required super.config,
    super.key,
    required super.spec,
  });

  @override
  Widget build(BuildContext context) {
    final options = config.options;

    final examples = SlideProvider.examplesOf(context);

    final exampleBuilder = examples[options.name];

    final side = SlideConstraints(
      (size) {
        return MediaQuery(
          data: MediaQueryData(size: size),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: size.width,
              maxHeight: size.height,
            ),
            child: ExamplePreview(
              args: options.args,
              builder: exampleBuilder!,
            ),
          ),
        );
      },
    );

    return buildSplitSlide(side);
  }
}

class ImageSlideBuilder extends SplitSlideBuilder<ImageSlide> {
  const ImageSlideBuilder({
    required super.config,
    super.key,
    required super.spec,
  });

  @override
  Widget build(BuildContext context) {
    final spec = SlideProvider.specOf(context);

    final src = config.options.src;
    final boxFit = config.options.fit?.toBoxFit() ?? spec.image.fit;

    // THis slide breaks in half and I want to calculate the size based on if its in top or bottom
    // or left or right. Also there is a property called flex which is how much of the slide it takes
    // so I can use that to calculate the size of the canvas
    final firstHalf = config.contentOptions?.flex ?? _defaultFlex;
    final imageHalf = config.options.flex;

// available size const width = 1280.0;
//const height = 720.0;

    double width;
    double height;
    const availableSize = kResolution;
    if (config.options.position.isHorizontal()) {
      width = availableSize.width * firstHalf / (firstHalf + imageHalf);
      height = availableSize.height;
    } else {
      width = availableSize.width;
      height = availableSize.height * firstHalf / (firstHalf + imageHalf);
    }

    final side = Container(
      height: spec.image.height,
      width: spec.image.width,
      alignment: spec.image.alignment,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: getImageProvider(
            context: context,
            url: src,
            targetSize: Size(
              width,
              height,
            ),
          ),
          centerSlice: spec.image.centerSlice,
          repeat: spec.image.repeat ?? ImageRepeat.noRepeat,
          filterQuality: spec.image.filterQuality ?? FilterQuality.low,
          fit: boxFit,
        ),
      ),
    );

    return buildSplitSlide(side);
  }
}

class TwoColumnSlideBuilder extends SlideBuilder<TwoColumnSlide> {
  const TwoColumnSlideBuilder({
    required super.config,
    super.key,
    required super.spec,
  });

  @override
  Widget build(BuildContext context) {
    final options = config.contentOptions ?? const ContentOptions();
    final alignment = options.alignment;

    return Container(
      alignment: alignment.toAlignment(),
      child: Row(
        children: [
          buildContentSection(config.left),
          buildContentSection(config.right),
        ],
      ),
    );
  }
}

class TwoColumnHeaderSlideBuilder extends SlideBuilder<TwoColumnHeaderSlide> {
  const TwoColumnHeaderSlideBuilder({
    required super.config,
    super.key,
    required super.spec,
  });

  @override
  Widget build(BuildContext context) {
    final options = config.contentOptions ?? const ContentOptions();
    final alignment = options.alignment;
    final flex = options.flex ?? _defaultFlex;

    final header = config.header;

    final left = config.left;
    final right = config.right;
    return Column(
      children: [
        Expanded(
          flex: header.options.flex ?? _defaultFlex,
          child: Row(
            children: [
              buildContentSection((
                content: header.content,
                options: options.merge(header.options),
              )),
            ],
          ),
        ),
        Expanded(
          flex: flex,
          child: Container(
            alignment: alignment.toAlignment(),
            child: Row(
              children: [
                buildContentSection((
                  content: left.content,
                  options: options.merge(left.options),
                )),
                buildContentSection((
                  content: right.content,
                  options: options.merge(right.options),
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
