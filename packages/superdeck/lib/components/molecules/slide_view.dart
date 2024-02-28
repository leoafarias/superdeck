import 'package:flutter/material.dart';

import '../../helpers/scale.dart';
import '../../helpers/template_builder.dart';
import '../../models/slide_model.dart';
import '../atoms/slide_wrapper.dart';

class SlideView extends StatelessWidget {
  const SlideView(
    this.slide, {
    super.key,
  });

  final SlideConfig slide;

  @override
  Widget build(BuildContext context) {
    final config = slide;
    TemplateBuilder builder;

    if (config is ImageSlideConfig) {
      builder = ImageSlideBuilder(config);
    } else if (config is TwoColumnSlideConfig) {
      builder = TwoColumnSlideBuilder(config);
    } else if (config is TwoColumnHeaderSlideConfig) {
      builder = TwoColumnHeaderSlideConfigBuilder(config);
    } else if (config is SimpleSlideConfig) {
      builder = SimpleSlideBuilder(config);
    } else {
      throw UnimplementedError('Slide config not implemented');
    }
    final constraints = SlideConstraints.of(context)!.constraints;
    final paddingSize = EdgeInsets.all(40.0.sh);

    final constraintsWithPadding = constraints.deflate(paddingSize).normalize();

    return SlideConstraints(
      constraints: constraintsWithPadding,
      child: Padding(
        padding: paddingSize,
        child: builder.build(context),
      ),
    );
  }
}
