import 'package:flutter/material.dart';

import '../../helpers/measure_size.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';
import 'slide_view.dart';

final _previewStyle = AnimatedStyle(
  Style(
    box.color.grey.shade900(),
    box.margin.all(8),
    box.shadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 4,
      spreadRadius: 1,
    ),
  ),
  duration: const Duration(milliseconds: 300),
  curve: Curves.ease,
);

// ignore: non_constant_identifier_names
final PreviewBox = _previewStyle.box;

class SlideThumbnail extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final Slide slide;

  const SlideThumbnail({
    super.key,
    required this.selected,
    required this.onTap,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: PreviewBox(
        style: Style(
          box.border.all(
            color: selected ? Colors.blue : Colors.transparent,
            width: selected ? 2 : 0,
          ),
        ),
        child: AbsorbPointer(
          child: SlideConstraintBuilder(
            builder: (context, size) {
              return SlideView(slide);
            },
          ),
        ),
      ),
    );
  }
}
