import 'package:dart_mappable/dart_mappable.dart';

import 'slide_model.dart';

part 'deck_data_model.mapper.dart';

@MappableClass()
class SlideAsset with SlideAssetMappable {
  final String name;
  final String base64;

  const SlideAsset({
    required this.name,
    required this.base64,
  });

  static const fromMap = SlideAssetMapper.fromMap;
  static const fromJson = SlideAssetMapper.fromJson;
}

@MappableClass()
class DeckData with DeckDataMappable {
  final List<SlideConfig> slides;
  final List<SlideAsset> assets;

  const DeckData({
    this.slides = const [],
    this.assets = const [],
  });

  static const fromMap = DeckDataMapper.fromMap;
  static const fromJson = DeckDataMapper.fromJson;
}
