import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';

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
