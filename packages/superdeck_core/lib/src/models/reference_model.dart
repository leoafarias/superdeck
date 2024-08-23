part of 'models.dart';

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

  static SuperDeckReference loadFile(File file) {
    try {
      return fromJson(file.readAsStringSync());
    } catch (e) {
      return SuperDeckReference(assets: [], slides: [], config: Config.empty());
    }
  }

  const SuperDeckReference.empty()
      : config = const Config.empty(),
        slides = const [],
        assets = const [];

  static const fromMap = SuperDeckReferenceMapper.fromMap;
  static const fromJson = SuperDeckReferenceMapper.fromJson;
}
