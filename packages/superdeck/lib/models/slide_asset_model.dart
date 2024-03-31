import 'package:dart_mappable/dart_mappable.dart';

part 'slide_asset_model.mapper.dart';

@MappableClass()
class SlideAsset with SlideAssetMappable {
  final String name;
  final String base64;

  const SlideAsset({
    required this.name,
    required this.base64,
  });

  static const fromMap = SlideAssetMapper.fromMap;
  static const fromJson = SlideAssetMapper.fromJson;
}
