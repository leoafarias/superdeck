import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/template_builder.dart';
import '../../models/slide_model.dart';

class SlideView extends StatelessWidget {
  const SlideView(
    this.slide, {
    super.key,
  });

  final SlideConfig slide;

  @override
  Widget build(BuildContext context) {
    final config = slide;

    if (config is ImageSlideConfig) {
      return ImageSlide(config);
    } else if (config is TwoColumnSlideConfig) {
      return TwoColumnSlide(config);
    } else if (config is TwoColumnHeaderSlideConfig) {
      return TwoColumnHeaderSlide(config);
    } else if (config is SimpleSlideConfig) {
      return SimpleSlide(config);
    } else {
      throw UnimplementedError('Slide config not implemented');
    }
  }
}

class SlideWrapper extends StatelessWidget {
  const SlideWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      child: Center(
        child: AspectRatio(
          aspectRatio: kAspectRatio,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SlideConstraints(
                constraints: constraints,
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}

class SlideConstraints extends InheritedWidget {
  const SlideConstraints({
    required this.constraints,
    required super.child,
    super.key,
  });

  final BoxConstraints constraints;

  static SlideConstraints? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SlideConstraints>();
  }

  @override
  bool updateShouldNotify(SlideConstraints oldWidget) {
    return oldWidget.constraints != constraints;
  }
}
