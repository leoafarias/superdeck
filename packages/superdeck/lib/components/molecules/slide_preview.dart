import 'package:flutter/material.dart';

import '../../superdeck.dart';
import '../atoms/slide_view.dart';
import 'scaled_app.dart';

class SlidePreview<T extends Slide> extends StatelessWidget {
  const SlidePreview(
    this.slide, {
    super.key,
  });

  final T slide;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ScaledWidget(
          child: SlideView(slide),
        ),
      ),
    );
  }
}
