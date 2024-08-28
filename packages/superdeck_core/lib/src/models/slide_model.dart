part of 'models.dart';

@MappableClass()
class Slide with SlideMappable {
  final String key;
  final SlideOptions? options;
  final String markdown;
  final List<SectionBlockDto> sections;

  Slide({
    required this.key,
    this.options,
    required this.markdown,
    this.sections = const [],
  });

  File get thumbnailFile => File(p.join(kAssetsDir.path, 'thumbnail_$key.png'));

  static Slide fromMap(Map<String, dynamic> map) {
    Slide.schema.validateOrThrow(map);
    return SlideMapper.fromMap(map);
  }

  static const fromJson = SlideMapper.fromJson;

  static final schema = SchemaShape(
    {
      "key": Schema.string.required(),
      "markdown": Schema.string.required(),
      "title": Schema.string,
      'options': SlideOptions.schema.optional(),
    },
    additionalProperties: false,
  );
}
