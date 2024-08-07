import 'package:flutter/material.dart';

import '../../providers/slide_provider.dart';
import '../../providers/style_provider.dart';
import '../../superdeck.dart';
import 'cache_image_widget.dart';
import 'transition_widget.dart';

class SlideView<T extends Slide> extends StatelessWidget {
  const SlideView(
    this.slide, {
    super.key,
  });

  final T slide;

  @override
  Widget build(BuildContext context) {
    final slide = this.slide;

    final variantStyle = StyleProvider.of(context, slide.style);

    final backgroundWidget = slide.background != null
        ? CacheImage(
            url: slide.background!,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          )
        : const SizedBox();

    return TransitionWidget(
      key: ValueKey(slide.transition),
      transition: slide.transition,
      child: SpecBuilder(
        style: variantStyle,
        builder: (context) {
          final spec = SlideSpec.of(context);
          return Builder(builder: (context) {
            return AnimatedBoxSpecWidget(
              spec: spec.outerContainer,
              duration: const Duration(milliseconds: 300),
              child: Stack(
                children: [
                  Positioned.fill(child: backgroundWidget),
                  AnimatedBoxSpecWidget(
                    spec: spec.innerContainer,
                    duration: const Duration(milliseconds: 300),
                    child: SlideBuilder(slide),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
