import 'package:dart_mappable/dart_mappable.dart';
import 'package:path/path.dart' as p;

import '../helpers/config.dart';

part 'asset_model.mapper.dart';

@MappableClass(
  discriminatorKey: 'type',
)
abstract class SlideAsset with SlideAssetMappable {
  final double width;
  final double height;
  final String hash;
  final String localPath;
  final String type;

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

  static const cachedPrefix = 'sd_cached_';
  static const generatedPrefix = 'sd_generated_';
  static const thumbnailPrefix = 'sd_thumb_';

  static const allowedExtensions = ['png', 'jpg', 'jpeg', 'gif', 'webp'];
}

@MappableClass(discriminatorValue: 'generated')
class GeneratedAsset extends SlideAsset with GeneratedAssetMappable {
  @MappableConstructor()
  GeneratedAsset({
    required super.width,
    required super.height,
    required super.localPath,
    required super.hash,
  }) : super(type: 'generated');
}

@MappableClass(discriminatorValue: 'cached')
class CachedAsset extends SlideAsset with CachedAssetMappable {
  CachedAsset({
    required super.hash,
    required super.width,
    required super.height,
    required super.localPath,
  }) : super(type: 'cached');
}

@MappableClass(discriminatorValue: 'thumbnail')
class ThumbnailAsset extends SlideAsset with ThumbnailAssetMappable {
  ThumbnailAsset({
    required super.hash,
    required super.width,
    required super.height,
    required super.localPath,
  }) : super(type: 'thumbnail');
}
