import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_deck_core/dash_deck_core.dart';

part 'dash_deck_data_model.mapper.dart';

@MappableClass()
class DashDeckData with DashDeckDataMappable {
  final List<SlideData> slides;
  const DashDeckData({
    this.slides = const [],
  });

  static final fromMap = DashDeckDataMapper.fromMap;
  static final fromJson = DashDeckDataMapper.fromJson;

  static fromSlidesJson(String slidesJson) {
    final slides =
        jsonDecode(slidesJson).map((e) => SlideData.fromMap(e)).toList();
    return DashDeckData(slides: List<SlideData>.from(slides));
  }
}
