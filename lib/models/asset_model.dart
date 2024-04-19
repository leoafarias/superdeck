import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../helpers/config.dart';

part 'asset_model.mapper.dart';

@MappableClass(includeCustomMappers: [AssetFileBytesMapper()])
class SlideAsset with SlideAssetMappable {
  final AssetFileBytes _file;
  final double width;
  final double height;
  final String path;

  @MappableConstructor()
  const SlideAsset({
    required AssetFileBytes bytes,
    required this.width,
    required this.height,
    required this.path,
  }) : _file = bytes;

  Uint8List get bytes => _file.bytes;

  String get extension => path.split('.').last;

  String get relativePath => p.relative(
        path,
        from: kConfig.assetsDir.parent.path,
      );

  static Future<SlideAsset?> maybeLoad(File file) async {
    if (!await file.exists()) {
      return null;
    }
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();

    return SlideAsset(
      path: file.path,
      bytes: AssetFileBytes.fromBytes(bytes),
      width: frame.image.width.toDouble(),
      height: frame.image.height.toDouble(),
    );
  }

  static Future<SlideAsset> load(File file) async {
    final asset = await maybeLoad(file);
    return asset ?? (throw Exception('Invalid asset file: ${file.path}'));
  }

  static File buildFile(String fileName) {
    // Check file file contains an allowed extension
    final ext = p.extension(fileName).substring(1);
    if (!SlideAsset.allowedExtensions.contains(ext)) {
      throw Exception('Invalid file extension: $ext');
    }
    return File(
      p.join(
        kConfig.assetsImageDir.path,
        '${SlideAsset.assetPrefix}$fileName',
      ),
    );
  }

  String get name {
    // Get name without extnesion and remove prefix
    final fileName = path.split('/').last.split('.').first;
    // remove asset prefix
    return fileName.startsWith(SlideAsset.assetPrefix)
        ? fileName.substring(SlideAsset.assetPrefix.length)
        : fileName;
  }

  static const assetPrefix = 'sd_';

  static const allowedExtensions = ['png', 'jpg', 'jpeg', 'gif', 'webp'];

  static const fromMap = SlideAssetMapper.fromMap;
  static const fromJson = SlideAssetMapper.fromJson;
}

class AssetFileBytesMapper extends SimpleMapper<AssetFileBytes> {
  const AssetFileBytesMapper();

  @override
  AssetFileBytes decode(dynamic value) {
    return AssetFileBytes(value);
  }

  @override
  dynamic encode(AssetFileBytes self) {
    return self.base64;
  }
}

class AssetFileBytes {
  final Uint8List bytes;
  final String base64;

  AssetFileBytes._({
    required this.bytes,
    required this.base64,
  });

  factory AssetFileBytes(String base64) {
    return AssetFileBytes._(
      bytes: base64Decode(base64),
      base64: base64,
    );
  }

  factory AssetFileBytes.fromBytes(Uint8List bytes) {
    return AssetFileBytes._(
      bytes: bytes,
      base64: base64Encode(bytes),
    );
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AssetFileBytes && other.base64 == base64;
  }

  @override
  int get hashCode => base64.hashCode;
}
