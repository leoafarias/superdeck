import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:yaml/yaml.dart';

class SlideOptionsParser {
  SlideOptionsParser(this.text);
  final String text;

  SlideOptions parse() {
    final frontMatterParser = FrontMatterParser(text);
    final yamlData = frontMatterParser.parse();

    final map = yamlData.value.cast<String, dynamic>();
    final keys = map.keys.toList();
    for (final key in keys) {
      if (!SlideOptions.availableOptions.contains(key)) {
        throw Exception(
          '''
Invalid option: $key
Available Options: ${SlideOptions.availableOptions.join(', ')}
          ''',
        );
      }
    }

    return SlideOptions.fromMap(map);
  }
}

class FrontMatterParser {
  FrontMatterParser(this.text);
  final String text;
  static const delimiter = '---';

  YamlMap parse() {
    final value = text.trim();

    // If there's no starting delimiter, there's no front matter.
    if (!value.startsWith(delimiter)) {
      throw const FormatException('Front matter data not found');
    }

    // Get the index of the closing delimiter.
    final closeIndex = value.indexOf(delimiter, delimiter.length);

    // Get the raw front matter block between the opening and closing delimiters.
    final frontMatterString = value.substring(delimiter.length, closeIndex);

    if (frontMatterString.trim().isEmpty) {
      return YamlMap();
    }

    // Remove empty line spaces
    final parsedYaml = loadYaml(
      frontMatterString,
    );
    if (parsedYaml == null) {
      throw const FormatException('Failed to parse YAML');
    }
    return parsedYaml as YamlMap;
  }
}
