import 'package:flutter/material.dart';

import '../../modules/common/helpers/controller.dart';
import '../molecules/block_widget.dart';

class BlockHero extends StatelessWidget {
  const BlockHero({
    super.key,
    required this.tag,
    required this.child,
  });

  final Object tag;
  final Widget child;

  @override
  Widget build(context) {
    return Hero(
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        return _flightShuttleBlockProvider(
          animation,
          fromHeroContext,
          toHeroContext,
          child,
        );
      },
      tag: tag,
      child: child,
    );
  }
}

Widget _flightShuttleBlockProvider(
  Animation<double> animation,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
  Widget child,
) {
  final fromConfiguration = Provider.ofType<BlockController>(fromHeroContext);
  final toConfiguration = Provider.ofType<BlockController>(toHeroContext);
  return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final interpolatedSize = Size.lerp(
            fromConfiguration.size, toConfiguration.size, animation.value)!;
        final interpolatedSpec =
            fromConfiguration.spec.lerp(toConfiguration.spec, animation.value);

        return Provider(
          controller: BlockController(
            size: interpolatedSize,
            spec: interpolatedSpec,
            isCapturing: true,
          ),
          child: child,
        );
      });
}
