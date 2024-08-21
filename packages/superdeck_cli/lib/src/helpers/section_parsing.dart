import 'package:collection/collection.dart';
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

SlidePart? parseBlock(String line) {
  if (!_isSyntax(line)) {
    return null;
  }

  final (:tag, :options) = getTagContents(line);

  final sectionName = _findEnumValue(
    SectionPartType.values,
    tag,
  );

  if (sectionName != null) {
    return SectionPart.build(
      sectionName,
      options: ContentOptionsMapper.fromMap(options),
    );
  }

  final subSectionName = _findEnumValue(
    SubSectionPartType.values,
    tag,
  );

  if (subSectionName != null) {
    switch (subSectionName) {
      case SubSectionPartType.content:
        return ContentPart(
          content: '',
          options: ContentOptionsMapper.fromMap(options),
        );
      case SubSectionPartType.image:
        return ImagePart(
          content: '',
          options: ImageOptionsMapper.fromMap(options),
        );
      case SubSectionPartType.widget:
        return WidgetPart(
          content: '',
          options: WidgetOptionsMapper.fromMap(options),
        );
    }
  }
  return null;
}

List<SectionPart> parseSections(String slideMarkdown) {
  final lines = slideMarkdown.split('\n');

  final rootSection = SectionPart.build(SectionPartType.root);

  final layoutParts = <SectionPart>{rootSection};

  // Start with the header
  SectionPart currentSection = rootSection;

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

    final part = parseBlock(line);

    if (part == null) {
      continue;
    }

    if (part is SectionPart) {
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

({String tag, Map<String, dynamic> options}) getTagContents(String line) {
  if (!_isSyntax(line)) {
    throw FormatException('Error parsing tags: $line');
  }
  final match = _regexMatchTagContents.firstMatch(line);

  final separator = '|||superdeck|||';

  String tag = '';
  Map<String, dynamic> options = {};

  if (match != null) {
    final result = match.group(1)?.trim() ?? '';

    final parts = result.replaceFirst(' ', separator).split(separator);

    tag = parts.tryElementAt(0) ?? '';
    final optionsPart = parts.tryElementAt(1) ?? '';

    options = getOptionsMapFromLine(optionsPart);
  }

  return (
    tag: tag,
    options: options,
  );
}
