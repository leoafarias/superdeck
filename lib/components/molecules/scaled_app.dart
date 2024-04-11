import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../../helpers/constants.dart';

class ScaledWidget extends StatelessWidget {
  final Widget child;

  const ScaledWidget({
    super.key,
    required this.child,
  });

  static double of(BuildContext context) => ScaledWidgetProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double height = constraints.maxHeight;
        final double width = height * kAspectRatio;
        final double scale = width / kResolution.width;

        return SizedBox(
          width: width,
          height: height,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                const Center(),
                Positioned(
                  top: (kResolution.height - height) / -2,
                  left: (kResolution.width - width) / -2,
                  width: kResolution.width.toDouble(),
                  height: kResolution.height.toDouble(),
                  child: Transform.scale(
                    scale: scale,
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(size: kResolution),
                      child: ScaledWidgetProvider(
                        scale: scale,
                        child: child,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

//  create inherited widget that can pass teh scale factor to the child widget
class ScaledWidgetProvider extends InheritedWidget {
  const ScaledWidgetProvider({
    required this.scale,
    required super.child,
    super.key,
  });

  final double scale;

  static double of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ScaledWidgetProvider>()!
        .scale;
  }

  @override
  bool updateShouldNotify(ScaledWidgetProvider oldWidget) {
    return oldWidget.scale != scale;
  }
}
