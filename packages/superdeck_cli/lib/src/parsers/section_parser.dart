import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:superdeck_core/superdeck_core.dart';

List<SectionBlockDto> parseSections(String markdown) {
  final lines = LineSplitter().convert(markdown);
  var sections = <SectionBlockDto>[];

  SectionBlockDto? currentSection;
  var index = 0;

  while (index < lines.length) {
    var line = lines[index];
    final trimmedLine = line.trim();

    if (trimmedLine.startsWith('{@')) {
      // Start of a tag, read until we find the closing '}'
      var tagContent = line;
      while (!tagContent.trim().endsWith('}')) {
        index++;
        if (index >= lines.length) {
          throw Exception('Unclosed tag in markdown');
        }
        tagContent += '\n${lines[index]}';
      }

      // Process the tagContent
      final tagData = extractTagsFromLine(tagContent);
      final blocks = tagData.map(_decodeBlock).toList();

      for (final block in blocks) {
        if (block is SectionBlockDto) {
          // Add the previous section to the list
          if (currentSection != null) {
            sections.add(currentSection);
          }
          // Start a new section
          currentSection = block;
        } else if (block is SubSectionBlockDto) {
          // Add a new subsection to the current section
          currentSection ??= SectionBlockDto();
          currentSection = currentSection.appendSubsection(block);
        }
      }
    } else {
      // Regular content line
      if (currentSection != null) {
        currentSection = currentSection.appendLine(line);
      } else {
        currentSection = SectionBlockDto(
          subSections: [ColumnBlockDto(content: line)],
        );
      }
    }
    index++;
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

  return switch (blockType) {
    BlockType.column => ColumnBlockDto.parse(payload),
    BlockType.image => ImageBlockDto.parse(payload),
    BlockType.widget => WidgetBlockDto.parse(payload),
    BlockType.section => SectionBlockDto.parse(payload),
    BlockType.gist => GistBlockDto.parse(payload),
  };
}

typedef SyntaxTagData = ({
  BlockType blockType,
  Map<String, dynamic> options,
});

List<SyntaxTagData> extractTagsFromLine(String tagContent) {
  final tagRegex = RegExp(r'{@(\w+)(.*?)}', dotAll: true);
  final matches = tagRegex.allMatches(tagContent);

  if (matches.isEmpty) {
    throw Exception('Invalid tag format');
  }

  return matches.map((match) {
    final blockTypeStr = match.group(1);
    var rawOptions = match.group(2) ?? '';
    var blockType = _getBlockType(blockTypeStr!);

    var options = convertYamlToMap(rawOptions);

    // If there is no block treat it as a widget
    if (blockType == null) {
      blockType = BlockType.widget;
      options = {...options, 'name': blockTypeStr};
    }

    return (blockType: blockType, options: options);
  }).toList();
}

BlockType? _getBlockType(String blockTypeStr) {
  return BlockType.values.firstWhereOrNull(
    (e) => e.name == blockTypeStr,
  );
}
