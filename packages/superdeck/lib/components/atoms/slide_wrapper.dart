import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/scale.dart';

class SlideWrapper extends StatelessWidget {
  const SlideWrapper({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: kAspectRatio,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            Scale.setupWith(Size(width, height), const Size(kWidth, kHeight));

            return SlideConstraints(
              constraints: constraints,
              child: Theme(
                data: scaleTheme(context),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SlideConstraints extends InheritedWidget {
  const SlideConstraints({
    required this.constraints,
    required super.child,
    super.key,
  });

  final BoxConstraints constraints;

  static SlideConstraints? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SlideConstraints>();
  }

  @override
  bool updateShouldNotify(SlideConstraints oldWidget) {
    return oldWidget.constraints != constraints;
  }
}
