import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class BlockHero extends StatelessWidget {
  const BlockHero({
    super.key,
    required this.tag,
    required this.child,
  });

  final String tag;
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
          context,
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
  BuildContext context,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
  Widget child,
) {
  // final toSize = BlockConfiguration.of(toHeroContext).size;
  // final fromSize = BlockConfiguration.of(fromHeroContext).size;

  return Mix(
    data: Mix.of(context),
    child: AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        // final interpolatedSize = Size.lerp(fromSize, toSize, animation.value)!;

        return child!;
      },
    ),
  );
}
