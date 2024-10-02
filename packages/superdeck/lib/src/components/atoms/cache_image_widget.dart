import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../modules/common/helpers/constants.dart';
import '../../modules/common/helpers/measure_size.dart';

ImageProvider getImageProvider(Uri uri) {
  switch (uri.scheme) {
    case 'http':
    case 'https':
      return CachedNetworkImageProvider(uri.toString());
    default:
      if (kCanRunProcess) {
        return FileImage(File.fromUri(uri));
      } else {
        return AssetImage(uri.path);
      }
  }
}

class CachedImage extends StatefulWidget {
  final Uri uri;
  final BoxFit? fit;
  final ImageSpec spec;
  final Alignment? alignment;

  const CachedImage({
    super.key,
    required this.uri,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.spec = const ImageSpec(),
  });

  @override
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  Size? imageSize;
  late final ImageProvider<Object> imageProvider;

  ImageStream? _imageStream;
  late final ImageStreamListener _imageStreamListener;

  @override
  void initState() {
    super.initState();
    imageProvider = getImageProvider(widget.uri);
    _getImageSize(imageProvider);
  }

  void _getImageSize(ImageProvider imageProvider) {
    _imageStream = imageProvider.resolve(const ImageConfiguration());
    _imageStreamListener = ImageStreamListener(
      (ImageInfo info, bool synchronousCall) {
        final myImage = info.image;
        imageSize = Size(
          myImage.width.toDouble(),
          myImage.height.toDouble(),
        );
        if (mounted && !synchronousCall) {
          setState(() {});
        }
      },
      onError: (error, stackTrace) {
        log('Error loading image: $error');
      },
    );
    _imageStream!.addListener(_imageStreamListener);
  }

  @override
  void dispose() {
    if (_imageStream != null) {
      _imageStream!.removeListener(_imageStreamListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MeasureSizeBuilder(
      builder: (size) {
        final imageSize = this.imageSize;
        final isReady = imageSize != null && size != null;

        if (!isReady) {
          return Container(
            constraints: BoxConstraints.loose(kResolution),
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        // Compute the aspect ratio to fit the image within the container
        final widthScale = size.width / imageSize.width;
        final heightScale = size.height / imageSize.height;
        final scale = widthScale < heightScale ? widthScale : heightScale;

        final finalSize = Size(
          imageSize.width * scale,
          imageSize.height * scale,
        );
        // Now that we have the final size, we can display the resized image
        return AnimatedImageSpecWidget(
          image: imageProvider,
          spec: widget.spec.copyWith(
            fit: widget.fit,
            alignment: widget.alignment,
          ),
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return Container(
              constraints: BoxConstraints.loose(finalSize),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.red,
              child: Center(
                child: Text('Error loading image: ${widget.uri}'),
              ),
            );
          },
        );
      },
    );
  }
}

// Size _calculateImageSize(Size size, SlideAsset? asset) {
//   int? cacheWidth;
//   int? cacheHeight;
//   //  check if height or asset is larger
//   if (asset != null) {
//     // cache the smallest dimension of the image
//     // So set the other dimension to null
//     if (asset.isPortrait) {
//       cacheHeight = math.min(size.height, asset.height).toInt();
//     } else {
//       cacheWidth = math.min(size.width, asset.width).toInt();
//     }
//   } else {
//     // If no asset is available, set both cacheWidth and cacheHeight
//     final ifHeightIsBigger = size.height > size.width;

// // cache the smallest
//     if (ifHeightIsBigger) {
//       cacheWidth = size.width.toInt();
//     } else {
//       cacheHeight = size.height.toInt();
//     }
//   }

//   return Size(
//     cacheWidth?.toDouble() ?? size.width,
//     cacheHeight?.toDouble() ?? size.height,
//   );
// }
