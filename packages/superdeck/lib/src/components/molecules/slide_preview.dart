import 'package:flutter/material.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../atoms/slide_view.dart';

class SlidePreview<T extends Slide> extends StatelessWidget {
  const SlidePreview(
    this.slideIndex, {
    super.key,
  });

  final int slideIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 3,
            ),
          ],
        ),
        child: SlideView(slideIndex),
      ),
    );
  }
}
