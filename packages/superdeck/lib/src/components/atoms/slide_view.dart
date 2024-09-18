import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/styles/style_spec.dart';
import '../../modules/deck/deck_controller.dart';
import '../../modules/deck/slide_provider.dart';
import '../molecules/block_widget.dart';

class SlideView extends HookWidget {
  final int slideIndex;
  const SlideView(
    this.slideIndex, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final controller = DeckController.of(context);

    return SlideConfigurationBuilder(
      slideIndex: slideIndex,
      controller: controller,
      builder: (context, configuration) {
        final spec = configuration.spec;
        final style = configuration.slideStyle;
        final slide = configuration.slide;

        return spec.slideContainer(
          child: Column(
            children: [
              configuration.buildHeader(),
              Expanded(
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
                              style: style
                                  .applyVariant(Variant(subSection.type.name)),
                              builder: (context) {
                                final spec = SlideSpec.of(context);
                                return Expanded(
                                  flex: subSectionFlex,
                                  child: spec.contentContainer(
                                    child: Align(
                                      alignment: toAlignment(
                                        subSectionAlignment,
                                      ),
                                      child: BlockWidget(subSection),
                                    ),
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
              configuration.buildFooter(),
            ],
          ),
        );
      },
    );
  }
}
