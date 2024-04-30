import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:yaml/yaml.dart';

Map<String, dynamic> converYamlToMap(String yamlString) {
  final yamlMap = loadYaml(yamlString) as YamlMap? ?? YamlMap();

  final yaml = jsonEncode(yamlMap);

  return jsonDecode(yaml);
}

/// Formats [json]
String prettyJson(dynamic json) {
  var spaces = ' ' * 2;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}

BoxConstraints calculateConstraints(Size size, BoxSpec spec) {
  final padding = spec.padding ?? EdgeInsets.zero;
  final margin = spec.margin ?? EdgeInsets.zero;

  double horizontalBorder = 0.0;
  double verticalBorder = 0.0;

  if (spec.decoration is BoxDecoration) {
    final border = (spec.decoration as BoxDecoration).border;
    if (border != null) {
      horizontalBorder = border.dimensions.horizontal;
      verticalBorder = border.dimensions.vertical;
    }
  }

  final horizontalSpacing =
      padding.horizontal + margin.horizontal + horizontalBorder;
  final verticalSpacing = padding.vertical + margin.vertical + verticalBorder;

  return BoxConstraints(
    maxHeight: size.height - verticalSpacing,
    maxWidth: size.width - horizontalSpacing,
  );
}

({List<T> added, List<T> removed}) compareListChanges<T>(
  List<T> oldList,
  List<T> newList,
) {
  final added = <T>[];
  final removed = <T>[];

  final oldSet = oldList.toSet();
  final newSet = newList.toSet();

  for (final item in newList) {
    if (!oldSet.contains(item)) {
      added.add(item);
    }
  }

  for (final item in oldList) {
    if (!newSet.contains(item)) {
      removed.add(item);
    }
  }

  return (
    added: added,
    removed: removed,
  );
}

extension BuildContextExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isSmall => MediaQuery.of(this).size.width < 600;

  Size get size => MediaQuery.sizeOf(this);
  bool get isMedium => size.width >= 600 && size.width < 1024;

  bool get isLarge => size.width >= 1024;

  bool get isExtraLarge => size.width >= 1440;

  bool get isMobile => isSmall || isMobileLandscape;

  bool get isMobileLandscape {
    return size.shortestSide < 600 && isLandscape;
  }

  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;

  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;

  double get width => size.width;
  double get height => size.height;
}

/// Generates a short, unique identifier from a given string.
/// This is needed as hashCode for strings is not guaranteed to be unique across different platforms
///
/// This function uses a hashing mechanism to transform the input string into
/// a unique, 8-character identifier. It is useful for creating compact and
/// unique keys for database entries, URLs, etc.
///
/// [valueToHash] is the string input that you want to convert into a hash ID.
///
/// Returns an 8-character string that represents the hashed ID.
String shortHashId(String valueToHash) {
  // Define a string of possible characters that can appear in the output hash.
  const characters =
      'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ0123456789';

  // Initialize hash to zero.
  int hash = 0;

  // Calculate the hash value from each character in the input string.
  for (int i = 0; i < valueToHash.length; i++) {
    int charIndex = characters.indexOf(valueToHash[i]);
    // Continue to next iteration if character is not found in the characters string.
    if (charIndex == -1) {
      continue;
    }
    // Update the hash value using the character's index and position.
    hash = (hash * 31 + charIndex + i) % 2147483647;
  }

  // Initialize the short ID as an empty string.
  String shortId = '';
  int base = characters.length;
  int remainingHash = hash;

  // Construct the short ID using the hash value.
  for (int i = 0; i < 8; i++) {
    shortId += characters[remainingHash % base];
    remainingHash = (remainingHash * 31 + hash) % 2147483647;
  }

  return shortId;
}
