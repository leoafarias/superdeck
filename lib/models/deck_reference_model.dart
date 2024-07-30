import 'package:dart_mappable/dart_mappable.dart';

import 'asset_model.dart';
import 'config_model.dart';
import 'slide_model.dart';

part 'deck_reference_model.mapper.dart';

@MappableClass()
class DeckReference with DeckReferenceMappable {
  final Config config;
  final List<Slide> slides;
  final List<SlideAsset> assets;

  DeckReference({
    required this.config,
    required this.slides,
    required this.assets,
  });

  static const fromMap = DeckReferenceMapper.fromMap;
  static const fromJson = DeckReferenceMapper.fromJson;
}
