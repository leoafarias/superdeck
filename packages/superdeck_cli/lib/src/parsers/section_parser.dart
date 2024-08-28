import 'package:superdeck_core/superdeck_core.dart';

List<SectionBlockDto> parseSections(String markdown) {
  final lines = markdown.split('\n');
  var sections = <SectionBlockDto>[];

  SectionBlockDto? currentSection;

  for (var line in lines) {
    line = line.trim();
    if (line.startsWith('{@')) {
      final tagData = extractTagsFromLine(line);
      final blocks = tagData.map(_decodeBlock).toList();

      for (final block in blocks) {
        if (block is SectionBlockDto) {
          // If a new section starts, add the previous one to the list
          if (currentSection != null) {
            sections.add(currentSection);
          }
          // Start a new section
          currentSection = block;
        } else if (block is SubSectionBlockDto) {
          // Add a new column to the current section
          currentSection ??= SectionBlockDto();
          currentSection = currentSection.appendSubsection(block);
        }
      }
    } else if (currentSection != null) {
      currentSection = currentSection.appendLine(line);
    } else {
      currentSection = SectionBlockDto(
        subSections: [ColumnBlockDto(content: line)],
      );
    }
  }

  // Add the last section to the list
  if (currentSection != null) {
    sections.add(currentSection);
  }

  return sections;
}

BlockDto? _decodeBlock(SyntaxTagData tagData) {
  final (:blockType, :options) = tagData;

  final payload = {
    'options': options,
  };

  switch (blockType) {
    case BlockType.column:
      return ColumnBlockDto.parse(payload);
    case BlockType.image:
      return ImageBlockDto.parse(payload);
    case BlockType.widget:
      return WidgetBlockDto.parse(payload);
    case BlockType.section:
      return SectionBlockDto.parse(payload);
  }
}

typedef SyntaxTagData = ({
  BlockType blockType,
  Map<String, dynamic> options,
});

List<SyntaxTagData> extractTagsFromLine(String line) {
  final tagRegex = RegExp(r'{@(\w+)\s*([^}]*)}');
  final matches = tagRegex.allMatches(line);

  if (matches.isEmpty) {
    throw Exception('Invalid tag format');
  }

  return matches.map((match) {
    final blockTypeStr = match.group(1);
    final rawOptions = match.group(2)!.trim();
    final blockType = _getBlockType(blockTypeStr!);

    final options = <String, String>{};
    if (rawOptions.isNotEmpty) {
      final optionRegex = RegExp(r'(\w+)\s*:\s*([\w_]+)');
      final optionMatches = optionRegex.allMatches(rawOptions);
      for (final optionMatch in optionMatches) {
        final key = optionMatch.group(1);
        final value = optionMatch.group(2);
        if (key == null || value == null || value.isEmpty) {
          throw Exception('Invalid option format');
        }
        options[key] = value.trim();
      }
    }

    return (blockType: blockType, options: options);
  }).toList();
}

BlockType _getBlockType(String blockTypeStr) {
  return BlockType.values.firstWhere(
    (e) => e.name == blockTypeStr,
    orElse: () => throw Exception('Invalid block type'),
  );
}
