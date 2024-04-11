import 'package:flutter/material.dart';

import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../molecules/scaled_app.dart';
import '../molecules/slide_view.dart';

// ignore: non_constant_identifier_names
final SlidePreviewBox = Style(
  box.color.grey.shade900(),
  box.margin.all(8),
  box.maxHeight(140),
  box.shadow(
    color: Colors.black.withOpacity(0.5),
    blurRadius: 4,
    spreadRadius: 1,
  ),
).box;

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
      child: SlidePreviewBox(
        style: Style(
          box.border.all(
            color: selected ? Colors.blue : Colors.transparent,
            width: selected ? 2 : 0,
          ),
        ).animate(),
        child: AbsorbPointer(
          child: ScaledWidget(
            child: SlideView(slide),
          ),
        ),
      ),
    );
  }
}
