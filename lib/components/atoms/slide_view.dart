import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/layout_builder.dart';
import '../../helpers/measure_size.dart';
import '../../helpers/utils.dart';
import '../../models/asset_model.dart';
import '../../models/slide_model.dart';
import '../../providers/slide_provider.dart';
import '../../superdeck.dart';
import '../molecules/scaled_app.dart';
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
    final slide = this.slide;
    final variant = slide.styleVariant;
    final style = superdeck.style.watch(context);
    final assets = superdeck.assets.watch(context);

    final variantStyle = style.applyVariant(variant);

    return Center(
      child: ScaledWidget(
        child: TransitionWidget(
          key: ValueKey(slide.transition),
          transition: slide.transition,
          child: Pressable(
            onPress: () {},
            child: MixBuilder(
              key: ValueKey(variantStyle),
              style: variantStyle.animate(),
              builder: (mix) {
                final spec = SlideSpec.fromMix(mix);
                return Builder(builder: (context) {
                  return AnimatedMixedBox(
                    spec: spec.outerContainer,
                    duration: Durations.medium1,
                    child: AnimatedMixedBox(
                      spec: _buildInnerContainerSpec(
                        slide: slide,
                        spec: spec.innerContainer,
                        assets: assets,
                        context: context,
                      ),
                      duration: const Duration(milliseconds: 300),
                      child: SlideProvider(
                        slide: slide,
                        spec: spec,
                        assets: assets,
                        examples: superdeck.examples.watch(context),
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
                  );
                });
              },
            ),
          ),
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

BoxSpec _buildInnerContainerSpec({
  required Slide slide,
  required BoxSpec spec,
  required List<SlideAsset> assets,
  required BuildContext context,
}) {
  final background = slide.background;
  if (background == null) {
    return spec;
  }
  final uri = Uri.tryParse(background);

  if (uri == null) {
    return spec;
  }

  final decoration = spec.decoration;

  final imageProvider = getImageProvider(uri, assets);

  if (decoration is BoxDecoration) {
    final innerContainerSpecImage = decoration.image;
    final mix = MixProvider.of(context);
    final backgroundDecorationDto = DecorationImageDto(
      image: imageProvider,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );

    if (innerContainerSpecImage == null) {
      return spec.copyWith(
        decoration: decoration.copyWith(
          image: backgroundDecorationDto.resolve(mix),
        ),
      );
    }

    final decorationDto = DecorationImageDto.from(innerContainerSpecImage);

    final newDecoration = backgroundDecorationDto
        .merge(decorationDto)
        .merge(DecorationImageDto(image: imageProvider));

    return spec.copyWith(
      decoration: decoration.copyWith(
        image: newDecoration.resolve(mix),
      ),
    );
  }

  return spec.copyWith(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    ),
  );
}
