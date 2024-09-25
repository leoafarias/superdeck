part of 'models.dart';

@MappableClass()
class Slide with SlideMappable {
  final String key;
  final SlideOptions? options;
  final String markdown;
  final List<SectionBlock> sections;
  final List<SlideNote> notes;

  const Slide({
    required this.key,
    this.options,
    required this.markdown,
    this.sections = const [],
    this.notes = const [],
  });

  File get thumbnailFile => File(
        p.join(kGeneratedAssetsDir.path, 'thumbnail_$key.png'),
      );

  static Slide fromMap(Map<String, dynamic> map) {
    Slide.schema.validateOrThrow(map);
    return SlideMapper.fromMap(map);
  }

  static const fromJson = SlideMapper.fromJson;

  static final schema = SchemaShape(
    {
      "key": Schema.string.required(),
      "markdown": Schema.string.required(),
      "title": Schema.string.optional(),
      'options': SlideOptions.schema.optional(),
      'sections': SchemaList(SectionBlock.schema).optional(),
      'notes': SchemaList(Schema.string).optional(),
    },
    additionalProperties: false,
  );
}

@MappableClass()
class SlideNote with SlideNoteMappable {
  final String content;

  SlideNote({
    required this.content,
  });

  static SlideNote fromMap(Map<String, dynamic> map) {
    SlideNote.schema.validateOrThrow(map);
    return SlideNoteMapper.fromMap(map);
  }

  static const fromJson = SlideNoteMapper.fromJson;

  static final schema = SchemaShape(
    {
      "content": Schema.string.required(),
    },
    additionalProperties: false,
  );
}
