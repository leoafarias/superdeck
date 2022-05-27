import 'package:dash_deck/dash_deck.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class SlideData extends Slide {
  const SlideData({
    required super.id,
    super.content,
    super.snippets,
    super.options,
    Mix? mix,
    this.previewWidget,
  }) : _mix = mix ?? Mix.constant;

  final Widget? previewWidget;
  final Mix _mix;

  Mix get mix => _mix;
}
