import 'package:dash_deck/helpers/scale.dart';
import 'package:flutter/material.dart';

class SlideWrapper extends StatelessWidget {
  const SlideWrapper({this.child, Key? key}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: LayoutBuilder(builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          Scale.setupWith(Size(width, height), const Size(1280, 720));

          double maxWidth = Scale.scaleWidth(1280);
          double maxHeight = Scale.scaleHeight(720);

          return Theme(
            data: scaleTheme(context),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                minWidth: maxWidth,
                maxHeight: maxHeight,
                minHeight: maxHeight,
              ).normalize(),
              child: child,
            ),
          );
        }),
      ),
    );
  }
}
