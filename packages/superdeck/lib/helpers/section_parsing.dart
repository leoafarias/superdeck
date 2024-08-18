import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:yaml/yaml.dart';

import '../models/options_model.dart';

abstract class Part {
  const Part();
}

enum SectionPartType {
  root,
  header,
  body,
  footer;

  String get tag => '.$name';
}

enum SubSectionPartType {
  content,
  image;

  String get tag => '.$name';
}

sealed class SubSectionPart<T> extends Part {
  final T options;

  SubSectionPart({
    required this.options,
  });
}

class ContentPart extends SubSectionPart<ContentOptions> {
  static const tag = '.content';
  final String content;

  ContentPart({
    required this.content,
    required super.options,
  });

  ContentPart copyWith({
    String? content,
  }) {
    return ContentPart(
      content: content ?? this.content,
      options: this.options,
    );
  }
}

class ImagePart extends Part {
  static const tag = '.image';
  final ImageOptions options;
  const ImagePart({
    required this.options,
  });
}

Part? parsePart(String line) {
  if (!_isSyntax(line)) {
    return null;
  }

  final tagContents = _getTagContents(line);

  final sectionName = SectionPartType.values.firstWhereOrNull(
    (part) => tagContents.startsWith(part.tag),
  );

  if (sectionName != null) {
    return SectionPart.build(
      sectionName,
      ContentOptionsMapper.fromMap(
        getOptionsMapFromLine(sectionName.tag, tagContents),
      ),
    );
  }

  final subSectionName = SubSectionPartType.values.firstWhereOrNull(
    (part) => tagContents.startsWith(part.tag),
  );

  if (subSectionName != null) {
    final options = getOptionsMapFromLine(subSectionName.tag, tagContents);

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

    if (trimmedLine.startsWith('{') && !trimmedLine.endsWith('}')) {
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
          'Invalid location tag on line ${lineIndex}. ${part.type.tag} cannot be before ${currentSection.type.tag}',
        );
      }

      if (currentSection is RootLayoutPart) {
        if (currentSection.subSections.isNotEmpty) {
          // throw error that says if to use any section wrapping all the content of the markdown
          throw Exception(
            'Invalid location tag on line ${lineIndex}. ${part.type.tag} cannot be before ${currentSection.type.tag}',
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
  final trimmedLine = line.trim();
  return trimmedLine.startsWith('{') && trimmedLine.endsWith('}');
}

@visibleForTesting
Map<String, dynamic> getOptionsMapFromLine(
  String tag,
  String contents,
) {
  var rawString = contents.substring(tag.length).trim();

  if (rawString.isEmpty) {
    return {};
  }

  // I would like to replace any value with ":" and any number of spaces after with just ":"
  final regex = RegExp(r':\s+');

  // this will turn "key: value" into "key:value"
  final values = rawString.replaceAll(regex, ':');

  print('Values: $values');
  // Add space to is easier to separate just in case
  // final values = rawString.replaceAll(': ', ':');

  // Now I want to split every value into value also with space, and combine
  // the key and value back together
  final pairs = values.split(' ');

  // Join the formatted pairs back into a string
  final formattedString = pairs.join('\n').replaceAll(':', ': ');

  try {
    return _converYamlToMap(formattedString);
  } catch (e) {
    throw FormatException('Error parsing tags: $formattedString');
  }
}

String _getTagContents(String line) {
  final regex = RegExp(r'{(.*?)}');
  final match = regex.firstMatch(line);

  if (match != null) {
    return match.group(1)?.trim() ?? '';
  }

  return '';
}
