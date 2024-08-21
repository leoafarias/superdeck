import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:superdeck_core/superdeck_core.dart';

class TransitionWidget extends StatelessWidget {
  final TransitionOptions? transition;
  final Widget child;

  const TransitionWidget({
    super.key,
    required this.transition,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final duration = transition?.duration ?? const Duration(milliseconds: 500);
    final delay = transition?.delay ?? const Duration(milliseconds: 0);
    final curve = _getCurveFromType(transition?.curve) ?? Curves.easeInOut;
    final type = transition?.type;

    if (type == null) return child;

    final buildAnimation = _getWidgetByType(type);
    return Container(
      child: buildAnimation(
        duration: duration,
        delay: delay,
        curve: curve,
        child: child,
      ),
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

Widget Function({
  required Duration duration,
  required Duration delay,
  required Curve curve,
  required Widget child,
}) _getWidgetByType(
  TransitionType type,
) {
  switch (type) {
    case TransitionType.fadeIn:
      return FadeIn.new;
    case TransitionType.fadeInDown:
      return FadeInDown.new;
    case TransitionType.fadeInDownBig:
      return FadeInDownBig.new;
    case TransitionType.fadeInUp:
      return FadeInUp.new;
    case TransitionType.fadeInUpBig:
      return FadeInUpBig.new;
    case TransitionType.fadeInLeft:
      return FadeInLeft.new;
    case TransitionType.fadeInLeftBig:
      return FadeInLeftBig.new;
    case TransitionType.fadeInRight:
      return FadeInRight.new;
    case TransitionType.fadeInRightBig:
      return FadeInRightBig.new;
    case TransitionType.fadeOut:
      return FadeOut.new;
    case TransitionType.fadeOutDown:
      return FadeOutDown.new;
    case TransitionType.fadeOutDownBig:
      return FadeOutDownBig.new;
    case TransitionType.fadeOutUp:
      return FadeOutUp.new;
    case TransitionType.fadeOutUpBig:
      return FadeOutUpBig.new;
    case TransitionType.fadeOutLeft:
      return FadeOutLeft.new;
    case TransitionType.fadeOutLeftBig:
      return FadeOutLeftBig.new;
    case TransitionType.fadeOutRight:
      return FadeOutRight.new;
    case TransitionType.fadeOutRightBig:
      return FadeOutRightBig.new;
    case TransitionType.bounceInDown:
      return BounceInDown.new;
    case TransitionType.bounceInUp:
      return BounceInUp.new;
    case TransitionType.bounceInLeft:
      return BounceInLeft.new;
    case TransitionType.bounceInRight:
      return BounceInRight.new;
    case TransitionType.elasticIn:
      return ElasticIn.new;
    case TransitionType.elasticInDown:
      return ElasticInDown.new;
    case TransitionType.elasticInUp:
      return ElasticInUp.new;
    case TransitionType.elasticInLeft:
      return ElasticInLeft.new;
    case TransitionType.elasticInRight:
      return ElasticInRight.new;
    case TransitionType.slideInDown:
      return SlideInDown.new;
    case TransitionType.slideInUp:
      return SlideInUp.new;
    case TransitionType.slideInLeft:
      return SlideInLeft.new;
    case TransitionType.slideInRight:
      return SlideInRight.new;
    case TransitionType.flipInX:
      return FlipInX.new;
    case TransitionType.flipInY:
      return FlipInY.new;
    case TransitionType.zoomIn:
      return ZoomIn.new;
    case TransitionType.zoomOut:
      return ZoomOut.new;
    case TransitionType.jelloIn:
      return JelloIn.new;
    case TransitionType.bounce:
      return Bounce.new;
    case TransitionType.dance:
      return Dance.new;
    case TransitionType.flash:
      return Flash.new;
    case TransitionType.pulse:
      return Pulse.new;
    case TransitionType.roulette:
      return Roulette.new;
    case TransitionType.shakeX:
      return ShakeX.new;
    case TransitionType.shakeY:
      return ShakeY.new;
    case TransitionType.spin:
      return Spin.new;
    case TransitionType.spinPerfect:
      return SpinPerfect.new;
    case TransitionType.swing:
      return Swing.new;
  }
}
