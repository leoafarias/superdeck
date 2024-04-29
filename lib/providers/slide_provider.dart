// Create a SlideProvider that extends an Inherited widget
import 'package:flutter/material.dart';

import '../models/asset_model.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../styles/style_spec.dart';

enum SlideProviderAspect {
  slide,
  spec,
  isSnapshot,
  examples,
  assets,
}

class SlideProvider extends InheritedModel<SlideProviderAspect> {
  final Slide slide;
  final SlideSpec spec;

  // If slide is a snapshot for image generation
  final bool isSnapshot;
  final Map<String, Example> examples;
  final List<SlideAsset> assets;

  const SlideProvider({
    super.key,
    required this.slide,
    required this.spec,
    required this.isSnapshot,
    required this.examples,
    required this.assets,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant SlideProvider oldWidget) {
    return slide != oldWidget.slide || spec != oldWidget.spec;
  }

  static SlideProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SlideProvider>()!;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant SlideProvider oldWidget,
    Set<SlideProviderAspect> dependencies,
  ) {
    if (dependencies.contains(SlideProviderAspect.slide) &&
        slide != oldWidget.slide) {
      return true;
    }
    if (dependencies.contains(SlideProviderAspect.spec) &&
        spec != oldWidget.spec) {
      return true;
    }

    if (dependencies.contains(SlideProviderAspect.isSnapshot) &&
        isSnapshot != oldWidget.isSnapshot) {
      return true;
    }
    if (dependencies.contains(SlideProviderAspect.examples) &&
        examples != oldWidget.examples) {
      return true;
    }
    if (dependencies.contains(SlideProviderAspect.assets) &&
        assets != oldWidget.assets) {
      return true;
    }
    return false;
  }

  static Slide slideOf(BuildContext context) {
    return SlideProvider.of(context).slide;
  }

  static SlideSpec specOf(BuildContext context) {
    return SlideProvider.of(context).spec;
  }

  static bool isSnapshotOf(BuildContext context) {
    return SlideProvider.of(context).isSnapshot;
  }

  static List<SlideAsset> assetsOf(BuildContext context) {
    return SlideProvider.of(context).assets;
  }

// TODO: only get notified if the individual example changes
  static Map<String, Example> examplesOf(BuildContext context) {
    return SlideProvider.of(context).examples;
  }
}
