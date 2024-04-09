import 'package:dart_mappable/dart_mappable.dart';

import '../helpers/schema/schema.dart';
import '../styles/style_util.dart';
import 'options_model.dart';
import 'syntax_tag.dart';

part 'slide_model.mapper.dart';

@MappableClass(discriminatorKey: 'layout')
abstract class Slide extends Config with SlideMappable {
  final String? title;
  final String layout;
  final String data;
  @MappableField(key: 'content')
  final ContentOptions? contentOptions;

  const Slide({
    required this.layout,
    required this.data,
    required this.title,
    required this.contentOptions,
    required super.background,
    required super.style,
    required super.transition,
  });

  static final Map<int, Map<String, String>> _sectionCache = {};

  Map<String, String> get sections {
    final sections = _sectionCache[data.hashCode];
    return sections ??
        (_sectionCache[data.hashCode] = parseContentSections(data));
  }

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
    },
  );
}

@MappableClass(discriminatorValue: MappableClass.useAsDefault)
class SimpleSlide extends Slide with SimpleSlideMappable {
  const SimpleSlide({
    super.title,
    super.background,
    required super.contentOptions,
    super.style,
    super.transition,
    required super.data,
  }) : super(layout: LayoutType.simple);

  static const fromMap = SimpleSlideMapper.fromMap;

  static const fromJson = SimpleSlideMapper.fromJson;

  static final schema = Slide.schema;
}

@MappableClass(discriminatorValue: LayoutType.image)
class ImageSlide extends Slide with ImageSlideMappable {
  final ImageOptions image;

  const ImageSlide({
    super.title,
    required this.image,
    super.style,
    super.background,
    required super.contentOptions,
    super.transition,
    required super.data,
  }) : super(layout: LayoutType.image);

  static const fromMap = ImageSlideMapper.fromMap;

  static const fromJson = ImageSlideMapper.fromJson;

  static final schema = Slide.schema.merge(
    {
      'image': ImageOptions.schema.required(),
    },
  );
}

@MappableClass(discriminatorValue: LayoutType.widget)
class WidgetSlide extends Slide with WidgetSlideMappable {
  final WidgetOptions widget;

  const WidgetSlide({
    super.title,
    required this.widget,
    super.style,
    super.background,
    required super.contentOptions,
    super.transition,
    required super.data,
  }) : super(layout: LayoutType.widget);

  static const fromMap = WidgetSlideMapper.fromMap;

  static const fromJson = WidgetSlideMapper.fromJson;

  static final schema = Slide.schema.merge(
    {
      'widget': WidgetOptions.schema.required(),
    },
  );
}

@MappableClass()
abstract class TwoSectionSlide extends Slide with TwoSectionSlideMappable {
  @MappableField(key: 'left_section')
  final ContentOptions? leftOptions;

  @MappableField(key: 'right_section')
  final ContentOptions? rightOptions;

  TwoSectionSlide({
    super.title,
    super.background,
    required super.contentOptions,
    super.style,
    super.transition,
    required super.data,
    this.leftOptions,
    this.rightOptions,
    required super.layout,
  });

  String get leftContent =>
      sections[SectionTag.left] ?? sections[SectionTag.first] ?? '';

  String get rightContent => sections[SectionTag.right] ?? '';

  static final schema = Slide.schema.merge(
    {
      'left_section': ContentOptions.schema.optional(),
      'right_section': ContentOptions.schema.optional(),
    },
  );
}

@MappableClass(discriminatorValue: LayoutType.twoColumn)
class TwoColumnSlide extends TwoSectionSlide with TwoColumnSlideMappable {
  TwoColumnSlide({
    super.title,
    super.background,
    required super.contentOptions,
    super.style,
    super.transition,
    required super.data,
    super.leftOptions,
    super.rightOptions,
  }) : super(layout: LayoutType.twoColumn);

  static const fromMap = TwoColumnSlideMapper.fromMap;

  static const fromJson = TwoColumnSlideMapper.fromJson;

  static final schema = TwoSectionSlide.schema;
}

@MappableClass(discriminatorValue: LayoutType.twoColumnHeader)
class TwoColumnHeaderSlide extends TwoSectionSlide
    with TwoColumnHeaderSlideMappable {
  @MappableField(key: 'header')
  final ContentOptions? headerOptions;

  TwoColumnHeaderSlide({
    super.title,
    super.background,
    required super.contentOptions,
    super.style,
    super.transition,
    required super.data,
    super.leftOptions,
    super.rightOptions,
    this.headerOptions,
  }) : super(layout: LayoutType.twoColumnHeader);

  String get headerContent => sections[SectionTag.first] ?? '';

  static const fromMap = TwoColumnHeaderSlideMapper.fromMap;

  static const fromJson = TwoColumnHeaderSlideMapper.fromJson;

  static final schema = TwoSectionSlide.schema.merge(
    {
      'header': ContentOptions.schema.optional(),
    },
  );
}

@MappableClass(discriminatorValue: LayoutType.invalid)
class InvalidSlide extends Slide with InvalidSlideMappable {
  const InvalidSlide({
    required super.contentOptions,
    super.title,
    super.background,
    super.style,
    super.transition,
    required super.data,
  }) : super(layout: LayoutType.invalid);

  InvalidSlide.message(String message)
      : super(
          layout: LayoutType.invalid,
          title: null,
          data: message,
          background: null,
          contentOptions: null,
          style: null,
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
    final errorMessage = errors.map((error) => error.message).join('\n');

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
