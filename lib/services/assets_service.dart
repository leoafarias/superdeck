import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../helpers/config.dart';
import '../helpers/constants.dart';
import '../helpers/extensions.dart';
import '../superdeck.dart';

class AssetService {
  const AssetService._();

  static const instance = AssetService._();

  Future<String> loadString(String path) async {
    if (kCanRunProcess) {
      return File(path).readAsString();
    } else {
      return rootBundle.loadString(path);
    }
  }

  Future<Uint8List> loadBytes(String path) async {
    if (kCanRunProcess) {
      return File(path).readAsBytes();
    } else {
      return (await rootBundle.load(path)).buffer.asUint8List();
    }
  }

  List<T> _parseList<T>(
      String contents, T Function(Map<String, dynamic>) fromMap) {
    final jsonList = jsonDecode(contents) as List;
    final mapList = List.castFrom<dynamic, Map<String, dynamic>>(jsonList);

    return mapList.map(fromMap).toList();
  }

  Future<List<Slide>> loadSlidesReference() async {
    final slidesJson = await loadString(kProjectRefs.slideRef.path);
    return _parseList(slidesJson, Slide.fromMap);
  }

  Future<SDConfig> loadConfigReference() async {
    final configJson = await loadString(kProjectRefs.configRef.path);
    return SDConfig.fromJson(configJson);
  }

  Future<void> saveConfigReference(SDConfig config) async {
    await kProjectRefs.configRef.ensureWrite(config.toJson());
  }

  Future<void> saveSlidesReference(List<Slide> slides) async {
    final map = slides.map((e) => e.toMap()).toList();
    await kProjectRefs.slideRef.ensureWrite(jsonEncode(map));
  }

  Future<void> saveAssetsReference(List<File> files) async {
    final assets = await _convertToAssets(files);
    final map = assets.map((e) => e.toMap()).toList();
    await kProjectRefs.assetsRef.ensureWrite(jsonEncode(map));
  }

  Future<List<SlideAsset>> loadAssetsReference() async {
    final assetJson = await loadString(kProjectRefs.assetsRef.path);
    return _parseList(assetJson, SlideAsset.fromMap);
  }

  Future<List<File>> loadGeneratedAssets() async {
    final files = <File>[];
    await for (var entity in kProjectRefs.generatedAssetsDir.list()) {
      if (entity is File) {
        files.add(entity);
      }
    }

    return files;
  }

  Future<List<SlideAsset>> _convertToAssets(List<File> assetFiles) async {
    final assets = <SlideAsset>[];

    for (var file in assetFiles) {
      if (SlideAsset.isFileAsset(file)) {
        assets.add(
          await SlideAsset.fromFile(file),
        );
      }
    }

    return assets;
  }
}
