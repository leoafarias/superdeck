import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../schema/schema_model.dart';
import '../schema/schema_validation.dart';

part 'slide_model.mapper.dart';

@MappableClass()
class Slide with SlideMappable {
  final String content;
  final String key;
  final List<SectionPart> sections;
  final SlideOptions? options;

  Slide({
    required this.content,
    required this.key,
    this.options,
    this.sections = const [],
  });

  static Slide parse(Map<String, dynamic> map) {
    try {
      Slide.schema.validateOrThrow(map);
      return Slide.fromMap(map);
    } on SchemaValidationException catch (e) {
      return InvalidSlide.schemaError(e.result);
    } on Exception catch (e) {
      return InvalidSlide.exception(e);
    } catch (e) {
      return InvalidSlide.message('# Unknown Error \n $e');
    }
  }

  static const fromMap = SlideMapper.fromMap;

  static const fromJson = SlideMapper.fromJson;

  static final schema = SchemaShape(
    {
      "content": Schema.string.required(),
      "title": Schema.string,
      'options': SlideOptions.schema.optional(),
    },
    additionalProperties: false,
  );
}

@MappableRecord()
typedef SectionData = ({String content, ContentOptions? options});

@MappableClass()
class InvalidSlide extends Slide with InvalidSlideMappable {
  InvalidSlide(String message)
      : super(
          content: message,
          key: message,
        );

  InvalidSlide.message(String message) : this(message);

  InvalidSlide.invalidTemplate(String template)
      : this.message('# Invalid template \n ## $template');

  factory InvalidSlide.exception(Exception exception) {
    return InvalidSlide.message('# Exception \n ## ${exception.toString()}');
  }

  factory InvalidSlide.schemaError(
    SchemaValidationResult result, [
    String? content,
  ]) {
    final path = result.key;
    final errors = result.errors;
    final errorMessage = errors.map((error) => error.message).join('\n\n');

    //  dont forget the tab or spacing since they are nested
    String keysNested = '';

    if (path.isNotEmpty) {
      keysNested = path.join('.');
    }

    content ??= '# Schema Error';

    final message = '''
$content  
## $keysNested
$errorMessage
''';

    return InvalidSlide.message(message);
  }

  factory InvalidSlide.projectSchemaError(SchemaValidationResult error) {
    return InvalidSlide.schemaError(error, '# Project configuration error');
  }

  static const fromMap = InvalidSlideMapper.fromMap;
  static const fromJson = InvalidSlideMapper.fromJson;
}
