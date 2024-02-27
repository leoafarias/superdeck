import 'package:dart_mappable/dart_mappable.dart';

import 'slide_model.dart';

part 'deck_data_model.mapper.dart';

@MappableClass()
class DeckData with DeckDataMappable {
  final List<SlideConfig> slides;

  const DeckData({
    this.slides = const [],
  });

  static const fromMap = DeckDataMapper.fromMap;
  static const fromJson = DeckDataMapper.fromJson;
}
