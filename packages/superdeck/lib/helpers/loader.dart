import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

class SlidesLoader {
  // Constructor that accepts the text input for parsing.
  SlidesLoader();

  Future<void> load() async {
    final slidesMarkdown = config.slidesMarkdownFile;

    if (!await slidesMarkdown.exists()) {
      throw Exception('Slides markdown file not found');
    }

    final presentationContent = await slidesMarkdown.readAsString();

    final (contents, imageFiles) =
        await replaceMermaidContent(presentationContent);

    await _saveSlideJson(contents);

    await _generateAssetsJson();

    // Delete any file within assetsDir that is not imageFiles
    await config.assetsImageDir.list().forEach((f) async {
      if (f is File) {
        if (!imageFiles.any((element) => element.path == f.path)) {
          await f.delete();
        }
      }
    });
  }

  Future<void> _saveSlideJson(String contents) async {
    final slidesJson = config.slidesJsonFile;

    if (!await slidesJson.exists()) {
      await slidesJson.create(recursive: true);
    }

    // Write a json file with a list of slides
    await slidesJson.writeAsString(prettyJson(_parse(contents)));
    // Map<String,String> assets = {};
    // The key will be the file name and the value will be a base64 encoded string
  }

  Future<void> _generateAssetsJson() async {
    final assetMap = {};
    final assetsJson = config.assetsJsonFile;

    if (!await assetsJson.exists()) {
      await assetsJson.create(recursive: true);
    }

    final files =
        await config.assetsImageDir.list().where((f) => f is File).toList();

    await Future.wait(files.map((f) async {
      final bytes = await (f as File).readAsBytes();
      final base64 = base64Encode(bytes);
      final relativePath = relative(
        f.path,
        from: config.assetsDir.parent.path,
      );

      assetMap[relativePath] = base64;
    }));

    //  convert a map to a an array of objects with key and value
    final listOfAssets = assetMap.entries
        .map((e) => {'name': e.key, 'base64': e.value})
        .toList();
    await assetsJson.writeAsString(prettyJson(listOfAssets));
  }

  final _frontMatterRegex = RegExp(r'---([\s\S]*?)---');

  // Public method that parses the text and returns a list of SlideData.
  List<Map<String, dynamic>> _parse(String text) {
    // Map the front matter and content to a list of _SlideParserData objects.
    return _extractSlides(text).map((slide) {
      final frontMatter = _extractFrontMatter(slide);
      final options = _parseFrontMatter(frontMatter);
      final content = _removeMatchingFrontMatter(slide, frontMatter);
      return {
        ...options,
        'content': content,
      }.cast<String, dynamic>();
    }).toList();
  }

  String _extractFrontMatter(String slide) {
    return _frontMatterRegex.firstMatch(slide)?.group(1) ?? '';
  }

  Map<dynamic, dynamic> _parseFrontMatter(String frontMatter) {
    return loadYaml(frontMatter) as YamlMap? ?? {};
  }

  String _removeMatchingFrontMatter(String slide, String frontMatter) {
    return slide
        .substring(_frontMatterRegex.matchAsPrefix(slide)?.end ?? 0)
        .trim();
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
      slides.add(buffer.toString().trim());
    }

    return slides;
  }
}

Future<(String, List<File>)> replaceMermaidContent(String content) async {
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
}

/// Formats [json]
String prettyJson(dynamic json) {
  var spaces = ' ' * 2;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}
