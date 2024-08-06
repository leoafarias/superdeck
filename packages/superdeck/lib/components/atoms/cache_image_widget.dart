import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../superdeck.dart';

class CacheImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final ImageSpec spec;
  final Alignment? alignment;

  const CacheImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.spec = const ImageSpec(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedImageSpecWidget(
      image: getImageProvider(
        url: url,
      ),
      spec: spec.copyWith(
        fit: fit,
        alignment: alignment,
      ),
    );
  }
}

({int? width, int? height}) calculateImageSize(Size size, SlideAsset? asset) {
  int? cacheWidth;
  int? cacheHeight;
  //  check if height or asset is larger
  if (asset != null) {
    // cache the smallest dimension of the image
    // So set the other dimension to null
    if (asset.isPortrait) {
      cacheHeight = min(size.height, asset.height).toInt();
    } else {
      cacheWidth = min(size.width, asset.width).toInt();
    }
  } else {
    // If no asset is available, set both cacheWidth and cacheHeight
    final ifHeightIsBigger = size.height > size.width;

// cache the smallest
    if (ifHeightIsBigger) {
      cacheWidth = size.width.toInt();
    } else {
      cacheHeight = size.height.toInt();
    }
  }

  return (width: cacheWidth, height: cacheHeight);
}

ImageProvider getImageProvider({
  required String url,
}) {
  ImageProvider provider;

  final assets = $superdeck.assets;

  final assetUrl = assets.firstWhereOrNull((e) => e.path == url);

  url = assetUrl?.path ?? url;

  //  check if its a local path or a network path
  if (url.startsWith('http')) {
    provider = CachedNetworkImageProvider(url);
  } else {
    if (kCanRunProcess) {
      final file = File(url);
      provider = FileImage(file);
    } else {
      provider = AssetImage(url);
    }
  }

  final (:width, :height) = calculateImageSize(kResolution, assetUrl);

  return ResizeImage.resizeIfNeeded(
    width,
    height,
    provider,
  );
}
