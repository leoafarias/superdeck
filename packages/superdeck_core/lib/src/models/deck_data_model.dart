import 'package:dart_mappable/dart_mappable.dart';

import '../../superdeck_core.dart';

part 'deck_data_model.mapper.dart';

@MappableClass()
class DeckData with DeckDataMappable {
  final List<Slide> slides;

  const DeckData({
    this.slides = const [],
  });

  static final fromMap = DeckDataMapper.fromMap;
  static final fromJson = DeckDataMapper.fromJson;
}
