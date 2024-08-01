import 'package:flutter/material.dart';

import '../../helpers/utils.dart';
import '../../superdeck.dart';
import '../atoms/slide_view.dart';
import 'scaled_app.dart';
import 'split_view.dart';

class SlidePreview<T extends Slide> extends StatelessWidget {
  const SlidePreview(
    this.slide, {
    super.key,
  });

  final T slide;

  @override
  Widget build(BuildContext context) {
    final panelSize = SplitViewProvider.panelSizeOf(context);
    var paddingSize = panelSize / (context.isSmall ? 5.0 : 20.0);

    return Center(
      child: Container(
        margin: EdgeInsets.all(paddingSize),
        decoration: BoxDecoration(
          color: const Color.fromARGB(144, 0, 0, 0),
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
