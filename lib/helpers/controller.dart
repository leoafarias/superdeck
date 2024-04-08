import 'package:flutter/material.dart';

import '../models/asset_model.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../superdeck.dart';

typedef DeckData = (
  List<Slide> slides,
  List<SlideAsset> assets,
);

// class WidgetDisplayBuilder extends StatelessWidget {
//   const WidgetDisplayBuilder({
//     required this.builder,
//     super.key,
//   });

//   final Widget Function(BuildContext, WidgetOptions) builder;

//   @override
//   Widget build(BuildContext context) {
//     final options = WidgetOptionsProvider.of(context).options;
//     return builder(context, options);
//   }
// }

enum SuperDeckAspect {
  slides,
  assets,
  widgetBuilders,
  style,
  projectOptions,
}

class SuperDeck extends InheritedModel<SuperDeckAspect> {
  final List<Slide> slides;
  final List<SlideAsset> assets;
  final Config projectOptions;
  final Map<String, Example> widgetExamples;
  final Style style;

  const SuperDeck({
    super.key,
    required this.slides,
    required this.assets,
    required this.widgetExamples,
    required this.style,
    required this.projectOptions,
    required super.child,
  });

  static SuperDeck of(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context)!;
  }

  static List<Slide> slidesOf(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context,
            aspect: SuperDeckAspect.slides)!
        .slides;
  }

  static List<SlideAsset> assetsOf(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context,
            aspect: SuperDeckAspect.assets)!
        .assets;
  }

  static Config projectOptionsOf(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context,
            aspect: SuperDeckAspect.projectOptions)!
        .projectOptions;
  }

  static Style styleOf(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context,
            aspect: SuperDeckAspect.style)!
        .style;
  }

  static Map<String, Example> widgetExamplesOf(BuildContext context) {
    return InheritedModel.inheritFrom<SuperDeck>(context,
            aspect: SuperDeckAspect.widgetBuilders)!
        .widgetExamples;
  }

  @override
  bool updateShouldNotify(SuperDeck oldWidget) {
    return oldWidget.slides != slides ||
        oldWidget.assets != assets ||
        oldWidget.style != style ||
        oldWidget.widgetExamples != widgetExamples;
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
    if (dependencies.contains(SuperDeckAspect.widgetBuilders) &&
        oldWidget.widgetExamples != widgetExamples) {
      return true;
    }
    if (dependencies.contains(SuperDeckAspect.style) &&
        oldWidget.style != style) {
      return true;
    }
    return false;
  }
}
