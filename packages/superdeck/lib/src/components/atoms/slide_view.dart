import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/styles/style_spec.dart';
import '../../modules/deck_reference/deck_reference_hooks.dart';
import '../atoms/cache_image_widget.dart';
import '../molecules/block_widget.dart';
import 'transition_widget.dart';

class SlideView extends HookWidget {
  final Slide config;
  const SlideView(
    this.config, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final slide = config;

    final transition = slide.options?.transition;

    final style = useDeckStyle(config);
    final background = config.options?.background;

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
          style: style,
          builder: (context) {
            final spec = SlideSpec.of(context);

            return spec.slideContainer(
              child: Stack(
                children: [
                  Positioned.fill(child: backgroundWidget),
                  Column(
                    children: config.sections.map((section) {
                      final sectionFlex = section.options?.flex ?? 1;
                      final sectionAlignment =
                          section.options?.align ?? ContentAlignment.center;

                      return Expanded(
                        flex: sectionFlex,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: section.subSections.map((subSection) {
                            final subSectionFlex =
                                subSection.options?.flex ?? 1;
                            final subSectionAlignment =
                                subSection.options?.align ??
                                    ContentAlignment.center;
                            return SpecBuilder(
                                style: style.applyVariant(
                                    Variant(subSection.type.name)),
                                builder: (context) {
                                  final spec = SlideSpec.of(context);
                                  return Expanded(
                                    flex: subSectionFlex,
                                    child: spec.contentContainer(
                                      child: Align(
                                        alignment:
                                            toAlignment(subSectionAlignment),
                                        child: BlockWidget(subSection),
                                      ),
                                    ),
                                  );
                                });
                          }).toList(),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
