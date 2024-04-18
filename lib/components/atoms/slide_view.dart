import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/layout_builder.dart';
import '../../helpers/measure_size.dart';
import '../../helpers/utils.dart';
import '../../models/asset_model.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../molecules/scaled_app.dart';
import 'transition_widget.dart';

class SlideView extends StatelessWidget {
  const SlideView(
    this.slide, {
    super.key,
  });

  final Slide slide;

  @override
  Widget build(BuildContext context) {
    final slide = this.slide;
    final variant = slide.styleVariant;
    final style = superdeck.style.watch(context);
    final assets = superdeck.assets.watch(context);

    return ScaledWidget(
      child: TransitionWidget(
        key: ValueKey(slide.transition),
        transition: slide.transition,
        child: MixBuilder(
          style: style.applyVariant(variant).animate(),
          builder: (mix) {
            final spec = SlideSpec.fromMix(mix);
            return AnimatedMixedBox(
              spec: spec.outerContainer,
              duration: Durations.medium1,
              child: AnimatedMixedBox(
                spec: _buildInnerContainerSpec(
                  slide,
                  spec.innerContainer,
                  assets,
                ),
                duration: const Duration(milliseconds: 300),
                child: SlideConstraintBuilder(
                  builder: (_, __) {
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
            );
          },
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

BoxSpec _buildInnerContainerSpec(
  Slide slide,
  BoxSpec spec,
  List<SlideAsset> assets,
) {
  final background = slide.background;
  if (background == null) {
    return spec;
  }

  final decoration = spec.decoration;

  if (decoration is BoxDecoration) {
    return spec.copyWith(
        decoration: decoration.copyWith(
      image: DecorationImage(
        image: getImageProvider(background, assets),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    ));
  }

  return spec.copyWith(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: getImageProvider(background, assets),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    ),
  );
}
