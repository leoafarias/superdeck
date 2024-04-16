import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:yaml/yaml.dart';

import '../models/asset_model.dart';

Map<String, dynamic> converYamlToMap(String yamlString) {
  final yamlMap = loadYaml(yamlString) as YamlMap? ?? YamlMap();

  final yaml = jsonEncode(yamlMap);

  return jsonDecode(yaml);
}

/// Formats [json]
String prettyJson(dynamic json) {
  var spaces = ' ' * 2;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}

ImageProvider getImageProvider(String url, List<SlideAsset> assets) {
  ImageProvider provider;

  //  check if its a local path or a network path
  if (url.startsWith('http')) {
    provider = CachedNetworkImageProvider(url);
  } else {
    final asset = assets.firstWhereOrNull(
      (element) => element.path == url,
    );

    if (asset != null) {
      provider = MemoryImage(asset.bytes);
    } else {
      provider = AssetImage(url);
    }
  }
  return provider;
}
