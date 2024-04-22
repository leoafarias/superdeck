import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:watcher/watcher.dart';

import '../models/asset_model.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import 'config.dart';
import 'markdown_processor.dart';

class SlidesLoader {
  // Constructor that accepts the text input for parsing.
  const SlidesLoader._();

  static const _pipeline = Pipeline(
    markdown: [
      FrontMatterProcessor(),
      MermaidProcessor(),
      ImageMarkdownProcessor(),
    ],
    postMarkdown: [
      StoreLocalReferencesProcessor(),
    ],
  );

  static Future<void> generate() async {
    final markdownFile = kConfig.slidesMarkdownFile;

    if (!await markdownFile.exists()) {
      throw Exception('Slides markdown file not found');
    }

    if (!await kConfig.assetsImageDir.exists()) {
      await kConfig.assetsImageDir.create(recursive: true);
    }

    await _pipeline.run(await markdownFile.readAsString());
  }

  static List<StreamSubscription<WatchEvent>> listen({
    required void Function() onChange,
  }) {
    return [
      kConfig.slidesMarkdownFile,
      kConfig.projectConfigFile,
    ].map((file) {
      return FileWatcher(file.path).events.listen((event) async {
        if (event.type == ChangeType.MODIFY) {
          onChange();
        }
      });
    }).toList();
  }

  static Future<DeckData> loadFromStorage() async {
    if (kIsWeb) {
      return _loadFromRootBundle();
    }

    if (kDebugMode) {
      return _loadFromLocalStorage();
    } else {
      return _loadFromRootBundle();
    }
  }
}

Future<DeckData> _loadFromLocalStorage() async {
  final slidesJson = await kConfig.references.slides.readAsString();
  final assetsJson = await kConfig.references.assets.readAsString();
  final configJson = await kConfig.references.config.readAsString();

// parsed json

  return (
    slides: _parseFromJson(slidesJson),
    assets: _parseAssets(assetsJson),
    config: ProjectConfig.fromJson(configJson),
  );
}

Future<DeckData> _loadFromRootBundle() async {
  final slidesJson =
      await rootBundle.loadString(kConfig.references.slides.path);
  final assetsJson =
      await rootBundle.loadString(kConfig.references.assets.path);
  final configJson =
      await rootBundle.loadString(kConfig.references.config.path);

  return (
    slides: _parseFromJson(slidesJson),
    assets: _parseAssets(assetsJson),
    config: ProjectConfig.fromJson(configJson)
  );
}

List<SlideAsset> _parseAssets(String assetsJson) {
  final assets = jsonDecode(assetsJson) as List;
  return assets.map((asset) => SlideAsset.fromMap(asset)).toList();
}

List<Slide> _parseFromJson(String slidesJson) {
  final slides = jsonDecode(slidesJson) as List;
  final slideMap = List.castFrom<dynamic, Map<String, dynamic>>(slides);

  return slideMap.map(Slide.fromMap).toList();
}
