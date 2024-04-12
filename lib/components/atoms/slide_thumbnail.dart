import 'package:flutter/material.dart';

import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../molecules/scaled_app.dart';
import '../molecules/slide_view.dart';

final previewStyle = AnimatedStyle(
  Style(
    box.color.grey.shade900(),
    box.margin.all(8),
    box.maxHeight(140),
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
final PreviewBox = previewStyle.box;

class SlideThumbnail extends StatelessWidget {
  final Slide slide;
  final bool selected;
  final VoidCallback onTap;

  const SlideThumbnail({
    super.key,
    required this.slide,
    required this.selected,
    required this.onTap,
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
          child: ScaledWidget(
            child: SlideView(slide),
          ),
        ),
      ),
    );
  }
}
