import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../components/atoms/markdown_viewer.dart';
import '../models/slide_model.dart';
import '../models/slide_options_model.dart';
import 'enum_mappers.dart';

enum BackgroundType { color, uri, none }

// BackgroundType checkBackgroundType(String? input) {
//   if (input == null) return BackgroundType.none;
//   // Regular expression to check if the string is a hex color.
//   final hexPattern = RegExp(r'^[A-Fa-f0-9]{6}$');

//   // Regular expression to check if the string is a URI.
//   final uriPattern =
//       RegExp(r'^(https?:\/\/)?[\da-z\.-]+\.[a-z\.]{2,6}([\/\w \.-]*)*\/?$');

//   // List of valid color names
//   final List<String> colorNames = [
//     'red',
//     'green',
//     'blue'
//   ]; // add more color names as needed

//   if (hexPattern.hasMatch(input) || colorNames.contains(input)) {
//     return BackgroundType.color;
//   } else if (uriPattern.hasMatch(input)) {
//     return BackgroundType.uri;
//   } else {
//     return BackgroundType.none;
//   }
// }

abstract class TemplateBuilder<C extends SlideConfig> extends StatelessWidget {
  final C config;

  const TemplateBuilder(this.config, {super.key});

  Widget builder(C config, BuildContext context);

  @override
  Widget build(BuildContext context) => builder(config, context);
}

class ImageSlideBuilder extends TemplateBuilder<ImageSlideConfig> {
  const ImageSlideBuilder(super.config, {super.key});

  @override
  Widget builder(ImageSlideConfig config, BuildContext context) {
    final imageUrl = config.image;
    final imageFit = config.imageFit;
    final boxFit = imageFit.toBoxFit();

    Widget imageWidget = const SizedBox(
      height: 0,
      width: 0,
    );

    imageWidget = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: boxFit,
        ),
      ),
    );

    List<Widget> children = [
      Expanded(child: imageWidget),
      Expanded(child: SlideContent(config.content)),
    ];

    if (config.imagePosition == ImagePosition.right) {
      children = children.reversed.toList();
    }

    return Row(
      children: children,
    );
  }
}

class SimpleSlideBuilder extends TemplateBuilder<SimpleSlideConfig> {
  const SimpleSlideBuilder(super.config, {super.key});

  @override
  Widget builder(SimpleSlideConfig config, BuildContext context) {
    final flexAlignment =
        FlexAlignment.fromContentAlignment(config.contentAlignment);

    final background = config.background;

    Widget current = Column(
      mainAxisAlignment: flexAlignment.mainAxisAlignment,
      crossAxisAlignment: flexAlignment.crossAxisAlignment,
      children: [SlideContent(config.content)],
    );

    BoxDecoration decoration;
    if (background != null) {
      decoration = BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(background),
          fit: BoxFit.cover,
        ),
      );
    } else {
      return current;
    }

    // has background
    final backgroundWidget = Container(
      decoration: decoration,
      child: current,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        backgroundWidget,
        Container(
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

class TwoColumnSlideBuilder extends TemplateBuilder<TwoColumnSlideConfig> {
  const TwoColumnSlideBuilder(super.config, {super.key});

  @override
  Widget builder(TwoColumnSlideConfig config, BuildContext context) {
    final children = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(config.leftContent),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(config.rightContent),
        ),
      ),
    ];

    return Row(
      children: children,
    );
  }
}

class TwoColumnHeaderSlideConfigBuilder
    extends TemplateBuilder<TwoColumnHeaderSlideConfig> {
  const TwoColumnHeaderSlideConfigBuilder(super.config, {super.key});

  @override
  Widget builder(TwoColumnHeaderSlideConfig config, BuildContext context) {
    final children = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(config.leftContent),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(config.rightContent),
        ),
      ),
    ];

    return Column(
      children: [
        Row(
          children: [
            SlideContent(config.topContent),
          ],
        ),
        Expanded(
          child: Row(
            children: children,
          ),
        ),
      ],
    );
  }
}

final Map<String, Color> colorMap = {
  'red': Colors.red,
  'green': Colors.green,
  'blue': Colors.blue,
  'yellow': Colors.yellow,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'brown': Colors.brown,
  'grey': Colors.grey,
  'cyan': Colors.cyan,
  'indigo': Colors.indigo,
  'lime': Colors.lime,
  'teal': Colors.teal,
  'amber': Colors.amber,
  'black': Colors.black,
  'white': Colors.white,
  'transparent': Colors.transparent,
  // Add more mappings as needed
};