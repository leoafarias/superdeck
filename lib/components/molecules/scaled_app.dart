import 'package:flutter/widgets.dart';

import '../../helpers/constants.dart';

class ScaledApp extends StatelessWidget {
  final Widget Function(BuildContext context, double scale) builder;

  const ScaledApp({
    super.key,
    required this.builder,
  });

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
                      child: builder(context, scale),
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
