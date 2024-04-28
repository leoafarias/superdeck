import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../superdeck.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final ImageSpec spec;
  final Alignment? alignment;
  final Size size;

  const CachedImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.spec = const ImageSpec.empty(),
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final assets = SuperDeckProvider.instance.assets.watch(context);

    final asset =
        assets.firstWhereOrNull((a) => a.hash == url.hashCode.toString());

    final (:width, :height) = _calculateImageSize(size, asset);

    final imageProvider =
        ResizeImage.resizeIfNeeded(width, height, getImageProvider(url, size));

    return AnimatedMixedImage(
      image: imageProvider,
      spec: spec.copyWith(
        fit: fit,
        alignment: alignment,
      ),
    );
  }
}

({int? width, int? height}) _calculateImageSize(Size size, SlideAsset? asset) {
  int? cacheWidth;
  int? cacheHeight;
  //  check if height or asset is larger
  if (asset != null) {
    final portrait = asset.height > asset.width;

    // cache the smallest dimension of the image
    // So set the other dimension to null
    if (portrait) {
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

ImageProvider getImageProvider(String url, Size canvasSize) {
  ImageProvider provider;

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

  return provider;
}
