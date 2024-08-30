import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/constants.dart';
import '../../modules/common/styles/style_spec.dart';
import '../../modules/deck_reference/deck_reference_hooks.dart';
import '../../modules/widget_capture/snapshot_provider.dart';
import '../molecules/slide_template.dart';
import 'cache_image_widget.dart';
import 'transition_widget.dart';

class SlideView extends HookWidget {
  const SlideView(
    this.slide, {
    super.key,
  });

  final Slide slide;

  @override
  Widget build(BuildContext context) {
    final slide = this.slide;
    final background = slide.options?.background;
    final transition = slide.options?.transition;

    final variantStyle = useDeckStyle(slide);

    final isCapturing = SnapshotProvider.isCapturingOf(context);
    final duration =
        isCapturing ? Duration.zero : const Duration(milliseconds: 300);

    final backgroundWidget = background != null
        ? CacheImage(
            uri: Uri.parse(background),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          )
        : const SizedBox();

    return TransitionWidget(
      key: ValueKey(transition),
      transition: transition,
      child: SpecBuilder(
        style: variantStyle,
        builder: (context) {
          final spec = SlideSpec.of(context);
          return Builder(builder: (context) {
            return AnimatedBoxSpecWidget(
              spec: spec.outerContainer,
              duration: duration,
              child: Stack(
                children: [
                  Positioned.fill(child: backgroundWidget),
                  ConstrainedBox(
                    constraints: BoxConstraints.tight(kResolution),
                    child: SlideTemplate(slide),
                  )
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
