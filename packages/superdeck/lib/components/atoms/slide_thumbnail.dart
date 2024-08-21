import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:remix/remix.dart';
import 'package:signals/signals_flutter.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../helpers/constants.dart';
import '../../providers/controller.dart';
import '../../services/reference_service.dart';
import '../../services/snapshot_service.dart';
import 'cache_image_widget.dart';
import 'loading_indicator.dart';

class SlideThumbnail extends StatefulWidget {
  final VoidCallback onTap;
  final bool selected;
  final Slide slide;
  final int page;

  const SlideThumbnail({
    super.key,
    required this.selected,
    required this.onTap,
    required this.slide,
    required this.page,
  });

  @override
  State<SlideThumbnail> createState() => _SlideThumbnailState();
}

class _SlideThumbnailState extends State<SlideThumbnail> {
  late final thumbnailRequest = futureSignal(
    () => _generateThumbnail(widget.slide),
  );

  @override
  void didUpdateWidget(covariant SlideThumbnail oldWidget) {
    if (oldWidget.slide != widget.slide) {
      thumbnailRequest.refresh();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    thumbnailRequest.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final thumbnailContents = thumbnailRequest.build((value) {
      return value.map(
        data: (file) {
          return Image(
            gaplessPlayback: true,
            image: getImageProvider(file.path),
          );
        },
        loading: () => IsometricLoading(),
        error: (error, _) {
          return const Center(
            child: Text('Error loading image'),
          );
        },
      );
    });

    return GestureDetector(
      onTap: widget.onTap,
      child: _PreviewContainer(
        selected: widget.selected,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: kAspectRatio,
              child: thumbnailContents,
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: thumbnailRequest.build((value) {
                return SizedBox(
                  child: value.isRefreshing
                      ? const LinearProgressIndicator(
                          minHeight: 3,
                          backgroundColor: Colors.transparent,
                        )
                      : null,
                );
              }),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                color: Colors.black.withOpacity(0.9),
                child: Text(
                  '${widget.page}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewContainer extends StatelessWidget {
  final Widget child;
  final bool selected;

  const _PreviewContainer({
    required this.selected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style(
      $box.color.$neutral(2),
      $box.margin.all(8),
      $box.border.width(2),
      $box.shadow(
        blurRadius: 4,
        spreadRadius: 1,
      ),

      selected ? $box.wrap.scale(1.05) : $box.wrap.scale(1),
      selected ? $box.wrap.opacity(1) : $box.wrap.opacity(0.5),
      selected ? $box.border.color.$accent() : $box.border.color.transparent(),
      // $on.hover(
      //   $box.wrap.opacity(1),
      // ),
    ).animate();

    return Box(
      style: style,
      child: AspectRatio(aspectRatio: kAspectRatio, child: child),
    );
  }
}

Future<File> _generateThumbnail(Slide slide) async {
  final thumbnailFile =
      ReferenceService.instance.getAssetFile('thumbnail_${slide.key}.png');

  if (!kCanRunProcess || await thumbnailFile.exists()) {
    return thumbnailFile;
  }

  final imageData = await SnapshotService.instance.generate(
    quality: SnapshotQuality.low,
    slide: slide,
  );

  await thumbnailFile.writeAsBytes(imageData);

  return thumbnailFile;
}
