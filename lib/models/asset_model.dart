import 'dart:io';
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import '../helpers/constants.dart';
import '../helpers/mappers.dart';

part 'asset_model.mapper.dart';

@MappableEnum()
enum AssetFileType {
  png,
  jpg,
  jpeg,
  gif,
  webp;

  static AssetFileType parse(String value) {
    return values.firstWhereOrNull((e) => e.name == value) ??
        (throw Exception('Invalid file type: $value'));
  }
}

@MappableEnum()
enum SlideAssetType {
  cached,
  thumb,
  mermaid;

  static SlideAssetType parse(String value) {
    return values.firstWhereOrNull((e) => e.name == value) ??
        (throw Exception('Invalid asset type: $value'));
  }
}

@MappableClass(
  includeCustomMappers: [
    FileMapper(),
    SizeMapper(),
  ],
)
final class SlideAsset with SlideAssetMappable {
  final File file;
  final Size dimensions;

  SlideAsset({
    required this.file,
    required this.dimensions,
  });

  static const prefix = 'sd';

  String get extension => p.extension(file.path);

  bool get isPortrait => dimensions.height > dimensions.width;

  bool get isLandscape => !isPortrait;

  static SlideAssetType? getType(File file) {
    // check if filename starts with prefix
    if (!p.basename(file.path).startsWith(prefix)) return null;

    final parts = p.basenameWithoutExtension(file.path).split('_');
    return SlideAssetType.parse(parts[1]);
  }

  static Future<SlideAsset> fromFile(File file) async {
    final data = await file.readAsBytes();
    final size = await _getImageSize(data);

    return SlideAsset(
      file: file,
      dimensions: size,
    );
  }

  static bool isPipeline(File file) => getType(file) == SlideAssetType.mermaid;

  static bool isFileAsset(File file) => getType(file) != null;

  static File _buildFile(String fileName, SlideAssetType type) {
    if (p.extension(fileName).isEmpty) {
      throw Exception('File name must have an extension');
    }
    final updatedFileName = ('${prefix}_${type.name}_$fileName');
    return File(p.join(kProjectRefs.generatedAssetsDir.path, updatedFileName));
  }

  static File thumbnail(String fileName) {
    return _buildFile(fileName, SlideAssetType.thumb);
  }

  static File cached(String fileName) {
    return _buildFile(fileName, SlideAssetType.cached);
  }

  static File mermaid(String fileName) {
    return _buildFile(fileName, SlideAssetType.mermaid);
  }

  static const fromMap = SlideAssetMapper.fromMap;
  static const fromJson = SlideAssetMapper.fromJson;
}

Future<Size> _getImageSize(Uint8List data) async {
  final codec = await ui.instantiateImageCodec(data);
  final frame = await codec.getNextFrame();
  return Size(
    frame.image.width.toDouble(),
    frame.image.height.toDouble(),
  );
}
