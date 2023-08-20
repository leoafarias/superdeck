import 'package:collection/collection.dart';
import 'package:dash_deck_core/dash_deck_core.dart';
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final collectionEquals = const DeepCollectionEquality().equals;

    return other is DashDeckData &&
        collectionEquals(other._slides, _slides) &&
        collectionEquals(other._previewWidgets, _previewWidgets) &&
        collectionEquals(other._styles, _styles);
  }

  @override
  int get hashCode =>
      _slides.hashCode ^ _previewWidgets.hashCode ^ _styles.hashCode;
}
