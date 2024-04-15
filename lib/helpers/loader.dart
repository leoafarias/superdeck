import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import '../models/asset_model.dart';
import '../models/slide_model.dart';
import 'config.dart';
import 'markdown_processor.dart';

const _assetPrefix = 'sd_';

class SlidesLoader {
  // Constructor that accepts the text input for parsing.
  const SlidesLoader._();

  static Future<DeckData> load() async {
    final markdownFile = kConfig.slidesMarkdownFile;

    if (!await markdownFile.exists()) {
      throw Exception('Slides markdown file not found');
    }

    final markdownContents = await markdownFile.readAsString();

    const processor = ProcessorRunner([
      FrontMatterProcessor(),
      MermaidProcessor(),
    ]);

    final data = await processor.run(markdownContents);

    await _saveAssetsJson(data.assets);
    await _saveSlideJson(data.slides);

    return data;
  }

  static Future<DeckData> loadFromStorage() async {
    if (kIsWeb) {
      return _loadFromRootBundle();
    }
    await load();
    if (kDebugMode) {
      return _loadFromLocalStorage();
    } else {
      return _loadFromRootBundle();
    }
  }

  static Future<void> _saveSlideJson(List<Slide> slides) async {
    try {
      final slidesJson = kConfig.slidesJsonFile;

      final map = slides.map((e) => e.toMap()).toList();

      if (!await slidesJson.exists()) {
        await slidesJson.create(recursive: true);
      }

      // Write a json file with a list of slide
      await slidesJson.writeAsString(prettyJson(map));
    } catch (e) {
      print('Error while saving slides json: $e');
      rethrow;
    }
  }

  static Future<void> _saveAssetsJson(List<SlideAsset> assets) async {
    final assetsJson = kConfig.assetsJsonFile;

    if (!await assetsJson.exists()) {
      await assetsJson.create(recursive: true);
    }
    final map = assets.map((e) => e.toMap()).toList();
    // Write a json file with a list of assets
    await assetsJson.writeAsString(prettyJson(map));

    await kConfig.assetsImageDir.list().forEach((f) async {
      if (f is File) {
        if (!assets.any((element) => element.path == f.path)) {
          // Only remove if starts with the asset prefix
          if (f.path.startsWith(_assetPrefix)) {
            await f.delete();
          }
        }
      }
    });
  }
}

Future<DeckData> _loadFromLocalStorage() async {
  final slidesJson = await kConfig.slidesJsonFile.readAsString();
  final assetsJson = await kConfig.assetsJsonFile.readAsString();

  return (slides: _parseFromJson(slidesJson), assets: _parseAssets(assetsJson));
}

Future<DeckData> _loadFromRootBundle() async {
  final slidesJson = await rootBundle.loadString(kConfig.slidesJsonFile.path);
  final assetsJson = await rootBundle.loadString(kConfig.assetsJsonFile.path);

  return (slides: _parseFromJson(slidesJson), assets: _parseAssets(assetsJson));
}

List<SlideAsset> _parseAssets(String assetsJson) {
  final assets = jsonDecode(assetsJson) as List;
  return assets.map((asset) => SlideAsset.fromMap(asset)).toList();
}

Future<(String, List<File>)> _getImageContentAndAssets(String content) async {
  // Get any url of images that are in the markdown
  // Save it the local path on the device
  // and replace the url with the local path
  final imageRegex = RegExp(r'!\[.*?\]\((.*?)\)');

  //  Check also if image is on background: or src: in front matter
  //  and replace the url with the local path

  final List<File> imageFiles = [];

  final assetsJson = await kConfig.assetsJsonFile.readAsString();

  final assets = _parseAssets(assetsJson);

  final matches = imageRegex.allMatches(content);

  for (final Match match in matches) {
    final imageUrl = match.group(1);
    if (imageUrl == null) continue;

    if (!imageUrl.startsWith('http')) continue;

    // If its already in assets return file name in assetsjson
    final imageUrlHash = imageUrl.hashCode.toString();

    final asset = assets.firstWhereOrNull((e) => e.path.contains(imageUrlHash));

    File imageFile;
    if (asset != null) {
      imageFile = File(asset.path);
    } else {
      imageFile = await _downloadAndSave(imageUrl);
    }

    final relativePath =
        relative(imageFile.path, from: kConfig.assetsDir.parent.path);

    final imageMarkdown = '![Image]($relativePath)';

    content = content.replaceFirst(match.group(0)!, imageMarkdown);

    imageFiles.add(imageFile);
  }

  return (content, imageFiles);
}

Future<File> _downloadAndSave(String imageUrl) async {
  final imageUrlHash = imageUrl.hashCode.toString();

  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(imageUrl));
  final response = await request.close();
  final bytes = await consolidateHttpClientResponseBytes(response);

  final contentType = response.headers.contentType;
  // Default to .jpg if no extension is found
  final extension = contentType?.subType ?? 'jpg';

  final imageFile = File(join(
    kConfig.assetsImageDir.path,
    '$_assetPrefix$imageUrlHash.$extension',
  ));

  if (await imageFile.exists()) {
    return imageFile;
  }

  await imageFile.writeAsBytes(bytes);
  return imageFile;
}

/// Formats [json]
String prettyJson(dynamic json) {
  var spaces = ' ' * 2;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}

List<Slide> _parseFromJson(String slidesJson) {
  final slides = jsonDecode(slidesJson) as List;
  final slideMap = List.castFrom<dynamic, Map<String, dynamic>>(slides);

  return slideMap.map(Slide.fromMap).toList();
}
