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
  return switch (curveType) {
    CurveType.easeInOut => Curves.easeInOut,
    CurveType.easeIn => Curves.easeIn,
    CurveType.easeOut => Curves.easeOut,
    CurveType.linear => Curves.linear,
    CurveType.decelerate => Curves.decelerate,
    CurveType.fastLinearToSlowEaseIn => Curves.fastLinearToSlowEaseIn,
    CurveType.bounceIn => Curves.bounceIn,
    CurveType.bounceOut => Curves.bounceOut,
    CurveType.elasticIn => Curves.elasticIn,
    CurveType.elasticOut => Curves.elasticOut,
    CurveType.elasticInOut => Curves.elasticInOut,
    CurveType.fastOutSlowIn => Curves.fastOutSlowIn,
    CurveType.slowMiddle => Curves.slowMiddle,
    CurveType.linearToEaseOut => Curves.linearToEaseOut,
    CurveType.ease => Curves.ease,
    _ => null,
  };
}

Widget Function({
  required Duration duration,
  required Duration delay,
  required Curve curve,
  required Widget child,
}) _getWidgetByType(
  TransitionType type,
) {
  return switch (type) {
    TransitionType.fadeIn => FadeIn.new,
    TransitionType.fadeInDown => FadeInDown.new,
    TransitionType.fadeInDownBig => FadeInDownBig.new,
    TransitionType.fadeInUp => FadeInUp.new,
    TransitionType.fadeInUpBig => FadeInUpBig.new,
    TransitionType.fadeInLeft => FadeInLeft.new,
    TransitionType.fadeInLeftBig => FadeInLeftBig.new,
    TransitionType.fadeInRight => FadeInRight.new,
    TransitionType.fadeInRightBig => FadeInRightBig.new,
    TransitionType.fadeOut => FadeOut.new,
    TransitionType.fadeOutDown => FadeOutDown.new,
    TransitionType.fadeOutDownBig => FadeOutDownBig.new,
    TransitionType.fadeOutUp => FadeOutUp.new,
    TransitionType.fadeOutUpBig => FadeOutUpBig.new,
    TransitionType.fadeOutLeft => FadeOutLeft.new,
    TransitionType.fadeOutLeftBig => FadeOutLeftBig.new,
    TransitionType.fadeOutRight => FadeOutRight.new,
    TransitionType.fadeOutRightBig => FadeOutRightBig.new,
    TransitionType.bounceInDown => BounceInDown.new,
    TransitionType.bounceInUp => BounceInUp.new,
    TransitionType.bounceInLeft => BounceInLeft.new,
    TransitionType.bounceInRight => BounceInRight.new,
    TransitionType.elasticIn => ElasticIn.new,
    TransitionType.elasticInDown => ElasticInDown.new,
    TransitionType.elasticInUp => ElasticInUp.new,
    TransitionType.elasticInLeft => ElasticInLeft.new,
    TransitionType.elasticInRight => ElasticInRight.new,
    TransitionType.slideInDown => SlideInDown.new,
    TransitionType.slideInUp => SlideInUp.new,
    TransitionType.slideInLeft => SlideInLeft.new,
    TransitionType.slideInRight => SlideInRight.new,
    TransitionType.flipInX => FlipInX.new,
    TransitionType.flipInY => FlipInY.new,
    TransitionType.zoomIn => ZoomIn.new,
    TransitionType.zoomOut => ZoomOut.new,
    TransitionType.jelloIn => JelloIn.new,
    TransitionType.bounce => Bounce.new,
    TransitionType.dance => Dance.new,
    TransitionType.flash => Flash.new,
    TransitionType.pulse => Pulse.new,
    TransitionType.roulette => Roulette.new,
    TransitionType.shakeX => ShakeX.new,
    TransitionType.shakeY => ShakeY.new,
    TransitionType.spin => Spin.new,
    TransitionType.spinPerfect => SpinPerfect.new,
    TransitionType.swing => Swing.new,
  };
}
