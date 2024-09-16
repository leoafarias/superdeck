import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/extensions.dart';
import '../../modules/common/styles/style_spec.dart';
import '../../modules/deck/deck_controller.dart';
import '../../modules/deck/deck_hooks.dart';
import '../../modules/deck/deck_provider.dart';
import '../../modules/deck/slide_provider.dart';
import '../atoms/cache_image_widget.dart';
import '../molecules/block_widget.dart';
import 'transition_widget.dart';

class SlideView extends HookWidget {
  final Slide slide;
  const SlideView(
    this.slide, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final transition = slide.options?.transition;

    final builders = useGetParts();
    final slideIndex = useGetSlideIndex(slide);

    final style = useGetSlideStyle(slide);

    final background = slide.options?.background;

    return TransitionWidget(
      key: ValueKey(transition),
      transition: transition,
      child: SpecBuilder(
          style: style,
          builder: (context) {
            final spec = SlideSpec.of(context);

            final configuration = SlideConfiguration(
              slide: slide,
              slideIndex: slideIndex,
              spec: spec,
              controller: context.watch<DeckProvider>().controller,
            );

            return SlideProvider(
              configuration: configuration,
              child: spec.slideContainer(
                child: Column(
                  children: [
                    _SlidePartBuilder(builders.header, configuration),
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
                                : const SizedBox(),
                          ),
                          Column(
                            children: slide.sections.map((section) {
                              final sectionFlex = section.options?.flex ?? 1;
                              final sectionAlignment = section.options?.align ??
                                  ContentAlignment.center;

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
                                        style: style.applyVariant(
                                            Variant(subSection.type.name)),
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
                        ],
                      ),
                    ),
                    _SlidePartBuilder(builders.footer, configuration),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _SlidePartBuilder extends StatelessWidget {
  final SlidePart? builder;
  final SlideConfiguration configuration;

  const _SlidePartBuilder(
    this.builder,
    this.configuration,
  );

  @override
  Widget build(BuildContext context) {
    if (builder == null) {
      return const SizedBox();
    }

    return SizedBox(
      height: builder!.height,
      child: builder?.build(configuration),
    );
  }
}
