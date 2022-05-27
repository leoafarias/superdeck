import 'package:dash_deck/dash_deck.dart';
import 'package:dash_deck/models/slide_data.model.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class DashDeckData {
  DashDeckData({
    required List<Slide> slides,
    Map<String, Widget> previewWidgets = const {},
    Map<String, Mix> mixes = const {},
  })  : _slides = slides,
        _previewWidgets = previewWidgets,
        _mixes = mixes;

  final List<Slide> _slides;
  final Map<String, Widget> _previewWidgets;
  final Map<String, Mix> _mixes;

  List<SlideData>? _slidesCache;

  List<SlideData> get slides {
    return _slidesCache ??= _slides
        .map<SlideData>((e) => SlideData(
              id: e.id,
              content: e.content,
              snippets: e.snippets,
              options: e.options,
              mix: _getMix(e.id),
              previewWidget: _getPreviewWidget(e.id),
            ))
        .toList();
  }

  Mix? _getMix(String id) {
    return _mixes[id];
  }

  Widget? _getPreviewWidget(String name) {
    return _previewWidgets[name];
  }
}
