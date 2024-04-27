import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../helpers/config.dart';

part 'asset_model.mapper.dart';

@MappableEnum()
enum AssetType {
  cached,
  generated,
}

@MappableClass(
  includeCustomMappers: [AssetFileBytesMapper()],
  discriminatorKey: 'type',
)
abstract class SlideAsset with SlideAssetMappable {
  final double width;
  final double height;
  final String hash;
  final String localPath;
  final AssetType type;

  @MappableConstructor()
  const SlideAsset({
    required this.width,
    required this.height,
    required this.localPath,
    required this.hash,
    required this.type,
  });

  static const fromMap = SlideAssetMapper.fromMap;
  static const fromJson = SlideAssetMapper.fromJson;

  String get extension => localPath.split('.').last;

  String get relativePath => p.relative(
        localPath,
        from: sdConfig.assetsDir.parent.path,
      );

  String get name {
    // Get name without extnesion and remove prefix
    final fileName = localPath.split('/').last.split('.').first;
    // remove asset prefix
    return fileName.startsWith(SlideAsset.cachedPrefix)
        ? fileName.substring(SlideAsset.cachedPrefix.length)
        : fileName;
  }

  static const cachedPrefix = 'sd_cached';
  static const generatedPrefix = 'sd_generated';

  static const allowedExtensions = ['png', 'jpg', 'jpeg', 'gif', 'webp'];
}

@MappableClass(discriminatorValue: AssetType.generated)
class GeneratedAsset extends SlideAsset with GeneratedAssetMappable {
  @MappableConstructor()
  GeneratedAsset({
    required super.width,
    required super.height,
    required super.localPath,
    required super.hash,
  }) : super(type: AssetType.generated);
}

@MappableClass(discriminatorValue: AssetType.cached)
class CachedAsset extends SlideAsset with CachedAssetMappable {
  @MappableConstructor()
  CachedAsset({
    required String uri,
    required super.width,
    required super.height,
    required super.localPath,
  }) : super(hash: uri.hashCode.toString(), type: AssetType.cached);
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
