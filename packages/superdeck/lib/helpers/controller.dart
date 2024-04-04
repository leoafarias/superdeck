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
  projectOptions,
}

class SuperDeck extends InheritedModel<SuperDeckAspect> {
  final List<SlideOptions> slides;
  final List<SlideAsset> assets;
  final ProjectOptions projectOptions;
  final Map<String, PreviewWidgetBuilder> previewBuilders;
  final Style style;

  const SuperDeck({
    super.key,
    required this.slides,
    required this.assets,
    required this.previewBuilders,
    required this.style,
    required this.projectOptions,
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

  static ProjectOptions projectOptionsOf(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context,
            aspect: SuperDeckAspect.projectOptions)!
        .projectOptions;
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
