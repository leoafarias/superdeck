import 'package:superdeck_core/superdeck_core.dart';

List<SectionBlockDto> parseSections(String markdown) {
  final lines = markdown.split('\n');
  var sections = <SectionBlockDto>[];

  SectionBlockDto? currentSection;

  for (var line in lines) {
    final trimmedLine = line.trim();
    if (trimmedLine.startsWith('{@')) {
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

  // Remove subsections if they are empty
  return sections
      .map((section) => section.copyWith(
          subSections: section.subSections
              .where((subSection) => !subSection.isEmpty)
              .toList()))
      .toList();
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
    case BlockType.gist:
      return GistBlockDto.parse(payload);
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
    var rawOptions = match.group(2)!.trim();
    final blockType = _getBlockType(blockTypeStr!);

    final options = <String, String?>{};
    if (rawOptions.startsWith(':')) {
      // final firstItem = rawOptions.substring(1).split(' ').first;

      // rawOptions = rawOptions.substring(1 + firstItem.length).trim();
      throw Exception(
          'Invalid option format, must be key-value pairs\n $rawOptions');
    }

    if (rawOptions.isNotEmpty) {
      final optionsSplit = rawOptions
          .split(': ')
          .expand((s) => s.split(' '))
          .where((s) => s.isNotEmpty)
          .toList();

      // If value is not event throw an error
      if (optionsSplit.length % 2 != 0) {
        throw Exception(
            'Invalid option format, must be key-value pairs\n $rawOptions');
      }

      // Now combine the options back together, every 2 pairs as key-value
      for (var i = 0; i < optionsSplit.length; i += 2) {
        final key = optionsSplit[i];
        final value = optionsSplit[i + 1];
        if (value.isEmpty) {
          options[key] = null;
        } else if (key.isEmpty) {
          options[value] = true.toString();
        } else {
          options[key] = value.trim();
        }
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
