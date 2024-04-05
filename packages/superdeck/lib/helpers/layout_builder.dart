import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../components/molecules/code_preview.dart';
import '../components/molecules/slide_content.dart';
import '../models/config_model.dart';
import '../models/schema_error_model.dart';
import '../models/slide_options_model.dart';
import '../superdeck.dart';
import 'measure_size.dart';

abstract class SlideWidget<Config extends SlideOptions>
    extends StatelessWidget {
  final Config config;

  const SlideWidget({required this.config, super.key});

  SlideContent buildContent() {
    return SlideContent(
      content: config.content,
      alignment: config.alignment,
    );
  }

  SlideContent buildContentSection(String content) {
    return SlideContent(
      content: content,
      alignment: config.alignment,
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

class SchemaErrorSlide extends SlideWidget<SchemaErrorSlideOptions> {
  const SchemaErrorSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style(
      $.contentContainer.color(const Color.fromARGB(255, 166, 6, 6)),
      $.contentContainer.padding.all(40.0),
      $.contentContainer.borderRadius.all(20.0),
      $.contentContainer.border.all(
        color: const Color.fromARGB(255, 111, 4, 4),
        width: 5,
      ),
      $.contentContainer.shadow(
        color: const Color.fromARGB(255, 119, 1, 1),
        blurRadius: 100,
        spreadRadius: 20,
      ),
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

    final errorMessages = config.errors.map((error) {
      switch (error.errorType) {
        case ErrorType.unallowedAdditionalProperty:
          return "## ${error.location} \n ${error.errorType.message}: `${error.value}`.";
        case ErrorType.enumViolated:
          return "## ${error.location} \n ${error.errorType.message}: `${error.value}`.";
        case ErrorType.requiredPropMissing:
          return "## ${error.location} \n ${error.errorType.message}: `${error.value}`.";
        case ErrorType.invalidType:
          return "## ${error.location} \n ${error.errorType.message}: `${error.value}`";
        default:
          return 'Unknown error type.';
      }
    }).join('\n');

    return StyledWidgetBuilder(
        style: style,
        builder: (context) {
          //  Maybe there are no validation errors just return the content
          return Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                  color: const Color.fromARGB(255, 166, 6, 6), width: 20),
            ),
            child: SlideContent(
              content: '${config.content} \n $errorMessages',
              alignment: ContentAlignment.center,
            ),
          );
        });
  }
}

class InvalidSlide extends SlideWidget<InvalidSlideOptions> {
  const InvalidSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffA11211),
      padding: const EdgeInsets.all(40.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            color: Color(0xffD81919),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: buildContent(),
      ),
    );
  }
}

class WidgetOptionsProvider extends InheritedWidget {
  final WidgetOptions options;

  const WidgetOptionsProvider({
    required this.options,
    required super.child,
    super.key,
  });

  static WidgetOptionsProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WidgetOptionsProvider>()!;
  }

  @override
  bool updateShouldNotify(WidgetOptionsProvider oldWidget) {
    return options != oldWidget.options;
  }
}

class WidgetSlide extends SlideWidget<WidgetSlideOptions> {
  const WidgetSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final options = config.widget;
    final position = options.position;

    final previewBuilders = SuperDeck.widgetBuildersOf(context);

    final builder = previewBuilders[options.name]?.builder;

    List<Widget> children = [
      Expanded(child: buildContent()),
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
              child: WidgetOptionsProvider(
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

    final mix = MixProvider.of(context);
    final spec = SlideSpec.of(mix);

    ImageProvider provider;

    if (image.src.startsWith('http') || image.src.startsWith('https')) {
      provider = CachedNetworkImageProvider(image.src);
    } else {
      provider = AssetImage(image.src);
    }
    // final Color? color;
    // final ImageRepeat? repeat;
    // final BoxFit? fit;
    // final AlignmentGeometry? alignment;
    // final Rect? centerSlice;
    // final FilterQuality? filterQuality;
    // final BlendMode? colorBlendMode;
    List<Widget> children = [
      Expanded(child: buildContent()),
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

class TwoColumnSlide extends SlideWidget<TwoColumnSlideOptions> {
  const TwoColumnSlide({required super.config, super.key});

  @override
  Widget build(BuildContext context) {
    final alignment = config.alignment ?? ContentAlignment.centerLeft;
    return Column(
      mainAxisAlignment: alignment.toMainAxisAlignment(),
      crossAxisAlignment: alignment.toCrossAxisAlignment(),
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
    final alignment = config.alignment ?? ContentAlignment.centerLeft;
    return Column(
      mainAxisAlignment: alignment.toMainAxisAlignment(),
      crossAxisAlignment: alignment.toCrossAxisAlignment(),
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
