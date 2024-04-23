// Create a SlideProvider that extends an Inherited widget
import 'package:flutter/material.dart';

import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../styles/style_spec.dart';

enum SlideProviderAspect {
  slide,
  spec,

  isExporting,
  examples,
}

class SlideProvider extends InheritedModel<SlideProviderAspect> {
  final Slide slide;
  final SlideSpec spec;

  // If slide is a snapshot for image generation
  final bool isSnapshot;
  final Map<String, Example> examples;

  const SlideProvider({
    super.key,
    required this.slide,
    required this.spec,
    required this.isSnapshot,
    required this.examples,
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

    if (dependencies.contains(SlideProviderAspect.isExporting) &&
        isSnapshot != oldWidget.isSnapshot) {
      return true;
    }
    if (dependencies.contains(SlideProviderAspect.examples) &&
        examples != oldWidget.examples) {
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

// TODO: only get notified if the individual example changes
  static Map<String, Example> examplesOf(BuildContext context) {
    return SlideProvider.of(context).examples;
  }
}
