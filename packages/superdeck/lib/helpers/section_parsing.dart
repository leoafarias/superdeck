import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:yaml/yaml.dart';

import '../models/options_model.dart';

enum Section {
  header,
  body,
  footer;

  String get _prefix => '{.';
  String get _suffix => '}';

  String get tag => '${_prefix}${name}${_suffix}';

  int get startIndex => '$_prefix$name'.length;

  static Section? getLocation(String line) {
    return Section.values
        .firstWhereOrNull((e) => line.startsWith(e._prefix + e.name));
  }

  static bool isLocationTag(String line) {
    return getLocation(line) != null;
  }

  String getContents(String line) {
    return line.substring(startIndex, line.indexOf(_suffix));
  }
}

abstract class Part<T> {
  final T options;
  const Part({required this.options});
}

class ImagePart extends Part<ImageOptions> {
  static const tag = '.image';
  const ImagePart({
    required super.options,
  });
}

class ContentPart extends Part<ContentOptions> {
  static const tag = '.content';
  String content = '';

  ContentPart({
    required super.options,
  });

  // I woul dlike to parse the following as if it were a yaml
  // {.content align:center flex:2}
  // {.content align:bottom_center }
  // {.content flex:2}
  // {.content}

  static ContentPart? parse(String line) {
    // Check if it starts with {+ ContentPart.tag
    //  if not return null
    // if so remove {+ ContentPart.tag + }
    final cleanedLine = line
        .trim()
        .replaceAll(RegExp(r'[{}]'), '')
        .replaceAll(ContentPart.tag, '');

    return ContentPart(
      options: ContentOptionsMapper.fromMap(_converYamlToMap(cleanedLine)),
    );
  }
}

class SectionPart {
  final Section location;
  final int flex;
  final List<ContentPart> contentParts;

  SectionPart({
    required this.location,
    required this.contentParts,
    required this.flex,
  });
}

typedef LayoutPartInfo = ({Section location, ContentOptions options});

List<SectionPart> parseSections(String markdown) {
  final lines = markdown.split('\n');

  final sectionFlex = ({
    Section.header: 1,
    Section.body: 1,
    Section.footer: 1,
  });

  final sectionParts = ({
    Section.header: <ContentPart>[],
    Section.body: <ContentPart>[],
    Section.footer: <ContentPart>[],
  });

  Section? currentLocation = null;

  int lineIndex = 0;
  for (final line in lines) {
    lineIndex++;
    final trimmedLine = line.trim();
    // Skip empty lines
    if (trimmedLine.isEmpty) {
      continue;
    } else if (Section.isLocationTag(trimmedLine)) {
      final location = Section.getLocation(trimmedLine)!;

      if (currentLocation != null) {
        if (location.index <= currentLocation.index) {
          throw Exception(
            'Invalid location tag on line ${lineIndex}. ${location.tag} cannot be before ${currentLocation.tag}',
          );
        }
      }

      currentLocation = location;
      sectionFlex[location] = _getFlexAttributeFromLine(line);
    } else {
      if (currentLocation == null) {
        currentLocation = Section.body;
      }

      final contentPart = ContentPart.parse(line);

      if (contentPart != null) {
        // If previous content is empty there is no need to create a column
        sectionParts[currentLocation]!.add(contentPart);
      } else {
        if (sectionParts[currentLocation]!.isEmpty) {
          sectionParts[currentLocation]!.add(
            ContentPart(
              options: ContentOptions(),
            ),
          );
        }

        final lastPart = sectionParts[currentLocation]!.last;

        sectionParts[currentLocation]!.last = lastPart
          ..content = (lastPart.content += line + '\n');
      }
    }
  }

  Section.values.forEach((section) {
    final contentParts = sectionParts[section]!;
    if (contentParts.isEmpty) {
      sectionParts.remove(section);
    } else {
      sectionParts[section] =
          contentParts.where((part) => !part.content.isEmpty).toList();
    }
  });

  // Return the parsed sections
  //  remove all sections that have empty parts
  return sectionParts.entries.map((entry) {
    final location = entry.key;
    final parts = entry.value;
    final options = sectionFlex[location]!;

    return SectionPart(
      location: location,
      contentParts: parts,
      flex: options,
    );
  }).toList();
}

int _getFlexAttributeFromLine(String line) {
  final attributes = extractAttributesFromLine(line);
  final flex = attributes['flex'];

  if (flex == null) {
    return 1;
  }

  final parsed = int.tryParse(flex);
  if (parsed == null) {
    throw Exception('Flex value must be an integer. Found: $flex');
  }

  return parsed;
}

ContentAlignment? _getAlignmentAttributeFromLine(String value) {
  final attributes = extractAttributesFromLine(value);
  final alignment = attributes['align'];

  if (alignment == null) {
    return null;
  }

  try {
    return ContentAlignmentMapper.fromValue(alignment);
  } catch (e) {
    throw Exception('Invalid alignment value: $alignment');
  }
}

@visibleForTesting
Map<String, String> extractAttributesFromLine(String line) {
  final cleanedLine = line.trim().replaceAll(RegExp(r'[{}]'), '');

  final regex = RegExp(r'(\w+):([^\s]+)');
  final matches = regex.allMatches(cleanedLine);

  final attributes = <String, String>{};

  for (final match in matches) {
    final key = match.group(1);
    final value = match.group(2);

    if (key != null && value != null) {
      attributes[key] = value;
    }
  }

  return attributes;
}

Map<String, dynamic> _converYamlToMap(String yamlString) {
  final yamlMap = loadYaml(yamlString) as YamlMap? ?? YamlMap();

  final yaml = jsonEncode(yamlMap);

  return jsonDecode(yaml);
}
