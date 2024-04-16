import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';

import '../schema/schema.dart';
import '../superdeck.dart';
import 'options_model.dart';
import 'syntax_tag.dart';

part 'slide_model.mapper.dart';

@MappableClass(discriminatorKey: 'layout')
abstract class Slide extends Config with SlideMappable {
  final String? title;
  final String layout;
  final String data;
  final String? raw;

  @MappableField(key: 'content')
  final ContentOptions? contentOptions;

  Slide({
    required this.layout,
    required this.data,
    required this.raw,
    required this.title,
    required this.contentOptions,
    required super.background,
    required super.style,
    required super.transition,
  });

  SlideVariant get styleVariant {
    return style == null ? SlideVariant.none : SlideVariant(style!);
  }

  static const fromMap = SlideMapper.fromMap;

  static const fromJson = SlideMapper.fromJson;

  static final schema = Config.schema.merge(
    {
      "layout": Schema.string.required(),
      "data": Schema.string.required(),
      "content": ContentOptions.schema.optional(),
      "title": Schema.string.optional(),
      "raw": Schema.string.optional(),
    },
  );
}

@MappableClass(discriminatorValue: MappableClass.useAsDefault)
class SimpleSlide extends Slide with SimpleSlideMappable {
  SimpleSlide({
    super.title,
    super.background,
    required super.contentOptions,
    super.style,
    super.transition,
    super.raw,
    required super.data,
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
    required super.data,
    required super.layout,
    required super.raw,
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
    required super.data,
    required super.options,
    super.raw,
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
    required super.data,
    super.raw,
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
typedef SectionData = ({String content, ContentOptions options});

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
    required super.data,
    this.sections = const {},
    required super.layout,
    required super.raw,
  });

  Map<String, String>? _sectionCache;

  Map<String, String> get _contentSections {
    if (_sectionCache != null) return _sectionCache!;

    return _sectionCache = parseContentSections(data);
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
    required super.data,
    super.sections,
    super.raw,
  }) : super(layout: LayoutType.twoColumn);

  SectionData get left => getSection(Section.left, Section.first);

  SectionData get right => getSection(Section.right);

  static const fromMap = TwoColumnSlideMapper.fromMap;

  static const fromJson = TwoColumnSlideMapper.fromJson;

  static final schema = Slide.schema.merge({
    'sections': SchemaMap.optional({
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
    required super.data,
    super.sections,
    super.raw,
  }) : super(layout: LayoutType.twoColumnHeader);

  SectionData get header => getSection(Section.header, Section.first);

  SectionData get left => getSection(Section.left);

  SectionData get right => getSection(Section.right);

  static const fromMap = TwoColumnHeaderSlideMapper.fromMap;

  static const fromJson = TwoColumnHeaderSlideMapper.fromJson;

  static final schema = TwoColumnSlide.schema.merge(
    {
      'sections': SchemaMap.optional({
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
    required super.data,
    super.raw,
  }) : super(layout: LayoutType.invalid);

  InvalidSlide.message(String message)
      : super(
          layout: LayoutType.invalid,
          title: null,
          data: message,
          background: null,
          contentOptions: null,
          style: null,
          raw: null,
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
