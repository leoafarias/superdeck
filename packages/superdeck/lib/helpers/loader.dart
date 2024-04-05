import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:json_schema/json_schema.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import '../models/config_model.dart';
import '../models/schema_error_model.dart';
import '../models/slide_asset_model.dart';
import 'validation.dart';

typedef DeckData = (
  List<SlideOptions> slides,
  List<SlideAsset> assets,
);

class SlidesLoader {
  // Constructor that accepts the text input for parsing.
  const SlidesLoader._();

  //  Sloppy I know, will clean it up later

  static Future<List<ValidationError>> validateProjectConfig() async {
    final projectConfig = config.projectConfigFile;
    final projectConfigContents = await projectConfig.readAsString();

    return projectSchemeValidator
        .validate(_loadYamlAsMap(projectConfigContents))
        .errors;
  }

  static Future<ProjectOptions> loadProjectConfig() async {
    final projectConfig = config.projectConfigFile;

    if (!await projectConfig.exists()) {
      return const ProjectOptions();
    }

    final projectConfigContents = await projectConfig.readAsString();

    return ProjectOptions.fromMap(_loadYamlAsMap(projectConfigContents));
  }

  static Future<DeckData> load() async {
    final slidesMd = config.slidesMarkdownFile;

    if (!await slidesMd.exists()) {
      throw Exception('Slides markdown file not found');
    }

    final slidesMdContents = await slidesMd.readAsString();

    final (contents, imageFiles) =
        await getMermaidContentAndAssets(slidesMdContents.trim());

    final slides = _parseSlidesYaml(contents);
    final assets = await _parseAssetsFromFiles(imageFiles);

    await _saveSlideJson(slides);
    await _saveAssetsJson(assets);

    return (slides, assets);
  }

  static Future<DeckData> loadFromStorage() async {
    await load();
    if (kDebugMode) {
      return _loadFromLocalStorage();
    } else {
      return _loadFromRootBundle();
    }
  }

  static Future<void> _saveSlideJson(List<SlideOptions> slides) async {
    final slidesJson = config.slidesJsonFile;

    if (!await slidesJson.exists()) {
      await slidesJson.create(recursive: true);
    }

    final map = slides.map((e) => e.toMap()).toList();

    // Write a json file with a list of slide
    await slidesJson.writeAsString(prettyJson(map));
  }

  static Future<void> _saveAssetsJson(List<SlideAsset> assets) async {
    final assetsJson = config.assetsJsonFile;

    if (!await assetsJson.exists()) {
      await assetsJson.create(recursive: true);
    }
    final map = assets.map((e) => e.toMap()).toList();
    // Write a json file with a list of assets
    await assetsJson.writeAsString(prettyJson(map));

    await config.assetsImageDir.list().forEach((f) async {
      if (f is File) {
        if (!assets.any((element) => element.path == f.path)) {
          await f.delete();
        }
      }
    });
  }

  static Future<List<SlideAsset>> _parseAssetsFromFiles(
    List<File> files,
  ) async {
    final assets = <SlideAsset>[];

    await Future.wait(files.map((f) async {
      final asset = await _getImage(f.path);
      assets.add(asset);
    }));

    return assets;
  }
}

Future<SlideAsset> _getImage(String imagePath) async {
  final File imageFile = File(imagePath);
  final Uint8List bytes = await imageFile.readAsBytes();
  final ui.Codec codec = await ui.instantiateImageCodec(bytes);
  final ui.FrameInfo frame = await codec.getNextFrame();

  return SlideAsset(
    path: imagePath,
    bytes: bytes,
    width: frame.image.width.toDouble(),
    height: frame.image.height.toDouble(),
  );
}

Future<DeckData> _loadFromLocalStorage() async {
  final slidesJson = await config.slidesJsonFile.readAsString();
  final assetsJson = await config.assetsJsonFile.readAsString();

  return (_parseSlides(slidesJson), _parseAssets(assetsJson));
}

Future<DeckData> _loadFromRootBundle() async {
  final slidesJson = await rootBundle.loadString(config.slidesJsonFile.path);
  final assetsJson = await rootBundle.loadString(config.assetsJsonFile.path);

  return (_parseSlides(slidesJson), _parseAssets(assetsJson));
}

List<SlideAsset> _parseAssets(String assetsJson) {
  final assets = jsonDecode(assetsJson) as List;
  return assets.map((asset) => SlideAsset.fromMap(asset)).toList();
}

Future<(String, List<File>)> getMermaidContentAndAssets(String content) async {
  final RegExp mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');
  final List<Map<String, dynamic>> replacements = [];
  final List<File> imageFiles = [];

  final Iterable<Match> matches = mermaidBlockRegex.allMatches(content);
  for (final Match match in matches) {
    final String? mermaidSyntax = match.group(1);
    if (mermaidSyntax == null) continue;

    // Process the mermaid syntax to generate an image file
    final imageFile = await _processMermaidSyntax(mermaidSyntax);

    final relativePath =
        relative(imageFile.path, from: config.assetsDir.parent.path);

    final String imageMarkdown = '![Mermaid Diagram]($relativePath)';

    // Collect replacement information
    replacements.add({
      'start': match.start,
      'end': match.end,
      'replacement': imageMarkdown,
    });

    imageFiles.add(imageFile);
  }

  // Apply replacements in reverse order
  for (var replacement in replacements.reversed) {
    final int start = replacement['start'];
    final int end = replacement['end'];
    final String replacementText = replacement['replacement'];

    content =
        content.substring(0, start) + replacementText + content.substring(end);
  }

  return (content, imageFiles);
}

