import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import '../helpers/mappers.dart';
import '../helpers/utils.dart';
import '../services/project_service.dart';
import 'slide_model.dart';

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

  static AssetFileType? tryParse(String value) {
    return values.firstWhereOrNull((e) => value.startsWith(e.name));
  }

  bool isPng() => this == AssetFileType.png;

  bool isJpg() => this == AssetFileType.jpg || this == AssetFileType.jpeg;

  bool isGif() => this == AssetFileType.gif;
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

  static SlideAssetType? tryParse(String value) {
    return values.firstWhereOrNull((e) => value.startsWith(e.name));
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

  String get extension => p.extension(file.path);

  bool get isPortrait => dimensions.height > dimensions.width;

  bool get isLandscape => !isPortrait;

  static File thumbnail(Slide slide) {
    return ProjectService.instance.buildAssetFile(
      '${slide.hashKey}.png',
      SlideAssetType.thumb,
    );
  }

  static File cached(String uri) {
    return ProjectService.instance.buildAssetFile(
      '${shortHashId(uri)}.png',
      SlideAssetType.cached,
    );
  }

  static File mermaid(String mermaidSyntax) {
    return ProjectService.instance.buildAssetFile(
      '${shortHashId(mermaidSyntax)}.png',
      SlideAssetType.mermaid,
    );
  }

  static const fromMap = SlideAssetMapper.fromMap;
  static const fromJson = SlideAssetMapper.fromJson;
}
