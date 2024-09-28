import 'dart:math';

import 'package:flutter/material.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/controller.dart';
import '../../modules/common/helpers/converters.dart';
import '../../modules/slide/slide_configuration.dart';
import '../molecules/block_widget.dart';

class BlockHero extends StatelessWidget {
  const BlockHero({
    super.key,
    required this.block,
    required this.child,
  });

  final ContentBlock block;
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
        return markdownFlightBuilder(
          context: context,
          child: child,
          animation: animation,
          flightDirection: flightDirection,
          fromHeroContext: fromHeroContext,
          toHeroContext: toHeroContext,
        );
      },
      tag: block.hero!,
      child: child,
    );
  }
}

Widget markdownFlightBuilder({
  required BuildContext context,
  required Widget child,
  required Animation<double> animation,
  required HeroFlightDirection flightDirection,
  required BuildContext fromHeroContext,
  required BuildContext toHeroContext,
}) {
  final fromConfiguration = Controller.of<BlockController>(fromHeroContext);
  final toConfiguration = Controller.of<BlockController>(toHeroContext);

  final fromSlide = Controller.of<SlideController>(fromHeroContext);
  final toSlide = Controller.of<SlideController>(toHeroContext);

  return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final interpolatedSpec =
            fromConfiguration.spec.lerp(toConfiguration.spec, animation.value);
        final interpolateAlign = Alignment.lerp(
          ConverterHelper.toAlignment(fromConfiguration.block.align),
          ConverterHelper.toAlignment(toConfiguration.block.align),
          animation.value,
        )!;

        return Provider(
          controller: BlockController(
            spec: interpolatedSpec,
            block: toConfiguration.block,
          ),
          child: Align(
            alignment: interpolateAlign,
            child: child,
          ),
        );
      });
}

String lerpString(String start, String end, double t) {
  int maxLength = max(start.length, end.length);
  StringBuffer result = StringBuffer();
  Random rnd = Random();

  for (int i = 0; i < maxLength; i++) {
    double charProgress = (t * maxLength) - i;

    if (charProgress <= 0) {
      // Use character from the start string
      if (i < start.length) {
        result.write(start[i]);
      } else {
        result.write(' ');
      }
    } else if (charProgress > 0 && charProgress < 1) {
      // Use a scrambled character
      result.write(_getRandomCharacter(rnd));
    } else {
      // Use character from the end string
      if (i < end.length) {
        result.write(end[i]);
      } else {
        result.write(' ');
      }
    }
  }

  return result.toString();
}

String _getRandomCharacter(Random rnd) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return chars[rnd.nextInt(chars.length)];
}
