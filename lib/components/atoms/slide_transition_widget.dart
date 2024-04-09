import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../models/options_model.dart';

class SlideTransitionWidget extends StatelessWidget {
  final TransitionOptions? transition;
  final Widget child;

  const SlideTransitionWidget({
    super.key,
    required this.transition,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (transition?.type == null) return child;

    return Container(
      child: _getWidgetByType(transition!, child),
    );
  }
}

Curve? _getCurveFromType(CurveType? curveType) {
  switch (curveType) {
    case CurveType.easeInOut:
      return Curves.easeInOut;
    case CurveType.easeIn:
      return Curves.easeIn;
    case CurveType.easeOut:
      return Curves.easeOut;
    case CurveType.linear:
      return Curves.linear;
    case CurveType.decelerate:
      return Curves.decelerate;
    case CurveType.fastLinearToSlowEaseIn:
      return Curves.fastLinearToSlowEaseIn;
    case CurveType.bounceIn:
      return Curves.bounceIn;
    case CurveType.bounceOut:
      return Curves.bounceOut;
    case CurveType.elasticIn:
      return Curves.elasticIn;
    case CurveType.elasticOut:
      return Curves.elasticOut;
    case CurveType.elasticInOut:
      return Curves.elasticInOut;
    case CurveType.fastOutSlowIn:
      return Curves.fastOutSlowIn;
    case CurveType.slowMiddle:
      return Curves.slowMiddle;
    case CurveType.linearToEaseOut:
      return Curves.linearToEaseOut;
    case CurveType.ease:
      return Curves.ease;
    default:
      return null;
  }
}

Widget _getWidgetByType(TransitionOptions transition, Widget child) {
  final duration = transition.duration ?? const Duration(milliseconds: 500);
  final delay = transition.delay ?? const Duration(milliseconds: 0);
  final curve = _getCurveFromType(transition.curve) ?? Curves.easeInOut;
  final type = transition.type;
  switch (type) {
    case TransitionType.fadeIn:
      return FadeIn(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeInDown:
      return FadeInDown(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeInDownBig:
      return FadeInDownBig(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeInUp:
      return FadeInUp(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeInUpBig:
      return FadeInUpBig(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeInLeft:
      return FadeInLeft(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeInLeftBig:
      return FadeInLeftBig(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeInRight:
      return FadeInRight(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeInRightBig:
      return FadeInRightBig(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeOut:
      return FadeOut(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeOutDown:
      return FadeOutDown(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeOutDownBig:
      return FadeOutDownBig(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeOutUp:
      return FadeOutUp(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeOutUpBig:
      return FadeOutUpBig(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeOutLeft:
      return FadeOutLeft(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeOutLeftBig:
      return FadeOutLeftBig(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeOutRight:
      return FadeOutRight(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.fadeOutRightBig:
      return FadeOutRightBig(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.bounceInDown:
      return BounceInDown(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.bounceInUp:
      return BounceInUp(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.bounceInLeft:
      return BounceInLeft(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.bounceInRight:
      return BounceInRight(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.elasticIn:
      return ElasticIn(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.elasticInDown:
      return ElasticInDown(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.elasticInUp:
      return ElasticInUp(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.elasticInLeft:
      return ElasticInLeft(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.elasticInRight:
      return ElasticInRight(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.slideInDown:
      return SlideInDown(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.slideInUp:
      return SlideInUp(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.slideInLeft:
      return SlideInLeft(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.slideInRight:
      return SlideInRight(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.flipInX:
      return FlipInX(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.flipInY:
      return FlipInY(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.zoomIn:
      return ZoomIn(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.zoomOut:
      return ZoomOut(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.jelloIn:
      return JelloIn(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.bounce:
      return Bounce(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.dance:
      return Dance(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.flash:
      return Flash(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.pulse:
      return Pulse(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.roulette:
      return Roulette(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.shakeX:
      return ShakeX(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.shakeY:
      return ShakeY(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.spin:
      return Spin(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.spinPerfect:
      return SpinPerfect(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
    case TransitionType.swing:
      return Swing(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      );
  }
}
