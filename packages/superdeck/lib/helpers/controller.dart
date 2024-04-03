import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/config_model.dart';
import '../models/slide_asset_model.dart';
import '../models/slide_options_model.dart';
import '../superdeck.dart';
import 'layout_builder.dart';

typedef DeckData = (
  List<SlideOptions> slides,
  List<SlideAsset> assets,
);

class PreviewWidgetBuilder extends StatelessWidget {
  const PreviewWidgetBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext, PreviewOptions) builder;

  @override
  Widget build(BuildContext context) {
    final options = PreviewOptionsProvider.of(context).options;
    return builder(context, options);
  }
}

enum SuperDeckAspect {
  slides,
  assets,
  previewBuilders,
  style,
}

class SuperDeck extends InheritedModel<SuperDeckAspect> {
  final List<SlideOptions> slides;
  final List<SlideAsset> assets;
  final Map<String, PreviewWidgetBuilder> previewBuilders;
  final Style style;

  const SuperDeck({
    super.key,
    required this.slides,
    required this.assets,
    required this.previewBuilders,
    required this.style,
    required super.child,
  });

  static SuperDeck of(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context)!;
  }

  static List<SlideOptions> slidesOf(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context,
            aspect: SuperDeckAspect.slides)!
        .slides;
  }

  static List<SlideAsset> assetsOf(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context,
            aspect: SuperDeckAspect.assets)!
        .assets;
  }

  static Style styleOf(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context,
            aspect: SuperDeckAspect.style)!
        .style;
  }

  static Map<String, PreviewWidgetBuilder> previewBuildersOf(
      BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context,
            aspect: SuperDeckAspect.previewBuilders)!
        .previewBuilders;
  }

  @override
  bool updateShouldNotify(SuperDeck oldWidget) {
    return oldWidget.slides != slides ||
        oldWidget.assets != assets ||
        oldWidget.style != style ||
        oldWidget.previewBuilders != previewBuilders;
  }

  @override
  bool updateShouldNotifyDependent(
      SuperDeck oldWidget, Set<SuperDeckAspect> dependencies) {
    if (dependencies.contains(SuperDeckAspect.slides) &&
        oldWidget.slides != slides) {
      return true;
    }
    if (dependencies.contains(SuperDeckAspect.assets) &&
        oldWidget.assets != assets) {
      return true;
    }
    if (dependencies.contains(SuperDeckAspect.previewBuilders) &&
        oldWidget.previewBuilders != previewBuilders) {
      return true;
    }
    if (dependencies.contains(SuperDeckAspect.style) &&
        oldWidget.style != style) {
      return true;
    }
    return false;
  }
}

List<SlideOptions> parseSlides(String contents) {
  final slides = json.decode(contents) as List<dynamic>;
  return slides.map((e) {
    switch (e['layout']) {
      case null:
      case SimpleSlideOptions.layout:
        return SimpleSlideOptions.fromMap(e);
      case ImageSlideOptions.layout:
        return ImageSlideOptions.fromMap(e);
      case TwoColumnSlideOptions.layout:
        return TwoColumnSlideOptions.fromMap(e);
      case TwoColumnHeaderSlideOptions.layout:
        return TwoColumnHeaderSlideOptions.fromMap(e);
      case PreviewSlideOptions.layout:
        return PreviewSlideOptions.fromMap(e);
      default:
        return SimpleSlideOptions.fromMap(e);
    }
  }).toList();
}

List<SlideAsset> parseAssets(String contents) {
  final assets = jsonDecode(contents) as List<dynamic>;
  return assets.map((e) => SlideAsset.fromMap(e)).toList();
}
