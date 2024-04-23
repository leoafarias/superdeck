import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../helpers/constants.dart';

class CachedImage extends StatelessWidget {
  final ImageSpec spec;
  final String url;

  const CachedImage({
    required this.spec,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = getImageProvider(url);

    return AnimatedMixedImage(
      image: imageProvider,
      spec: spec,
    );
  }
}

ImageProvider getImageProvider(String url) {
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
