import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../helpers/layout_builder.dart';
import '../../helpers/measure_size.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../atoms/transition_widget.dart';

class SlideView extends StatelessWidget {
  const SlideView(
    this.slide, {
    super.key,
  });

  final Slide slide;

  @override
  @override
  Widget build(BuildContext context) {
    final slide = this.slide;

    final style = SuperDeck.styleOf(context).applyVariant(slide.styleVariant);
    final projectTransition = SuperDeck.projectOptionsOf(context).transition;

    final transition =
        projectTransition?.merge(slide.transition) ?? slide.transition;

    return TransitionWidget(
      key: ValueKey(transition),
      transition: transition,
      child: MixBuilder(
        style: style.animate(),
        key: ValueKey(slide),
        builder: (mix) {
          final spec = SlideSpec.of(mix);
          return AnimatedMixedBox(
            spec: spec.innerContainer,
            duration: const Duration(milliseconds: 300),
            child: Container(
              decoration: _backgroundDecoration(slide.background),
              child: SlideConstraintBuilder(builder: (_, __) {
                if (slide is SimpleSlide) {
                  return SimpleSlideBuilder(config: slide);
                } else if (slide is WidgetSlide) {
                  return WidgetSlideBuilder(config: slide);
                } else if (slide is ImageSlide) {
                  return ImageSlideBuilder(config: slide);
                } else if (slide is TwoColumnSlide) {
                  return TwoColumnSlideBuilder(config: slide);
                } else if (slide is TwoColumnHeaderSlide) {
                  return TwoColumnHeaderSlideBuilder(config: slide);
                } else if (slide is InvalidSlide) {
                  return InvalidSlideBuilder(config: slide);
                } else {
                  throw UnimplementedError(
                    'Slide config not implemented',
                  );
                }
              }),
            ),
          );
        },
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

  static BoxConstraints of(BuildContext context) {
    final slideConstraints =
        context.dependOnInheritedWidgetOfExactType<SlideConstraints>();
    if (slideConstraints == null) {
      throw Exception('SlideConstraints not found in context');
    }
    return slideConstraints.constraints;
  }

  @override
  bool updateShouldNotify(SlideConstraints oldWidget) {
    return oldWidget.constraints != constraints;
  }
}

BoxDecoration? _backgroundDecoration(String? background) {
  ImageProvider imageProvider;

  if (background == null) {
    return null;
  }

  if (background.startsWith('http')) {
    imageProvider = CachedNetworkImageProvider(background);
  } else {
    imageProvider = AssetImage(background);
  }
  return BoxDecoration(
    image: DecorationImage(
      image: imageProvider,
      fit: BoxFit.cover,
    ),
  );
}
