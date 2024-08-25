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

  SectionBlockDto addLine(String content) {
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

  SectionBlockDto addSubSection(SubSectionBlockDto part) {
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

  T? get options;

  SubSectionBlockDto({
    this.content = '',
  });
}

@MappableClass(discriminatorValue: 'column')
class ColumnBlockDto extends SubSectionBlockDto<ContentOptions>
    with ColumnBlockDtoMappable {
  @override
  final ContentOptions? options;

  ColumnBlockDto({
    super.content,
    this.options,
  });
}

@MappableClass(discriminatorValue: 'widget')
class WidgetBlockDto extends SubSectionBlockDto<WidgetOptions>
    with WidgetBlockDtoMappable {
  @override
  final WidgetOptions? options;

  WidgetBlockDto({
    this.options,
    super.content,
  });
}

@MappableClass(discriminatorValue: 'image')
class ImageBlockDto extends SubSectionBlockDto<ImageOptions>
    with ImageBlockDtoMappable {
  @override
  final ImageOptions? options;

  ImageBlockDto({
    this.options,
    super.content,
  });
}

// class BlockMappingHook extends MappingHook {
//   const BlockMappingHook();

//   @override
//   Object? afterEncode(Object? value) {
//     if (value is Map<dynamic, dynamic>) {
//       if (value.isEmpty) {
//         return null;
//       } else {
//         final valueCopy = {...value};
//         for (var key in value.keys) {
//           if (value[key] == null) {
//             valueCopy.remove(key);
//           }
//         }
//         return valueCopy;
//       }
//     }

//     return value;
//   }
// }

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
