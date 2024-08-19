import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:yaml/yaml.dart';

import '../models/options_model.dart';
import 'extensions.dart';

const _tagMarker = '@';

const _startAsTag = '{' + _tagMarker;

final _regexMatchTagContents = RegExp('{$_tagMarker(.*?)}');

abstract class Part {
  const Part();
}

T? _findEnumValue<T extends Enum>(
  List<T> values,
  String value,
) {
  return values.firstWhereOrNull(
    (element) => element.name == value,
  );
}

enum SectionPartType {
  root,
  header,
  body,
  footer;
}

enum SubSectionPartType {
  content,
  image;
}

sealed class SubSectionPart<T extends ContentOptions> extends Part {
  final SubSectionPartType type;
  final T options;

  SubSectionPart({
    required this.type,
    required this.options,
  });
}

class ContentPart extends SubSectionPart<ContentOptions> {
  final String content;

  ContentPart({
    required this.content,
    required super.options,
  }) : super(type: SubSectionPartType.content);

  ContentPart copyWith({
    String? content,
  }) {
    return ContentPart(
      content: content ?? this.content,
      options: this.options,
    );
  }
}

class ImagePart extends SubSectionPart<ImageOptions> {
  ImagePart({
    required super.options,
  }) : super(type: SubSectionPartType.image);
}

Part? parsePart(String line) {
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
      ContentOptionsMapper.fromMap(
        options,
      ),
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
          options: ImageOptionsMapper.fromMap(options),
        );
    }
  }
  return null;
}

sealed class SectionPart extends Part {
  final SectionPartType type;
  final ContentOptions options;
  List<SubSectionPart> subSections = [];

  SectionPart({
    required this.type,
    required this.options,
  });

  factory SectionPart.build(
    SectionPartType type,
    ContentOptions options,
  ) {
    return switch (type) {
      SectionPartType.header => HeaderLayoutPart(options),
      SectionPartType.body => BodyLayoutPart(options),
      SectionPartType.footer => FooterLayoutPart(options),
      SectionPartType.root => RootLayoutPart(options),
    };
  }

  String get name => type.name;

  void concatLine(String content) {
    final lastPart = subSections.lastOrNull;

    if (lastPart is ContentPart) {
      final contentPart = lastPart;

      subSections.last = contentPart.copyWith(
        content: contentPart.content + '\n' + content,
      );
    } else {
      subSections.add(ContentPart(
        content: content,
        options: ContentOptions(),
      ));
    }
  }
}

class RootLayoutPart extends SectionPart {
  RootLayoutPart(ContentOptions options)
      : super(type: SectionPartType.root, options: options);
}

class HeaderLayoutPart extends SectionPart {
  HeaderLayoutPart(ContentOptions options)
      : super(type: SectionPartType.header, options: options);
}

class BodyLayoutPart extends SectionPart {
  BodyLayoutPart(ContentOptions options)
      : super(type: SectionPartType.body, options: options);
}

class FooterLayoutPart extends SectionPart {
  FooterLayoutPart(ContentOptions options)
      : super(type: SectionPartType.footer, options: options);
}

List<SectionPart> parseSections(String markdown, [ContentOptions? options]) {
  final lines = markdown.split('\n');

  final rootSection = RootLayoutPart(options ?? ContentOptions());

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
      currentSection.concatLine(line);
      continue;
    }

    final part = parsePart(line);

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
        if (currentSection.subSections.isNotEmpty) {
          // throw error that says if to use any section wrapping all the content of the markdown
          throw Exception(
            'Invalid location tag on line ${lineIndex}. ${part.type.name} cannot be before ${currentSection.type.name}',
          );
        }
      }
      // Save current section before setting as current
      layoutParts.add(currentSection);
      currentSection = part;
    } else if (part is SubSectionPart) {
      // final lastSubSection = currentSection.subSections.lastOrNull;
      // if (part is ContentPart && lastSubSection is ContentPart) {
      //   // If last section is empty it should just replace it
      //   if (lastSubSection.content.isEmpty) {
      //     currentSection.subSections.last = part;
      //   } else {
      //     currentSection.subSections.add(part);
      //   }
      // }

      currentSection.subSections.add(part);
    }
  }

  layoutParts.add(currentSection);

  // Return the parsed sections
  //  remove all sections that have empty parts
  return layoutParts.where((part) {
    return part.subSections.isNotEmpty;
  }).toList();
}

Map<String, dynamic> _converYamlToMap(String yamlString) {
  if (yamlString.isEmpty) {
    return {};
  }
  final yamlMap = loadYaml(yamlString) as YamlMap? ?? YamlMap();

  final yaml = jsonEncode(yamlMap);

  return jsonDecode(yaml);
}

bool _isSyntax(String line) {
  return _regexMatchTagContents.hasMatch(line.trim());
}

@visibleForTesting
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
      final parts = e.split(': ').map((e) => e.trim()).toList();

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
    return _converYamlToMap(formattedString);
  } on Exception catch (e) {
    throw FormatException('Error parsing tags: ${e}');
  }
}

@visibleForTesting
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
