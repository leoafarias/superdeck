import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:watcher/watcher.dart';

import '../helpers/constants.dart';
import '../models/config_model.dart';
import '../models/deck_reference_model.dart';
import '../superdeck.dart';

class ProjectService {
  ProjectService._();

  static final instance = ProjectService._();

  File get markdownFile => File('slides.md');

  Directory get assetsDir => Directory(p.join('superdeck'));

  Directory get generatedAssetsDir =>
      Directory(p.join(assetsDir.path, 'generated'));
  File get projectConfigFile => File('superdeck.yaml');

  File get slideRef => File(p.join(assetsDir.path, 'slides.json'));

  late final watcher = FileWatcher(markdownFile.path);

  Future<String> loadString(String path) async {
    if (kCanRunProcess) {
      return File(path).readAsString();
    } else {
      return rootBundle.loadString(path);
    }
  }

  Future<DeckReference> loadDeck() async {
    final slidesJson = await loadString(slideRef.path);
    try {
      return compute(DeckReference.fromJson, slidesJson);
    } catch (e) {
      log('Error loading deck: $e');
      return DeckReference(
        assets: [],
        slides: [],
        config: const Config.empty(),
      );
    }
  }
}

bool isAssetFile(File file) => _getAssetTypeOfFile(file) != null;

Future<List<SlideAsset>> convertToAssets(List<File> assetFiles) async {
  final assets = <Future<SlideAsset>>[];

  for (var file in assetFiles) {
    if (isAssetFile(file)) {
      assets.add(
        _getSlideAssetFromFile(file),
      );
    }
  }

  return await Future.wait(assets);
}

Future<SlideAsset> _getSlideAssetFromFile(File file) async {
  final data = await file.readAsBytes();
  final size = await _getImageSize(data);

  return SlideAsset(
    file: file,
    dimensions: size,
  );
}

Future<Size> _getImageSize(Uint8List data) async {
  final codec = await ui.instantiateImageCodec(data);
  final frame = await codec.getNextFrame();
  return Size(
    frame.image.width.toDouble(),
    frame.image.height.toDouble(),
  );
}

SlideAssetType? _getAssetTypeOfFile(File file) {
  // check if filename starts with prefix

  return SlideAssetType.tryParse(p.basenameWithoutExtension(file.path));
}
