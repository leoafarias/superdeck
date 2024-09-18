import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

class HeaderPart extends SlidePart {
  const HeaderPart({
    super.key,
  });

  @override
  double get height => 40;

  @override
  Widget build(BuildContext context) {
    final configuration = context.slide;
    final slide = context.slide.slide;
    final index = configuration.slideIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(slide.options?.title ?? 'Generative UIs'),
          Text('${index + 1}'),
        ],
      ),
    );
  }
}
