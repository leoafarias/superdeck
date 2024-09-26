import 'package:dart_mappable/dart_mappable.dart';
import 'package:path/path.dart' as p;

part 'asset_model.mapper.dart';

@MappableClass()
final class SlideAsset with SlideAssetMappable {
  final String path;
  final int width;
  final int height;
  final String? reference;

  SlideAsset({
    required this.path,
    required this.width,
    required this.height,
    required this.reference,
  });

  String get extension => p.extension(path);

  bool get isPortrait => height >= width;

  bool get isLandscape => !isPortrait;

  bool matches(String url) {
    return path == url || reference == url;
  }

  static const fromMap = SlideAssetMapper.fromMap;
  static const fromJson = SlideAssetMapper.fromJson;
}
