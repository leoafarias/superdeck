import 'package:collection/collection.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/parsers/section_parser/section_regex.dart';
import 'package:superdeck_core/superdeck_core.dart';

BlockDto? _decodeBlock(String line) {
  if (!isValidTag(line)) return null;

  final (:blockType, :options) = extractTagData(line);

  final hasOptions = options.isNotEmpty;

  switch (blockType) {
    case BlockType.column:
      ContentOptions.schema.validateOrThrow(options);
      return ColumnBlockDto(
        options: hasOptions ? ContentOptionsMapper.fromMap(options) : null,
      );
    case BlockType.image:
      ImageOptions.schema.validateOrThrow(options);
      return ImageBlockDto(
        options: hasOptions ? ImageOptionsMapper.fromMap(options) : null,
      );
    case BlockType.widget:
      WidgetOptions.schema.validateOrThrow(options);
      return WidgetBlockDto(
        options: hasOptions ? WidgetOptionsMapper.fromMap(options) : null,
      );
    case BlockType.section:
      ContentOptions.schema.validateOrThrow(options);
      return SectionBlockDto(
        options: hasOptions ? ContentOptionsMapper.fromMap(options) : null,
      );
  }
}

List<SectionBlockDto> parseSections(String slideMarkdown) {
  final lines = slideMarkdown.split('\n');

  final rootSection = SectionBlockDto();

  final layoutParts = <SectionBlockDto>{rootSection};

  // Start with the header
  SectionBlockDto currentSection = rootSection;

  int lineIndex = 0;

  for (final line in lines) {
    lineIndex++;
    final trimmedLine = line.trim();
    // Skip empty lines
    if (trimmedLine.isEmpty) {
      continue;
    }

    if (!isValidTag(line)) {
      currentSection = currentSection.addLine(line);
      continue;
    }

    BlockDto? part;
    try {
      part = _decodeBlock(line);
    } on SchemaValidationException catch (e) {
      final message = e.result.errors.map((e) => e.message).join('\n');
      // get all lines before this one
      final previousLines = lines.sublist(0, lineIndex);
      final getOffset = previousLines.join('\n').length;
      throw SDFormatException(message, slideMarkdown, getOffset);
    } on FormatException catch (e) {
      final getOffset = slideMarkdown.indexOf(line);
      throw SDFormatException(e.message, slideMarkdown, getOffset);
    }

    if (part == null) {
      continue;
    }

    if (part is SectionBlockDto) {
      // Save current section before setting as current
      layoutParts.add(currentSection);
      currentSection = part;
    } else if (part is SubSectionBlockDto) {
      currentSection = currentSection.addSubSection(part);
    }
  }

  layoutParts.add(currentSection);

  // Return the parsed sections
  //  remove all sections that have empty parts
  return layoutParts.where((part) {
    return part.subSections.isNotEmpty;
  }).toList();
}

Map<String, dynamic> _getOptionsMapFromLine(List<String> params) {
  final friendlyParams = params.join(' ');

  if (params.length % 2 != 0) {
    throw FormatException('Invalid options format: $friendlyParams');
  }

  final options = <String, dynamic>{};

  for (var i = 0; i < params.length; i++) {
    // if value is 0 or even, it's a key
    final isKey = i % 2 == 0;

    if (isKey) {
      continue;
    } else {
      final value = params[i];
      final key = params[i - 1].replaceAll(':', '');
      if (value.isEmpty || key.isEmpty) {
        throw FormatException('Empty value found in options: $friendlyParams');
      }
      options[key] = value;
    }
  }

  return options;
}

typedef SyntaxTagData = ({
  BlockType blockType,
  Map<String, dynamic> options,
});

/// Parses a line containing a tag and its options.
SyntaxTagData extractTagData(String line) {
  // Remove any leading or trailing whitespace from the input line
  line = line.trim();

  // Check if the line matches the expected syntax
  if (!isValidTag(line)) {
    // If not, throw an exception with a descriptive error message
    throw FormatException('Invalid tag syntax: $line');
  }

  // Use a regular expression to match the contents of the tag
  final result = getTagContents(line);

  // Split the result into parts using the defined separator
  final parts = result.split(' ').where((e) => e.isNotEmpty).toList();

  final [tag, ...params] = parts;

  final blockType = BlockType.values.firstWhereOrNull(
    (type) => type.name == tag,
  );

  if (blockType == null) {
    throw FormatException('Invalid tag: $tag');
  }

  // Join the remaining parts (if any) back into a string for options parsing
  // If there's only one part (just the tag), use an empty string

  // Parse the options string into a Map using a helper function
  final options = _getOptionsMapFromLine(params);

  // If the extracted tag is empty, throw an exception
  if (tag.isEmpty) {
    throw FormatException('Empty tag extracted: $line');
  }

  // Return a record containing the tag and options
  return (
    blockType: blockType,
    options: options,
  );
}
