import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../helpers/layout_builder.dart';
import '../../helpers/measure_size.dart';
import '../../providers/slide_provider.dart';
import '../../superdeck.dart';
import 'image_widget.dart';
import 'transition_widget.dart';

class SlideView extends StatelessWidget {
  // If SlideView is a snapshot for image generation
  final bool _isSnapshot;
  const SlideView(
    this.slide, {
    super.key,
  }) : _isSnapshot = false;

  const SlideView.snapshot(
    this.slide, {
    super.key,
  }) : _isSnapshot = true;

  final Slide slide;

  @override
  Widget build(BuildContext context) {
    final provider = SuperDeckProvider.instance;
    final slide = this.slide;
    final variant = slide.styleVariant;
    final style = provider.style.watch(context);

    final variantStyle = style.applyVariant(variant);

    final backgroundWidget = slide.background != null
        ? CachedImage(
            url: slide.background!,
            fit: BoxFit.cover,
            size: kResolution,
            alignment: Alignment.center,
          )
        : const SizedBox();

    return TransitionWidget(
      key: ValueKey(slide.transition),
      transition: slide.transition,
      child: Pressable(
        onPress: () {},
        child: MixBuilder(
          style: variantStyle.animate(),
          builder: (mix) {
            final spec = SlideSpec.fromMix(mix);
            return Builder(builder: (context) {
              return AnimatedMixedBox(
                spec: spec.outerContainer,
                duration: Durations.medium1,
                child: Stack(
                  children: [
                    Positioned.fill(child: backgroundWidget),
                    AnimatedMixedBox(
                      spec: spec.innerContainer,
                      duration: const Duration(milliseconds: 300),
                      child: SlideProvider(
                        slide: slide,
                        spec: spec,
                        examples: provider.examples.watch(context),
                        isSnapshot: _isSnapshot,
                        child: SlideConstraints(
                          (_) {
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
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}

class SlideConstraintsProvider extends InheritedWidget {
  const SlideConstraintsProvider({
    required this.constraints,
    required super.child,
    super.key,
  });

  final BoxConstraints constraints;

  static BoxConstraints of(BuildContext context) {
    final slideConstraints =
        context.dependOnInheritedWidgetOfExactType<SlideConstraintsProvider>();
    if (slideConstraints == null) {
      throw Exception('SlideConstraints not found in context');
    }
    return slideConstraints.constraints;
  }

  @override
  bool updateShouldNotify(SlideConstraintsProvider oldWidget) {
    return oldWidget.constraints != constraints;
  }
}
