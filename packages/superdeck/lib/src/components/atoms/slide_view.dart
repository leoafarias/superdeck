import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/styles/style_spec.dart';
import '../../modules/deck/deck_controller.dart';
import '../../modules/deck/deck_hooks.dart';
import '../../modules/deck/slide_provider.dart';
import '../atoms/cache_image_widget.dart';
import '../molecules/block_widget.dart';

class SlideView extends HookWidget {
  final Slide slide;
  const SlideView(
    this.slide, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final slideIndex = useGetSlideIndex(slide);

    final style = useGetSlideStyle(slide);

    final background = slide.options?.background;

    return SpecBuilder(
      style: style,
      builder: (context) {
        final spec = SlideSpec.of(context);
        final controller = DeckController.of(context);

        final configuration = SlideConfiguration(
          slide: slide,
          slideStyle: style,
          slideIndex: slideIndex,
          spec: spec,
          controller: controller,
        );

        return SlideConfigurationProvider(
          configuration: configuration,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: background != null
                          ? CacheImage(
                              uri: Uri.parse(background),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            )
                          : controller.buildBackground(),
                    ),
                    spec.slideContainer(
                      child: Column(
                        children: slide.sections.map((section) {
                          final sectionFlex = section.options?.flex ?? 1;
                          final sectionAlignment =
                              section.options?.align ?? ContentAlignment.center;

                          return Expanded(
                            flex: sectionFlex,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: section.subSections.map(
                                (subSection) {
                                  final subSectionFlex =
                                      subSection.options?.flex ?? 1;
                                  final subSectionAlignment =
                                      subSection.options?.align ??
                                          ContentAlignment.center;
                                  return SpecBuilder(
                                    style: style.applyVariant(Variant(
                                      subSection.type.name,
                                    )),
                                    builder: (context) {
                                      return Expanded(
                                        flex: subSectionFlex,
                                        child: Align(
                                          alignment: toAlignment(
                                            subSectionAlignment,
                                          ),
                                          child: BlockWidget(subSection),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