Future<File> _processMermaidSyntax(String mermaidSyntax) async {
  String tempFilePath = 'temp.mmd';
  final tempFile = File(tempFilePath);

  try {
    mermaidSyntax = mermaidSyntax.trim().replaceAll(r'\n', '\n');

    // has the mermaidSyntax string
    final filePath = 'sd_mermaid_${mermaidSyntax.hashCode}.png';
    final mermaidAssetFile = File(join(config.assetsImageDir.path, filePath));

    if (await mermaidAssetFile.exists()) {
      return mermaidAssetFile;
    }

    await tempFile.writeAsString(mermaidSyntax);

    final outputFile = File(join(config.assetsImageDir.path, filePath));

    if (!await outputFile.parent.exists()) {
      await outputFile.parent.create(recursive: true);
    }

    final imageSizeParams = '--scale 2'.split(' ');
    final params =
        '-t dark -b transparent -i $tempFilePath -o ${outputFile.path} '
            .split(' ');

    final result = await Process.run('mmdc', [...params, ...imageSizeParams]);

    if (result.exitCode != 0) {
      print('Error while processing mermaid syntax');
      print(result.stderr);
    }

    return outputFile;
  } catch (e) {
    throw Exception('Error while processing mermaid syntax');
  } finally {
    if (await tempFile.exists()) {
      await tempFile.delete();
    }
  }
}

Map<String, dynamic> _loadYamlAsMap(String yamlString) {
  final yamlMap = loadYaml(yamlString) as YamlMap? ?? YamlMap();
  return _convertYamlToMap(yamlMap);
}

final _frontMatterRegex = RegExp(r'---([\s\S]*?)---');

String _extractFrontMatter(String slide) {
  return _frontMatterRegex.firstMatch(slide)?.group(1) ?? '';
}

String _removeMatchingFrontMatter(String slide, String frontMatter) {
  return slide
      .substring(_frontMatterRegex.matchAsPrefix(slide)?.end ?? 0)
      .trim();
}

dynamic _convertYamlToMap(dynamic yamlObject) {
  if (yamlObject is YamlMap) {
    Map<String, dynamic> dartMap = {};
    yamlObject.forEach((key, value) {
      dartMap[key.toString()] = _convertYamlToMap(value);
    });
    return dartMap;
  } else {
    return yamlObject;
  }
}

List<String> _extractSlides(String content) {
  final lines = content.split('\n');
  final slides = <String>[];
  final buffer = StringBuffer();
  bool inSlide = false;

  for (var line in lines) {
    if (line.trim() == '---') {
      if (buffer.isNotEmpty) {
        if (inSlide) {
          // Add the slide content to the list of slides
          slides.add(buffer.toString().trim());
          inSlide = false;
          buffer.clear();
        } else {
          inSlide = true;
        }
      }
      buffer.writeln(line);
    } else {
      buffer.writeln(line);
    }
  }

  // Capture any remaining content as a slide
  if (buffer.isNotEmpty) {
    slides.add(buffer.toString());
  }

  return slides;
}

final config = SuperDeckConfig();

class SuperDeckConfig {
  SuperDeckConfig();

  String get _assetsDirName => 'assets';

  String get _slidesMarkdownName => 'slides.md';

  File get slidesMarkdownFile => File(_slidesMarkdownName);
  Directory get assetsDir => Directory(_assetsDirName);
  Directory get assetsImageDir => Directory(join(_assetsDirName, 'images'));
  File get slidesJsonFile => File(join(_assetsDirName, 'slides.json'));
  File get assetsJsonFile => File(join(_assetsDirName, 'assets.json'));
  File get projectConfigFile => File('superdeck.yaml');
}

/// Formats [json]
String prettyJson(dynamic json) {
  var spaces = ' ' * 2;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}

List<SlideOptions> _parseSlidesYaml(String slidesYaml) {
  return _extractSlides(slidesYaml).map((String slideYaml) {
    final frontMatter = _extractFrontMatter(slideYaml);
    final options = _loadYamlAsMap(frontMatter);
    final content = _removeMatchingFrontMatter(slideYaml, frontMatter);

    final map = {
      ...options,
      'content': content,
    }.cast<String, dynamic>();

    return _validateAndParseSlide(map);
  }).toList();
}

List<SlideOptions> _parseSlides(String slidesJson) {
  final slides = jsonDecode(slidesJson) as List;
  final slideMap = List.castFrom<dynamic, Map<String, dynamic>>(slides);
  return slideMap.map(SlideOptions.fromMap).toList();
}

SlideOptions _validateAndParseSlide(Map<String, dynamic> slideContent) {
  try {
    final results = schemaValidator.validate(slideContent);
    if (!results.isValid) {
      final errors = results.errors.map(parseErrorObject).toList();
      final hasUnknownError =
          errors.any((element) => element.errorType == ErrorType.unknown);

      // If there is an schema error lets handle the parsing to see the problem
      if (!hasUnknownError) {
        return SchemaErrorSlideOptions(
          content: "# Schema Error",
          errors: errors,
        );
      }
    }
    return SlideOptionsMapper.fromMap(slideContent);
  } on MapperException catch (e) {
    print(e);
    return SchemaErrorSlideOptions(
      content: '# Exception: \n ${e.message}',
      errors: [],
    );
  }
}
