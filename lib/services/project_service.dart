import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:watcher/watcher.dart';

import '../helpers/constants.dart';
import '../helpers/extensions.dart';
import '../models/config_model.dart';
import '../superdeck.dart';

typedef DeckReferences = ({
  SDConfig config,
  List<Slide> slides,
  List<SlideAsset> assets,
});

class ProjectService {
  ProjectService._();

  static final instance = ProjectService._();

  File get markdownFile => File('slides.md');

  Directory get assetsDir => Directory(p.join('superdeck'));

  Directory get generatedAssetsDir =>
      Directory(p.join(assetsDir.path, 'generated'));
  File get projectConfigFile => File('superdeck.yaml');

  File get slideRef => File(p.join(assetsDir.path, 'slides.json'));
  File get configRef => File(p.join(assetsDir.path, 'config.json'));
  File get assetsRef => File(p.join(assetsDir.path, 'assets.json'));

  late final watcher = FileWatcher(markdownFile.path);

  Future<void> ensureExists() async {
    await assetsDir.ensureExists();
    await generatedAssetsDir.ensureExists();
    await markdownFile.ensureExists();

    if (!await slideRef.exists()) {
      await slideRef.ensureWrite('[]');
    }

    if (!await configRef.exists()) {
      await configRef.ensureWrite(const SDConfig.empty().toJson());
    }

    if (!await assetsRef.exists()) {
      await assetsRef.ensureWrite('[]');
    }
  }

  // String _getAssetRelativePath(String path) {
  //   return p.relative(
  //     path,
  //     from: _assetsRootDir.path,
  //   );
  // }

  Future<void> clearGeneratedDir() async {
    await generatedAssetsDir.delete(recursive: true);
    await generatedAssetsDir.ensureExists();
  }

  File buildAssetFile(String fileName, SlideAssetType type) {
    if (p.extension(fileName).isEmpty) {
      throw Exception('File name must have an extension');
    }
    final updatedFileName = ('${type.name}_$fileName');
    return File(p.join(generatedAssetsDir.path, updatedFileName));
  }

  SlideAssetType? getAssetTypeOfFile(File file) {
    // check if filename starts with prefix

    return SlideAssetType.tryParse(p.basenameWithoutExtension(file.path));
  }

  Future<SlideAsset> getSlideAssetFromFile(File file) async {
    final data = await file.readAsBytes();
    final size = await _getImageSize(data);

    return SlideAsset(
      file: file,
      dimensions: size,
    );
  }

  Future<String> loadString(String path) async {
    if (kCanRunProcess) {
      return File(path).readAsString();
    } else {
      return rootBundle.loadString(path);
    }
  }

  Future<DeckReferences> loadDeck() async {
    return (
      slides: await _loadSlidesRef(),
      config: await _loadConfigRef(),
      assets: await _loadAssetsRef(),
    );
  }

  Future<List<Slide>> _loadSlidesRef() async {
    try {
      final slidesJson = await loadString(slideRef.path);
      return _parseList(slidesJson, Slide.fromMap);
    } on Exception catch (err) {
      log('Error loading ${slideRef.path}: $err');
      return [];
    }
  }

  Future<SDConfig> _loadConfigRef() async {
    try {
      final configJson = await loadString(configRef.path);
      return SDConfig.fromJson(configJson);
    } on Exception catch (err) {
      log('Error loading ${configRef.path}: $err');
      return const SDConfig.empty();
    }
  }

  Future<List<SlideAsset>> _loadAssetsRef() async {
    try {
      final assetJson = await loadString(assetsRef.path);
      return _parseList(assetJson, SlideAsset.fromMap);
    } on Exception catch (err) {
      log('Error loading ${assetsRef.path}: $err');
      return [];
    }
  }

  Future<String> loadMarkdown() async {
    try {
      return await loadString(markdownFile.path);
    } on Exception catch (err) {
      log('Error loading ${markdownFile.path}: $err');
      return '';
    }
  }

  Future<void> saveConfigRef(SDConfig config) async {
    await configRef.ensureWrite(config.toJson());
  }

  Future<void> saveSlidesRef(List<Slide> slides) async {
    final map = slides.map((e) => e.toMap()).toList();
    await slideRef.ensureWrite(jsonEncode(map));
  }

  Future<void> saveAssetsRef(List<File> files) async {
    final assets = await _convertToAssets(files);
    final map = assets.map((e) => e.toMap()).toList();
    await assetsRef.ensureWrite(jsonEncode(map));
  }

  Future<List<File>> loadGeneratedFiles() async {
    final files = <File>[];

    await for (var entity in generatedAssetsDir.list()) {
      if (entity is File) {
        files.add(entity);
      }
    }

    return files;
  }

  bool isAssetFile(File file) => getAssetTypeOfFile(file) != null;

  Future<List<SlideAsset>> _convertToAssets(List<File> assetFiles) async {
    final assets = <SlideAsset>[];

    for (var file in assetFiles) {
      if (isAssetFile(file)) {
        assets.add(
          await getSlideAssetFromFile(file),
        );
      }
    }

    return assets;
  }
}

List<T> _parseList<T>(
    String contents, T Function(Map<String, dynamic>) fromMap) {
  final jsonList = jsonDecode(contents) as List;
  final mapList = List.castFrom<dynamic, Map<String, dynamic>>(jsonList);

  return mapList.map(fromMap).toList();
}

Future<Size> _getImageSize(Uint8List data) async {
  final codec = await ui.instantiateImageCodec(data);
  final frame = await codec.getNextFrame();
  return Size(
    frame.image.width.toDouble(),
    frame.image.height.toDouble(),
  );
}
