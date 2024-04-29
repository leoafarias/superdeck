import 'dart:async';

import 'package:watcher/watcher.dart';

import '../helpers/config.dart';
import '../helpers/constants.dart';
import '../helpers/extensions.dart';
import '../models/asset_model.dart';
import '../models/slide_model.dart';
import '../services/assets_service.dart';
import 'slide_parser.dart';
import 'slides_pipeline.dart';

class SlidesLoader {
  SlidesLoader._();

  static final instance = SlidesLoader._();

  final _assetService = AssetService.instance;

  StreamSubscription<WatchEvent>? _listenerSub;

  Future<void> _ensureFiles() async {
    await kProjectRefs.assetsDir.ensureExists();
    await kProjectRefs.generatedAssetsDir.ensureExists();
    await kProjectRefs.markdownFile.ensureExists();

    try {
      await _assetService.loadAssetsReference();
    } on Exception {
      await _assetService.saveAssetsReference([]);
    }

    try {
      await _assetService.loadConfigReference();
    } on Exception {
      await _assetService.saveConfigReference(const SDConfig.empty());
    }

    try {
      await _assetService.loadSlidesReference();
    } on Exception {
      await _assetService.saveSlidesReference([]);
    }
  }

  Future<void> generate() async {
    await _ensureFiles();
    try {
      await _assetService.loadAssetsReference();
    } on Exception {
      await _assetService.saveAssetsReference([]);
    }

    final presentationRaw = await kProjectRefs.markdownFile.readAsString();

    final config = await _assetService.loadConfigReference();

    final slideParser = SlideParser(config: config);

    final slides = slideParser.run(presentationRaw);
    final files = await _assetService.loadGeneratedAssets();

    final pipeline = SlidesPipeline(
      [
        // const ImageCachingTask(),
        const MermaidConverterTask(),
        const SlideThumbnailTask(),
        const ImageCachingTask(),
      ],
    );

    final result = await pipeline.run(slides, files);

    for (var file in files) {
      if (!result.neededAssets.any((element) => element.path == file.path)) {
        await file.delete();
      }
    }

    await _assetService.saveConfigReference(config);
    await _assetService.saveSlidesReference(result.slides);

    await _assetService.saveAssetsReference(result.neededAssets);
  }

  void listen(
    FutureOr<void> Function() onChange,
  ) {
    _listenerSub?.cancel();

    final watcher = FileWatcher(kProjectRefs.markdownFile.path);
    _listenerSub = watcher.events.listen((_) => onChange());
  }

  Future<
      ({
        Config config,
        List<Slide> slides,
        List<SlideAsset> assets,
      })> loadFromStorage() async {
    if (kCanRunProcess) {
      await generate();
    }
    final slides = await _assetService.loadSlidesReference();
    final config = await _assetService.loadConfigReference();
    final assets = await _assetService.loadAssetsReference();

    return (
      config: config,
      slides: slides,
      assets: assets,
    );
  }
}
