import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';

part 'slide_asset_model.mapper.dart';

@MappableClass(includeCustomMappers: [Uint8ListMapper()])
class SlideAsset with SlideAssetMappable {
  final Uint8List bytes;
  final double width;
  final double height;
  final String path;

  const SlideAsset({
    required this.bytes,
    required this.width,
    required this.height,
    required this.path,
  });

  static const fromMap = SlideAssetMapper.fromMap;
  static const fromJson = SlideAssetMapper.fromJson;
}

class Uint8ListMapper extends SimpleMapper<Uint8List> {
  const Uint8ListMapper();

  @override
  Uint8List decode(dynamic value) {
    return base64Decode(value as String);
  }

  @override
  dynamic encode(Uint8List self) {
    return base64Encode(self);
  }
}
