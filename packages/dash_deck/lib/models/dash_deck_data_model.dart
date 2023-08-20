import 'package:dash_deck/models/slide_data.model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mix/mix.dart';

part 'dash_deck_data_model.freezed.dart';

@freezed
class DashDeckData with _$DashDeckData {
  factory DashDeckData({
    required List<SlideData> slides,
    @Default({}) Map<String, Widget> previewWidgets,
    @Default({}) Map<String, StyleMix> styles,
  }) = _DashDeckData;
}
