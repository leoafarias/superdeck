import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import '../components/molecules/code_preview.dart';
import '../components/molecules/slide_content.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../superdeck.dart';
import 'measure_size.dart';

abstract class SlideTemplate<Config extends Slide> extends StatelessWidget {
  final Config config;

  const SlideTemplate({required this.config, super.key});

  Widget buildContent() {
    return _buildContent(
      config.data,
      config.contentOptions,
    );
  }

  @protected
  Widget _buildContent(String content, ContentOptions? options) {
    final alignment = options?.alignment ?? ContentAlignment.center;
    return Column(
      mainAxisAlignment: alignment.toMainAxisAlignment(),
      crossAxisAlignment: alignment.toCrossAxisAlignment(),
      children: [
        SlideContent(data: content),
      ],
    );
  }

  Widget buildContentSection(String content, ContentOptions? options) {
    return Expanded(
      flex: options?.flex ?? 1,
      child: _buildContent(content, options),
    );
  }
}

class SimpleSlideTemplate extends SlideTemplate<SimpleSlide> {
  const SimpleSlideTemplate({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}

class InvalidSlideTemplate extends SlideTemplate<InvalidSlide> {
  const InvalidSlideTemplate({required super.config, super.key});

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

class WidgetSlideTemplate extends SlideTemplate<WidgetSlide> {
  const WidgetSlideTemplate({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final options = config.widget;
    final position = options.position;

    final previewBuilders = SuperDeck.widgetExamplesOf(context);

    final builder = previewBuilders[options.name];

    List<Widget> children = [
      buildContentSection(config.data, config.contentOptions),
      Expanded(
        flex: options.flex,
        child: SlideConstraintBuilder(builder: (context, size) {
          return MediaQuery(
            data: MediaQueryData(size: size),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: size.width,
                maxHeight: size.height,
              ),
              child: DevicePreview(
                enabled: options.preview,
                builder: (context) {
                  return CodePreview(
                    child: builder?.call(options.args),
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

class ImageSlideTemplate extends SlideTemplate<ImageSlide> {
  const ImageSlideTemplate({required super.config, super.key});

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
      buildContentSection(
        config.data,
        config.contentOptions,
      ),
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

class TwoColumnSlideTemplate extends SlideTemplate<TwoColumnSlide> {
  const TwoColumnSlideTemplate({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final options = config.contentOptions ?? const ContentOptions();
    final alignment = options.alignment ?? ContentAlignment.centerLeft;

    final leftOptions = options.merge(config.leftOptions);
    final rightOptions = options.merge(config.rightOptions);
    return Column(
      mainAxisAlignment: alignment.toMainAxisAlignment(),
      crossAxisAlignment: alignment.toCrossAxisAlignment(),
      children: [
        Expanded(
          child: Row(
            children: [
              buildContentSection(
                config.leftContent,
                leftOptions,
              ),
              buildContentSection(
                config.rightContent,
                rightOptions,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TwoColumnHeaderSlideTemplate extends SlideTemplate<TwoColumnHeaderSlide> {
  const TwoColumnHeaderSlideTemplate({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final options = config.contentOptions ?? const ContentOptions();
    final alignment = options.alignment ?? ContentAlignment.centerLeft;
    final flex = options.flex ?? 1;
    return Column(
      children: [
        Expanded(
          flex: config.headerOptions?.flex ?? flex,
          child: Row(
            children: [
              buildContentSection(
                config.headerContent,
                options.merge(config.headerOptions),
              ),
            ],
          ),
        ),
        Expanded(
          flex: flex,
          child: Column(
            mainAxisAlignment: alignment.toMainAxisAlignment(),
            crossAxisAlignment: alignment.toCrossAxisAlignment(),
            children: [
              Row(
                children: [
                  buildContentSection(
                    config.leftContent,
                    options.merge(
                      config.leftOptions,
                    ),
                  ),
                  buildContentSection(
                    config.rightContent,
                    options.merge(
                      config.rightOptions,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
