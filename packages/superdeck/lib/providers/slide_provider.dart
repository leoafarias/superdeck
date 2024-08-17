// Create a SlideProvider that extends an Inherited widget
import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../models/slide_model.dart';
import '../templates/templates.dart';

enum SlideProviderAspect {
  slide,
  constraints,
}

class SlideProvider<T extends Slide> extends InheritedWidget {
  const SlideProvider({
    super.key,
    required this.slide,
    required super.child,
  });

  final T slide;

  static T of<T extends Slide>(BuildContext context) {
    final slideProvider =
        context.dependOnInheritedWidgetOfExactType<SlideProvider<T>>();
    if (slideProvider == null) {
      throw Exception('SlideProvider not found in context');
    }
    return slideProvider.slide;
  }

  @override
  bool updateShouldNotify(covariant SlideProvider<T> oldWidget) {
    return oldWidget.slide != slide;
  }
}

class SlideBuilder extends StatelessWidget {
  const SlideBuilder(
    this.config, {
    super.key,
  });

  final Slide config;

  @override
  Widget build(BuildContext context) {
    return SlideProvider(
      slide: config,
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(kResolution),
        child: TemplateBuilder.buildTemplate(config),
      ),
    );
  }
}
