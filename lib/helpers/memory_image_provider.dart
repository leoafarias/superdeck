import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class CachedMemoryImage extends StatelessWidget {
  final String base64Image;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CachedMemoryImage({
    Key? key,
    required this.base64Image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uint8List bytes = base64Decode(base64Image);
    final MemoryImage memoryImage = MemoryImage(bytes);

    return Image(
      image: memoryImage,
      width: width,
      height: height,
      fit: fit,
      key: ValueKey(base64Image),
      gaplessPlayback: true,
    );
  }
}
