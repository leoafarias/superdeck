import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import '../components/molecules/code_preview.dart';
import '../components/molecules/slide_content.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../superdeck.dart';
import 'measure_size.dart';

abstract class SlideBuilder<T extends Slide> extends StatelessWidget {
  final T config;

  const SlideBuilder({required this.config, super.key});

  Widget buildContent() {
    return _buildContent(
      config.data,
      config.contentOptions,
    );
  }

  @protected
  Widget _buildContent(String content, ContentOptions? options) {
    return SlideContent(data: content, options: options);
  }

  Widget buildContentSection(SectionData section) {
    return Expanded(
      flex: section.options.flex ?? 1,
      child: _buildContent(section.content, section.options),
    );
  }
}

class SimpleSlideBuilder extends SlideBuilder<SimpleSlide> {
  const SimpleSlideBuilder({required super.config, super.key});

  @override
  Widget build(BuildContext context) => buildContent();
}

class InvalidSlideBuilder extends SlideBuilder<InvalidSlide> {
  const InvalidSlideBuilder({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    const red = Color.fromARGB(255, 166, 6, 6);

    final style = Style(
      $.textStyle.color(Colors.white),
      $.h1.textStyle.color(const Color.fromARGB(255, 71, 1, 1)),
      $.h1.textStyle.fontSize(36.0),
      $.h1.textStyle.bold(),
      $.h2.padding.top(0),
      $.h2.textStyle.bold(),
      $.h2.textStyle.color(Colors.yellow),
      $.code.span.color(Colors.yellow),
      $.code.span.backgroundColor(const Color.fromARGB(255, 84, 6, 6)),
    );

    return StyledWidgetBuilder(
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

class WidgetSlideBuilder extends SlideBuilder<WidgetSlide> {
  const WidgetSlideBuilder({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final widgetOptions = config.widget;
    final position = widgetOptions.position;

    final previewBuilders = SuperDeck.widgetExamplesOf(context);

    final builder = previewBuilders[widgetOptions.name];

    List<Widget> children = [
      buildContentSection((
        content: config.data,
        options: config.contentOptions ?? const ContentOptions(),
      )),
      Expanded(
        flex: widgetOptions.flex,
        child: SlideConstraintBuilder(builder: (context, size) {
          return MediaQuery(
            data: MediaQueryData(size: size),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: size.width,
                maxHeight: size.height,
              ),
              child: DevicePreview(
                enabled: widgetOptions.preview,
                builder: (context) {
                  return CodePreview(
                    child: builder?.call(widgetOptions.args),
                  );
                },
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
      return Column(children: children);
    } else {
      return Row(children: children);
    }
  }
}

class ImageSlideBuilder extends SlideBuilder<ImageSlide> {
  const ImageSlideBuilder({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final image = config.image;
    final position = image.position;

    final mix = MixProvider.of(context);
    final spec = SlideSpec.of(mix);

    ImageProvider provider;

    if (image.src.startsWith('http') || image.src.startsWith('https')) {
      provider = CachedNetworkImageProvider(image.src);
    } else {
      provider = AssetImage(image.src);
    }

    List<Widget> children = [
      buildContentSection((
        content: config.data,
        options: config.contentOptions ?? const ContentOptions(),
      )),
      Expanded(
        flex: config.image.flex,
        child: Container(
          height: spec.image.height,
          width: spec.image.width,
          alignment: spec.image.alignment,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: provider,
              centerSlice: spec.image.centerSlice,
              repeat: spec.image.repeat ?? ImageRepeat.noRepeat,
              filterQuality: spec.image.filterQuality ?? FilterQuality.low,
              fit: config.image.fit?.toBoxFit() ?? spec.image.fit,
            ),
          ),
        ),
      )
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

class TwoColumnSlideBuilder extends SlideBuilder<TwoColumnSlide> {
  const TwoColumnSlideBuilder({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final options = config.contentOptions ?? const ContentOptions();
    final alignment = options.alignment ?? ContentAlignment.centerLeft;

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
  const TwoColumnHeaderSlideBuilder({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final options = config.contentOptions ?? const ContentOptions();
    final alignment = options.alignment ?? ContentAlignment.centerLeft;
    final flex = options.flex ?? 1;

    final header = config.header;

    final left = config.left;
    final right = config.right;
    return Column(
      children: [
        Expanded(
          flex: header.options.flex ?? 1,
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
