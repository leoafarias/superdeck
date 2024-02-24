import 'package:cached_network_image/cached_network_image.dart';
import '../components/atoms/markdown_viewer.dart';
import 'enum_mappers.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:flutter/material.dart';

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
    final imageUrl = slide.image;
    final imageFit = slide.imageFit;
    final boxFit = imageFit == null ? BoxFit.cover : imageFit.boxFit;

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
      Expanded(child: SlideContent(slide.content)),
    ];

    if (slide.imagePosition == ImagePosition.right) {
      children = children.reversed.toList();
    }

    return Row(
      children: children,
    );
  }
}

class SlideWidget extends SlideLayoutBuilder<Slide> {
  const SlideWidget(super.slide, {super.key});

  @override
  Widget build(BuildContext context) {
    final flexAlignment =
        FlexAlignment.fromContentAlignment(slide.contentAlignment);

    final background = slide.background;

    Widget current = Column(
      mainAxisAlignment: flexAlignment.mainAxisAlignment,
      crossAxisAlignment: flexAlignment.crossAxisAlignment,
      children: [SlideContent(slide.content)],
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

class TwoColumnSlideWidget extends SlideLayoutBuilder<TwoColumnSlide> {
  const TwoColumnSlideWidget(super.slide, {super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(slide.leftContent),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(slide.rightContent),
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
          child: SlideContent(slide.leftContent),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideContent(slide.rightContent),
        ),
      ),
    ];

    return Column(
      children: [
        Row(
          children: [
            SlideContent(slide.topContent),
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
