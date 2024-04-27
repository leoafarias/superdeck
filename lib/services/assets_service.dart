import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import '../helpers/config.dart';
import '../helpers/constants.dart';
import '../helpers/markdown_processor.dart';
import '../models/asset_model.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';

const assetService = AssetService.instance;

class AssetService {
  const AssetService._();

  static const instance = AssetService._();

  static final _refs = sdConfig.references;
  static final _imageDir = sdConfig.assetsImageDir;

  static Future<void> initialize() async {
    if (!await _imageDir.exists()) {
      await _imageDir.create(recursive: true);
    }
    if (!await _refs.slides.exists()) {
      await _refs.slides.writeAsString('[]');
    }
    if (!await _refs.config.exists()) {
      await _refs.config.create(recursive: true);
    }

    if (!await _refs.assets.exists()) {
      await _refs.assets.writeAsString('[]');
    }
  }

  static Future<String> loadString(String path) async {
    if (kCanRunProcess) {
      return File(path).readAsString();
    } else {
      return rootBundle.loadString(path);
    }
  }

  Future<DeckReferenceDto> loadReferences() async {
    final slides = await _loadSlides();
    final config = await _loadConfig();
    final assets = await loadAssets();

    return (slides: slides, config: config, assets: assets);
  }

  List<T> _parseList<T>(
      String contents, T Function(Map<String, dynamic>) fromMap) {
    final jsonList = jsonDecode(contents) as List;
    final mapList = List.castFrom<dynamic, Map<String, dynamic>>(jsonList);

    return mapList.map(fromMap).toList();
  }

  Future<List<Slide>> _loadSlides() async {
    final slidesJson = await AssetService.loadString(_refs.slides.path);
    return _parseList(slidesJson, Slide.fromMap);
  }

  Future<ProjectConfig> _loadConfig() async {
    final configJson = await AssetService.loadString(_refs.config.path);
    return ProjectConfig.fromJson(configJson);
  }

  Future<SlideAsset?> loadGeneratedAsset(String hash) async {
    final assets = await loadAssets();

    return assets
        .whereType<GeneratedAsset>()
        .firstWhereOrNull((e) => e.hash == hash);
  }

  Future<SlideAsset?> loadCachedAsset(String url) async {
    final assets = await loadAssets();

    return assets
        .whereType<CachedAsset>()
        .firstWhereOrNull((e) => e.hash == url.hashCode.toString());
  }

  Future<List<SlideAsset>> loadAssets() async {
    final assetsJson = await AssetService.loadString(_refs.assets.path);
    final assets = _parseList(assetsJson, SlideAsset.fromMap);

    final updatedAssets = <SlideAsset>[];

    for (final asset in assets) {
      final assetFile = File(asset.localPath);
      if (await assetFile.exists()) {
        updatedAssets.add(asset);
      }
    }

    return updatedAssets;
  }

  Future<void> saveReferences(DeckReferenceDto data) async {
    final config = data.config;
    final slides = data.slides;
    final assets = data.assets;
    await _refs.config.ensureWrite(config.toJson());
    final map = slides.map((e) => e.toMap()).toList();
    await _refs.slides.ensureWrite(jsonEncode(map));
    final assetRefs = assets.map((e) => e.toMap()).toList();
    await _refs.assets.writeAsString(jsonEncode(assetRefs));
  }

  Future<ProjectConfig> loadProjectConfig(File projectFile) async {
    return await projectFile.exists()
        ? ProjectConfig.fromYaml(await projectFile.readAsString())
        : const ProjectConfig.empty();
  }

  Future<GeneratedAsset> saveGeneratedAsset({
    required String hash,
    required Uint8List data,
  }) async {
    final file = File(
      p.join(
        sdConfig.assetsImageDir.path,
        '${SlideAsset.generatedPrefix}$hash.png',
      ),
    );

    file.writeAsBytesSync(data);

    final size = await _getImageSize(data);

    return GeneratedAsset(
      localPath: file.path,
      hash: hash,
      width: size.width,
      height: size.height,
    );
  }

  Future<CachedAsset> saveCachedAsset(String url) async {
    Uint8List assetData;
    String extension;
    if (!url.startsWith('http')) {
      final file = File(url);
      assetData = await file.readAsBytes();
      extension = file.path.split('.').last;
    } else {
      final client = HttpClient();
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();

      final contentType = response.headers.contentType;
      // Default to .jpg if no extension is found
      assetData = await consolidateHttpClientResponseBytes(response);
      extension = contentType?.subType ?? 'jpg';

      // Check if url has extension and is an image
    }
    if (!SlideAsset.allowedExtensions.contains(extension)) {
      throw Exception('Invalid file extension: $extension');
    }
    final file = File(
      p.join(
        sdConfig.assetsImageDir.path,
        '${SlideAsset.cachedPrefix}${url.hashCode}.$extension',
      ),
    );

    file.writeAsBytesSync(assetData);

    final size = await _getImageSize(assetData);

    return CachedAsset(
      uri: url,
      width: size.width,
      height: size.height,
      localPath: file.path,
    );
  }
}

extension on File {
  Future<void> ensureWrite(String content) async {
    if (!await exists()) {
      await create(recursive: true);
    }

    await writeAsString(content);
  }
}

Future<({double width, double height})> _getImageSize(Uint8List data) async {
  final codec = await ui.instantiateImageCodec(data);
  final frame = await codec.getNextFrame();
  return (
    width: frame.image.width.toDouble(),
    height: frame.image.height.toDouble(),
  );
}
