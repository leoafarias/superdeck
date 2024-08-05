import 'package:dart_mappable/dart_mappable.dart';

import '../helpers/section_tag.dart';
import '../schema/schema_model.dart';
import '../schema/schema_validation.dart';
import '../superdeck.dart';
import 'config_model.dart';

part 'slide_model.mapper.dart';

@MappableClass(discriminatorKey: 'layout')
abstract class Slide extends BaseConfig with SlideMappable {
  final String? title;
  final String layout;
  final String content;

  final String key;

  final ContentOptions? contentOptions;

  Slide({
    required this.layout,
    required this.content,
    required this.key,
    required this.title,
    required this.contentOptions,
    required super.background,
    required super.style,
    required super.transition,
  });

  static Slide parse(Map<String, dynamic> map) {
    final layout = map['layout'] ??= LayoutType.simple;

    try {
      switch (layout) {
        case LayoutType.simple:
        case null:
          SimpleSlide.schema.validateOrThrow(map);
          return SimpleSlide.fromMap(map);
        case LayoutType.image:
          ImageSlide.schema.validateOrThrow(map);
          return ImageSlide.fromMap(map);
        case LayoutType.widget:
          WidgetSlide.schema.validateOrThrow(map);
          return WidgetSlide.fromMap(map);
        case LayoutType.twoColumn:
          TwoColumnSlide.schema.validateOrThrow(map);
          return TwoColumnSlide.fromMap(map);
        case LayoutType.twoColumnHeader:
          TwoColumnHeaderSlide.schema.validateOrThrow(map);
          return TwoColumnHeaderSlide.fromMap(map);
        default:
          return InvalidSlide.invalidTemplate(layout);
      }
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

  static final schema = BaseConfig.schema.merge(
    {
      "layout": Schema.string.required(),
      "data": Schema.string.required(),
      "content": ContentOptions.schema,
      "title": Schema.string,
      "raw": Schema.string,
    },
  );
}

@MappableClass(discriminatorValue: MappableClass.useAsDefault)
class SimpleSlide extends Slide with SimpleSlideMappable {
  SimpleSlide({
    super.title,
    super.background,
    super.contentOptions,
    super.style,
    super.transition,
    required super.key,
    required super.content,
  }) : super(layout: LayoutType.simple);

  static const fromMap = SimpleSlideMapper.fromMap;

  static const fromJson = SimpleSlideMapper.fromJson;

  static final schema = Slide.schema;
}

@MappableClass()
abstract class SplitSlide<T extends SplitOptions> extends Slide
    with SplitSlideMappable<T> {
  final T options;

  SplitSlide({
    required this.options,
    super.title,
    super.background,
    required super.contentOptions,
    super.style,
    super.transition,
    required super.content,
    required super.layout,
    required super.key,
  });
}

@MappableClass(discriminatorValue: LayoutType.image)
class ImageSlide extends SplitSlide<ImageOptions> with ImageSlideMappable {
  ImageSlide({
    super.title,
    super.style,
    super.background,
    required super.contentOptions,
    super.transition,
    required super.content,
    required super.options,
    required super.key,
  }) : super(layout: LayoutType.image);

  static const fromMap = ImageSlideMapper.fromMap;

  static const fromJson = ImageSlideMapper.fromJson;

  static final schema = Slide.schema.merge(
    {
      'options': ImageOptions.schema.required(),
    },
  );
}

@MappableClass(discriminatorValue: LayoutType.widget)
class WidgetSlide extends SplitSlide<WidgetOptions> with WidgetSlideMappable {
  WidgetSlide({
    super.title,
    required super.options,
    super.style,
    super.background,
    required super.contentOptions,
    super.transition,
    required super.content,
    required super.key,
  }) : super(layout: LayoutType.widget);

  static const fromMap = WidgetSlideMapper.fromMap;

  static const fromJson = WidgetSlideMapper.fromJson;

  static final schema = Slide.schema.merge(
    {
      'options': WidgetOptions.schema.required(),
    },
  );
}

@MappableRecord()
typedef SectionData = ({String content, ContentOptions? options});

@MappableClass()
abstract class SectionsSlide extends Slide with SectionsSlideMappable {
  @MappableField()
  final Map<String, ContentOptions?> sections;

  SectionsSlide({
    super.title,
    super.background,
    required super.contentOptions,
    super.style,
    super.transition,
    required super.content,
    this.sections = const {},
    required super.layout,
    required super.key,
  });

  Map<String, String>? _sectionCache;

  Map<String, String> get _contentSections {
    if (_sectionCache != null) return _sectionCache!;

    return _sectionCache = parseContentSections(content);
  }

  SectionData getSection(String section, [String? sectionFallback]) {
    var content = _contentSections[section];

    content ??= _contentSections[sectionFallback];

    final payload = (
      content: content ?? '',
      options: sections[section] ?? const ContentOptions(),
    );

    return payload;
  }
}

@MappableClass(discriminatorValue: LayoutType.twoColumn)
class TwoColumnSlide extends SectionsSlide with TwoColumnSlideMappable {
  TwoColumnSlide({
    super.title,
    super.background,
    required super.contentOptions,
    super.style,
    super.transition,
    required super.content,
    super.sections,
    required super.key,
  }) : super(layout: LayoutType.twoColumn);

  SectionData get left => getSection(SectionTag.left, SectionTag.first);

  SectionData get right => getSection(SectionTag.right);

  static const fromMap = TwoColumnSlideMapper.fromMap;

  static const fromJson = TwoColumnSlideMapper.fromJson;

  static final schema = Slide.schema.merge({
    'sections': SchemaMap({
      'left': ContentOptions.schema.optional(),
      'right': ContentOptions.schema.optional(),
    }),
  });
}

@MappableClass(discriminatorValue: LayoutType.twoColumnHeader)
class TwoColumnHeaderSlide extends SectionsSlide
    with TwoColumnHeaderSlideMappable {
  TwoColumnHeaderSlide({
    super.title,
    super.background,
    required super.contentOptions,
    super.style,
    super.transition,
    required super.content,
    super.sections,
    required super.key,
  }) : super(layout: LayoutType.twoColumnHeader);

  SectionData get header => getSection(SectionTag.header, SectionTag.first);

  SectionData get left => getSection(SectionTag.left);

  SectionData get right => getSection(SectionTag.right);

  static const fromMap = TwoColumnHeaderSlideMapper.fromMap;

  static const fromJson = TwoColumnHeaderSlideMapper.fromJson;

  static final schema = TwoColumnSlide.schema.merge(
    {
      'sections': SchemaMap({
        'header': ContentOptions.schema.optional(),
      }),
    },
  );
}

@MappableClass(discriminatorValue: LayoutType.invalid)
class InvalidSlide extends Slide with InvalidSlideMappable {
  InvalidSlide({
    required super.contentOptions,
    super.title,
    super.background,
    super.style,
    super.transition,
    required super.content,
    required super.key,
  }) : super(layout: LayoutType.invalid);

  InvalidSlide.message(String message)
      : super(
          layout: LayoutType.invalid,
          title: null,
          content: message,
          background: null,
          contentOptions: null,
          style: null,
          key: 'invalid_key',
          transition: null,
        );

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
