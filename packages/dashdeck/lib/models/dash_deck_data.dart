import 'package:dashdeck_core/dashdeck_core.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class DashDeckData {
  DashDeckData({
    required List<SlideData> slides,
    Map<String, Widget> previewWidgets = const {},
    Map<String, StyleMix> styles = const {},
  })  : _slides = slides,
        _previewWidgets = previewWidgets,
        _styles = styles;

  final List<SlideData> _slides;
  final Map<String, Widget> _previewWidgets;
  final Map<String, StyleMix> _styles;

  List<SlideData> get slides => _slides;

  StyleMix? _getMix(String id) {
    return _styles[id];
  }

  Widget? _getPreviewWidget(String name) {
    return _previewWidgets[name];
  }
}
