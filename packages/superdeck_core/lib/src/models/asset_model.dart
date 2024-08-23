part of 'models.dart';

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

  static const fromMap = SlideAssetMapper.fromMap;
  static const fromJson = SlideAssetMapper.fromJson;
}
