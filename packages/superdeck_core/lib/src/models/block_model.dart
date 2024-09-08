part of 'models.dart';

@MappableEnum()
enum BlockType {
  section,
  column,
  image,
  widget,
  gist,
}

abstract class BlockDto<T extends BlockOptions> {
  const BlockDto();
}

@MappableClass(
  includeCustomMappers: [OptionsMapper()],
  // hook: BlockMappingHook(),
)
class SectionBlockDto extends BlockDto with SectionBlockDtoMappable {
  final BlockOptions? options;
  final List<SubSectionBlockDto> subSections;

  SectionBlockDto({
    this.options,
    this.subSections = const [],
  });

  static SectionBlockDto parse(Map<String, dynamic> map) {
    return SectionBlockDtoMapper.fromMap(map);
  }

  static final schema = SchemaShape({
    'options': BlockOptions.schema,
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
sealed class SubSectionBlockDto<T extends BlockOptions> extends BlockDto
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
      'gist': GistBlockDto.schema,
    },
  );
}

@MappableClass(discriminatorValue: 'column')
class ColumnBlockDto extends SubSectionBlockDto<BlockOptions>
    with ColumnBlockDtoMappable {
  @override
  final BlockOptions? options;

  ColumnBlockDto({
    super.content,
    this.options,
  }) : super(type: BlockType.column);

  static parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return ColumnBlockDtoMapper.fromMap(map);
  }

  static final schema = SubSectionBlockDto.baseSchema.extend(
    {'options': BlockOptions.schema},
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

  static WidgetBlockDto parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return WidgetBlockDtoMapper.fromMap(map);
  }

  static final schema = SubSectionBlockDto.baseSchema.extend(
    {'options': WidgetOptions.schema.required()},
  );
}

@MappableClass(discriminatorValue: 'gist')
class GistBlockDto extends SubSectionBlockDto<DartPadOptions>
    with GistBlockDtoMappable {
  @override
  final DartPadOptions options;
  GistBlockDto({
    required this.options,
    super.content,
  }) : super(type: BlockType.gist);

  static GistBlockDto parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return GistBlockDtoMapper.fromMap(map);
  }

  static final schema = SubSectionBlockDto.baseSchema.extend(
    {'options': DartPadOptions.schema.required()},
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

class OptionsMapper extends SimpleMapper<BlockOptions> {
  const OptionsMapper();

  @override
  BlockOptions decode(dynamic value) {
    return BlockOptionsMapper.fromMap(value);
  }

  @override
  dynamic encode(BlockOptions self) {
    final map = self.toMap();
    if (map.isEmpty) {
      return null;
    }
    return map;
  }
}
