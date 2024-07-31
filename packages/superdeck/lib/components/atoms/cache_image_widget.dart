import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../services/project_service.dart';
import '../../superdeck.dart';

class CacheImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final ImageSpec spec;
  final Alignment? alignment;
  final Size size;

  const CacheImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.spec = const ImageSpec(),
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedImageSpecWidget(
      image: getImageProvider(
        context: context,
        url: url,
        targetSize: size,
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
      cacheHeight = min(size.height, asset.dimensions.height).toInt();
    } else {
      cacheWidth = min(size.width, asset.dimensions.width).toInt();
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
  required BuildContext context,
  required String url,
  required Size targetSize,
}) {
  ImageProvider provider;

  SlideAsset? asset;

  final assets = superdeckController.assets.watch(context);

  if (isAssetFile(File(url))) {
    asset = assets.firstWhereOrNull((e) => e.file.path == url);
  } else {
    asset = assets.firstWhereOrNull((e) => e.file.path.contains(url));
  }

  url = asset?.file.path ?? url;

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

  final (:width, :height) = calculateImageSize(targetSize, asset);

  return ResizeImage.resizeIfNeeded(
    width,
    height,
    provider,
  );
}
