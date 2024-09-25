import 'package:flutter/material.dart';

import '../molecules/block_widget.dart';

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
        BuildContext toHeroContext,
      ) {
        Widget current = _flightShuttleBlockProvider(
          animation,
          fromHeroContext,
          toHeroContext,
          child,
        );

        return current;
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
  final toSize = BlockConfiguration.of(toHeroContext).size;
  final fromSize = BlockConfiguration.of(fromHeroContext).size;

  return AnimatedBuilder(
    animation: animation,
    child: child,
    builder: (context, child) {
      final interpolatedSize = Size.lerp(fromSize, toSize, animation.value)!;

      return BlockProvider(
        data: BlockConfiguration(size: interpolatedSize),
        child: child!,
      );
    },
  );
}
