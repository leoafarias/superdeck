part of 'models.dart';

@MappableClass()
class Slide with SlideMappable {
  final int index;
  final String key;
  final SlideOptions? options;
  final String content;
  final List<SectionBlockDto> sections;

  Slide({
    required this.index,
    required this.key,
    this.options,
    required this.content,
    this.sections = const [],
  });

  static Slide fromMap(Map<String, dynamic> map) {
    Slide.schema.validateOrThrow(map);
    return SlideMapper.fromMap(map);
  }

  static const fromJson = SlideMapper.fromJson;

  static final schema = SchemaShape(
    {
      "index": Schema.integer.required(),
      "key": Schema.string.required(),
      "content": Schema.string.required(),
      "title": Schema.string,
      'options': SlideOptions.schema.optional(),
    },
    additionalProperties: false,
  );
}
