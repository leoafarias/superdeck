part of 'models.dart';

@MappableEnum()
enum BlockType {
  section,
  column,
  image,
  widget,
}

abstract class BlockDto<T extends ContentOptions> {
  const BlockDto();
}

@MappableClass(
  includeCustomMappers: [OptionsMapper()],
  // hook: BlockMappingHook(),
)
class SectionBlockDto extends BlockDto with SectionBlockDtoMappable {
  final ContentOptions? options;
  final List<SubSectionBlockDto> subSections;

  SectionBlockDto({
    this.options,
    this.subSections = const [],
  });

  static SectionBlockDto parse(Map<String, dynamic> map) {
    return SectionBlockDtoMapper.fromMap(map);
  }

  static final schema = SchemaShape({
    'options': ContentOptions.schema,
    'sub_sections': Schema.list(SubSectionBlockDto.schema),
  });

  SectionBlockDto appendLine(String content) {
    final lastPart = subSections.lastOrNull;
    final subSectionsCopy = [...subSections];

    if (lastPart is ColumnBlockDto) {
      subSectionsCopy.last = lastPart.copyWith(
        content: '${lastPart.content}\n$content',
      );
    } else {
      subSectionsCopy.add(ColumnBlockDto(
        content: content,
      ));
    }

    return copyWith(subSections: subSectionsCopy);
  }

  SectionBlockDto appendSubsection(SubSectionBlockDto part) {
    return copyWith(subSections: [...subSections, part]);
  }
}

@MappableClass(
  discriminatorKey: 'type',
  includeCustomMappers: [OptionsMapper()],
  // hook: BlockMappingHook(),
)
sealed class SubSectionBlockDto<T extends ContentOptions> extends BlockDto
    with SubSectionBlockDtoMappable {
  final String content;
  final BlockType type;

  T? get options;

  SubSectionBlockDto({
    this.content = '',
    required this.type,
  });

  bool get isEmpty => this is ColumnBlockDto && content.isEmpty;

  static final baseSchema = SchemaShape({
    'content': Schema.string,
    'type': Schema.string.isEnum(BlockType.values)
  });

  static final schema = DiscriminatorSchema(
    baseSchema: baseSchema,
    discriminatorKey: 'type',
    schemas: {
      'column': ColumnBlockDto.schema,
      'widget': WidgetBlockDto.schema,
      'image': ImageBlockDto.schema,
    },
  );
}

@MappableClass(discriminatorValue: 'column')
class ColumnBlockDto extends SubSectionBlockDto<ContentOptions>
    with ColumnBlockDtoMappable {
  @override
  final ContentOptions? options;

  ColumnBlockDto({
    super.content,
    this.options,
  }) : super(type: BlockType.column);

  static parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return ColumnBlockDtoMapper.fromMap(map);
  }

  static final schema = SubSectionBlockDto.baseSchema.extend(
    {'options': ContentOptions.schema},
  );
}

@MappableClass(discriminatorValue: 'widget')
class WidgetBlockDto extends SubSectionBlockDto<WidgetOptions>
    with WidgetBlockDtoMappable {
  @override
  final WidgetOptions options;

  WidgetBlockDto({
    required this.options,
    super.content,
  }) : super(type: BlockType.widget);

  static parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return WidgetBlockDtoMapper.fromMap(map);
  }

  static final schema = SubSectionBlockDto.baseSchema.extend(
    {'options': WidgetOptions.schema.required()},
  );
}

@MappableClass(discriminatorValue: 'image')
class ImageBlockDto extends SubSectionBlockDto<ImageOptions>
    with ImageBlockDtoMappable {
  @override
  final ImageOptions options;

  ImageBlockDto({
    required this.options,
    super.content,
  }) : super(type: BlockType.image);

  static parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return ImageBlockDtoMapper.fromMap(map);
  }

  static final schema = SubSectionBlockDto.baseSchema.extend(
    {'options': ImageOptions.schema.required()},
  );
}

class OptionsMapper extends SimpleMapper<ContentOptions> {
  const OptionsMapper();

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
