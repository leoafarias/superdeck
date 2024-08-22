import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'slide_model.mapper.dart';

@MappableClass()
class Slide with SlideMappable {
  final int index;
  final String content;
  final String key;
  final List<SectionPart> sections;
  final SlideOptions? options;

  Slide({
    required this.index,
    required this.content,
    required this.key,
    this.options,
    this.sections = const [],
  });

  static Slide parse(Map<String, dynamic> map) {
    return Slide.fromMap(map);
  }

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

@MappableRecord()
typedef SectionData = ({String content, ContentOptions? options});
