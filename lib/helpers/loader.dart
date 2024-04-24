import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:watcher/watcher.dart';

import '../models/options_model.dart';
import '../models/slide_model.dart';
import 'config.dart';
import 'constants.dart';
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

  static Future<String> loadString(String path) {
    if (kCanRunProcess) {
      return File(path).readAsString();
    } else {
      return rootBundle.loadString(path);
    }
  }

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
    final slidesJson =
        await SlidesLoader.loadString(kConfig.references.slides.path);

    final configJson =
        await SlidesLoader.loadString(kConfig.references.config.path);

    return (
      slides: _parseFromJson(slidesJson),
      config: ProjectConfig.fromJson(configJson)
    );
  }
}

List<Slide> _parseFromJson(String slidesJson) {
  final slides = jsonDecode(slidesJson) as List;
  final slideMap = List.castFrom<dynamic, Map<String, dynamic>>(slides);

  return slideMap.map(Slide.fromMap).toList();
}
