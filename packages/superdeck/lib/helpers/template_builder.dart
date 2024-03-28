import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../components/atoms/markdown_viewer.dart';
import '../components/molecules/slide_view.dart';
import '../models/slide_model.dart';
import '../models/slide_options_model.dart';
import '../superdeck.dart';
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

abstract class SlideRenderer<Config extends SlideConfig>
    extends StatelessWidget {
  final Config config;

  const SlideRenderer(this.config, {super.key});

  Widget render(Config config, BuildContext context);

  @override
  Widget build(BuildContext context) {
    return SlideWrapper(
      child: render(config, context),
    );
  }
}

class ImageSlide extends SlideRenderer<ImageSlideConfig> {
  const ImageSlide(super.config, {super.key});

  @override
  Widget render(ImageSlideConfig config, BuildContext context) {
    final imageUrl = config.image;
    final imageFit = config.imageFit;
    final boxFit = imageFit.toBoxFit();

    final style = styles.get(config.variant);

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
      Expanded(child: SlideContent(config.content, style: style)),
    ];

    if (config.imagePosition == ImagePosition.right) {
      children = children.reversed.toList();
    }

    return Row(
      children: children,
    );
  }
}

class SimpleSlide extends SlideRenderer<SimpleSlideConfig> {
  const SimpleSlide(super.config, {super.key});

  @override
  Widget render(SimpleSlideConfig config, BuildContext context) {
    return Watch((context) {
      final flexAlignment = FlexAlignment.fromContentAlignment(
        config.contentAlignment,
      );

      final style = styles.get(config.variant);

      final background = config.background;

      Widget current = Column(
        mainAxisAlignment: flexAlignment.mainAxisAlignment,
        crossAxisAlignment: flexAlignment.crossAxisAlignment,
        children: [SlideContent(style: style, config.content)],
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
    });
  }
}

class TwoColumnSlide extends SlideRenderer<TwoColumnSlideConfig> {
  const TwoColumnSlide(super.config, {super.key});

  @override
  Widget render(TwoColumnSlideConfig config, BuildContext context) {
    final style = styles.get(config.variant);
    final children = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(config.leftContent, style: style),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(config.rightContent, style: style),
        ),
      ),
    ];

    return Row(
      children: children,
    );
  }
}

class TwoColumnHeaderSlide extends SlideRenderer<TwoColumnHeaderSlideConfig> {
  const TwoColumnHeaderSlide(super.config, {super.key});

  @override
  Widget render(TwoColumnHeaderSlideConfig config, BuildContext context) {
    final style = styles.get(config.variant);
    final children = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(style: style, config.leftContent),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(config.rightContent, style: style),
        ),
      ),
    ];

    return Column(
      children: [
        Row(
          children: [
            SlideContent(config.topContent, style: style),
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
