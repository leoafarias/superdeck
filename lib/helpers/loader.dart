import 'dart:async';
import 'dart:io';

import 'package:watcher/watcher.dart';

import '../services/assets_service.dart';
import 'config.dart';
import 'constants.dart';
import 'markdown_processor.dart';

class SlidesLoader {
  // Constructor that accepts the text input for parsing.
  SlidesLoader._();

  static final instance = SlidesLoader._();

  static final List<StreamSubscription<WatchEvent>> _subscriptions = [];

  Future<DeckReferenceDto> generate(
      [File? markdownFile, File? configFile]) async {
    markdownFile ??= sdConfig.slidesMarkdownFile;
    configFile ??= sdConfig.projectConfigFile;

    final assets = await AssetService.instance.loadAssets();
    final config = await AssetService.instance.loadProjectConfig(configFile);

    final pipeline = Pipeline(
      config: config,
      assets: assets,
      processors: [
        const ImageCachingTask(),
        const MermaidConverterTask(),
      ],
    );
    final data = await pipeline.run(markdownFile);

    await AssetService.instance.saveReferences(data);

    return data;
  }

  static void _unsubscribe() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }

    _subscriptions.clear();
  }

  void listen({
    required void Function() onChange,
  }) {
    _unsubscribe();
    _subscriptions.addAll([
      sdConfig.slidesMarkdownFile,
      sdConfig.projectConfigFile,
    ].map((file) {
      return FileWatcher(file.path).events.listen(
        (event) {
          if (event.type == ChangeType.MODIFY) {
            onChange();
          }
        },
      );
    }).toList());
  }

  Future<DeckReferenceDto> loadFromStorage() async {
    if (kCanRunProcess) {
      return await generate();
    }

    return await AssetService.instance.loadReferences();
  }
}
