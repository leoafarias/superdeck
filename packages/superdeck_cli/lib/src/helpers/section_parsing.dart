import 'package:collection/collection.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_core/superdeck_core.dart';

const _tagMarker = '@';

const _startAsTag = '{' + _tagMarker;

final _regexMatchTagContents = RegExp('{$_tagMarker(.*?)}');

T? _findEnumValue<T extends Enum>(
  List<T> values,
  String value,
) {
  return values.firstWhereOrNull(
    (element) => element.name == value,
  );
}

PartDto? parseBlock(String line) {
  if (!_isSyntax(line)) {
    return null;
  }

  final (:tag, :options) = getTagContents(line);

  final sectionName = _findEnumValue(
    SectionType.values,
    tag,
  );

  if (sectionName != null) {
    ContentOptions.schema.validateOrThrow(options);
    return SectionDto.build(
      sectionName,
      options: ContentOptionsMapper.fromMap(options),
    );
  }

  final subSectionName = _findEnumValue(
    SubSectionType.values,
    tag,
  );

  if (subSectionName != null) {
    switch (subSectionName) {
      case SubSectionType.content:
        ContentOptions.schema.validateOrThrow(options);
        return ContentPart(
          content: '',
          options: ContentOptionsMapper.fromMap(options),
        );
      case SubSectionType.image:
        ImageOptions.schema.validateOrThrow(options);
        return ImagePart(
          content: '',
          options: ImageOptionsMapper.fromMap(options),
        );
      case SubSectionType.widget:
        WidgetOptions.schema.validateOrThrow(options);
        return WidgetPart(
          content: '',
          options: WidgetOptionsMapper.fromMap(options),
        );
    }
  }
  return null;
}

List<SectionDto> parseSections(String slideMarkdown) {
  final lines = slideMarkdown.split('\n');

  final rootSection = SectionDto.build(SectionType.root);

  final layoutParts = <SectionDto>{rootSection};

  // Start with the header
  SectionDto currentSection = rootSection;

  int lineIndex = 0;

  for (final line in lines) {
    lineIndex++;
    final trimmedLine = line.trim();
    // Skip empty lines
    if (trimmedLine.isEmpty) {
      continue;
    }

    if (trimmedLine.startsWith(_startAsTag) &&
        _regexMatchTagContents.firstMatch(trimmedLine) == null) {
      throw Exception(
        'Invalid syntax on line ${lineIndex}. Missing closing tag',
      );
    }

    if (!_isSyntax(trimmedLine)) {
      currentSection = currentSection.addLine(line);
      continue;
    }

    PartDto? part;
    try {
      part = parseBlock(line);
    } on SchemaValidationException catch (e) {
      final message = e.result.errors.map((e) => e.message).join('\n');
      // get all lines before this one
      final previousLines = lines.sublist(0, lineIndex);
      final getOffset = previousLines.join('\n').length;
      throw SDFormatException(message, slideMarkdown, getOffset);
    }

    if (part == null) {
      continue;
    }

    if (part is SectionDto) {
      if (part.type.index <= currentSection.type.index) {
        throw Exception(
          'Invalid location tag on line ${lineIndex}. ${part.type.name} cannot be before ${currentSection.type.name}',
        );
      }

      if (currentSection is RootLayoutPart) {
        if (currentSection.contentSections.isNotEmpty) {
          // throw error that says if to use any section wrapping all the content of the markdown
          throw Exception(
            'Invalid location tag on line ${lineIndex}. ${part.type.name} cannot be before ${currentSection.type.name}',
          );
        }
      }
      // Save current section before setting as current
      layoutParts.add(currentSection);
      currentSection = part;
    } else if (part is ContentSectionPart) {
      currentSection = currentSection.addSubSection(part);
    }
  }

  layoutParts.add(currentSection);

  // Return the parsed sections
  //  remove all sections that have empty parts
  return layoutParts.where((part) {
    return part.contentSections.isNotEmpty;
  }).toList();
}

bool _isSyntax(String line) {
  return _regexMatchTagContents.hasMatch(line.trim());
}

Map<String, dynamic> getOptionsMapFromLine(
  String contents,
) {
  if (contents.isEmpty) {
    return {};
  }
  try {
    final params = contents.split('|').map((e) {
      if (e.isEmpty) {
        return '';
      }
      final isKeyValue = e.contains(':');
      final parts = e.split(':').map((e) => e.trim()).toList();

      Object? tryBooleanValue(String value) {
        final lowercase = value.toLowerCase();
        if (lowercase == 'true') {
          return true;
        } else if (lowercase == 'false') {
          return false;
        }
        return value;
      }

      final key = parts.first;
      // Treat as a boolean if no value is provided
      final value = isKeyValue ? tryBooleanValue(parts.last) : true;

      return '$key: $value';
    });

    // Join the formatted pairs back into a string
    final formattedString = params.join('\n');
    return convertYamlToMap(formattedString);
  } on Exception catch (e) {
    throw FormatException('Error parsing tags: ${e}');
  }
}

/// The separator used to split the tag from its options.
const _TAG_OPTION_SEPARATOR = ' ';

/// Parses a line containing a tag and its options.
({String tag, Map<String, dynamic> options}) getTagContents(String line) {
  // Remove any leading or trailing whitespace from the input line
  line = line.trim();

  // Check if the line matches the expected syntax
  if (!_isSyntax(line)) {
    // If not, throw an exception with a descriptive error message
    throw FormatException('Invalid tag syntax: $line');
  }

  // Use a regular expression to match the contents of the tag
  final match = _regexMatchTagContents.firstMatch(line);

  // If no match is found, throw an exception
  if (match == null) {
    throw FormatException('Failed to extract tag contents: $line');
  }

  // Extract the first capturing group from the regex match and trim any whitespace
  // If the group is null or empty, use an empty string
  final result = match.group(1)?.trim() ?? '';

  // Split the result into parts using the defined separator
  final parts = result.split(_TAG_OPTION_SEPARATOR);

  // Extract the tag (first part of the split result)
  // If parts is empty, use an empty string
  final tag = parts.isNotEmpty ? parts.first : '';

  // Join the remaining parts (if any) back into a string for options parsing
  // If there's only one part (just the tag), use an empty string
  final optionsPart =
      parts.length > 1 ? parts.sublist(1).join(_TAG_OPTION_SEPARATOR) : '';

  // Parse the options string into a Map using a helper function
  final options = getOptionsMapFromLine(optionsPart);

  // If the extracted tag is empty, throw an exception
  if (tag.isEmpty) {
    throw FormatException('Empty tag extracted: $line');
  }

  // Return a record containing the tag and options
  return (
    tag: tag,
    options: options,
  );
}
