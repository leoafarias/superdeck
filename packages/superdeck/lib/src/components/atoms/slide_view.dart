import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../modules/common/styles/style_spec.dart';
import '../../modules/slide/slide_configuration.dart';
import '../molecules/block_widget.dart';

class SlideView extends StatelessWidget {
  final SlideConfiguration slide;
  const SlideView(
    this.slide, {
    super.key,
    this.isCapturing = false,
  });

  final bool isCapturing;

  @override
  Widget build(BuildContext context) {
    return SlideConfigurationProvider(
      configuration: slide,
      isCapturing: isCapturing,
      child: SpecBuilder(
        style: slide.style,
        builder: (context) {
          final spec = SlideSpec.of(context);
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: slide.buildBackground(),
                    ),
                    spec.slideContainer(
                      child: Column(
                        children:
                            slide.sections.map(SectionBlockWidget.new).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
