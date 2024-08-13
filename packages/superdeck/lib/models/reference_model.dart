import 'package:dart_mappable/dart_mappable.dart';

import 'asset_model.dart';
import 'config_model.dart';
import 'slide_model.dart';

part 'reference_model.mapper.dart';

@MappableClass()
class SuperDeckReference with SuperDeckReferenceMappable {
  final Config config;
  final List<Slide> slides;
  final List<SlideAsset> assets;

  SuperDeckReference({
    required this.config,
    required this.slides,
    required this.assets,
  });

  const SuperDeckReference.empty()
      : config = const Config.empty(),
        slides = const [],
        assets = const [];

  static const fromMap = SuperDeckReferenceMapper.fromMap;
  static const fromJson = SuperDeckReferenceMapper.fromJson;
}
