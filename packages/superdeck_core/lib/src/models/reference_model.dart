part of 'models.dart';

@MappableClass()
class ReferenceDto with ReferenceDtoMappable {
  final Config config;
  final List<Slide> slides;
  final List<SlideAsset> assets;

  ReferenceDto({
    required this.config,
    required this.slides,
    required this.assets,
  });

  static ReferenceDto loadFile(File file) {
    try {
      return fromJson(file.readAsStringSync());
    } catch (e) {
      return ReferenceDto(assets: [], slides: [], config: Config.empty());
    }
  }

  static ReferenceDto loadYaml(File file) {
    try {
      final yamlString = yaml.loadYaml(file.readAsStringSync());
      return ReferenceDto.fromJson(jsonEncode(yamlString));
    } catch (e) {
      rethrow;
      return ReferenceDto(assets: [], slides: [], config: Config.empty());
    }
  }

  const ReferenceDto.empty()
      : config = const Config.empty(),
        slides = const [],
        assets = const [];

  static const fromMap = ReferenceDtoMapper.fromMap;
  static const fromJson = ReferenceDtoMapper.fromJson;
}

class ContentOptionsSectionMapper extends SimpleMapper<ContentOptions> {
  const ContentOptionsSectionMapper();

  @override
  ContentOptions decode(dynamic value) {
    return ContentOptionsMapper.fromMap(value);
  }

  @override
  dynamic encode(ContentOptions self) {
    final map = self.toMap();
    if (map.isEmpty) {
      return null;
    }
    return map;
  }
}
