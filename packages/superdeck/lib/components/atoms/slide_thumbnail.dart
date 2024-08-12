import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remix/remix.dart';

import '../../helpers/constants.dart';
import '../../helpers/extensions.dart';
import '../../services/reference_service.dart';
import '../../services/snapshot_service.dart';
import '../../superdeck.dart';
import 'cache_image_widget.dart';
import 'loading_indicator.dart';

class SlideThumbnail extends HookWidget {
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
  Widget build(BuildContext context) {
    final processThumbnail = useFuture(
      useMemoized(() => _generateThumbnail(slide, context), [slide]),
    );
    return LayoutBuilder(builder: (context, constraints) {
      final child = processThumbnail.when(
        data: (file) {
          return Image(
            gaplessPlayback: true,
            image: getImageProvider(file.path),
          );
        },
        loading: () {
          return IsometricLoading();
        },
        error: (error, _) {
          return const Center(
            child: Text('Error loading image'),
          );
        },
      );

      return GestureDetector(
        onTap: onTap,
        child: _PreviewContainer(
          selected: selected,
          child: AspectRatio(
            aspectRatio: kAspectRatio,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: kAspectRatio,
                  child: child,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    child: processThumbnail.isRefreshing
                        ? const LinearProgressIndicator(
                            minHeight: 3,
                            backgroundColor: Colors.transparent,
                          )
                        : null,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    color: Colors.black.withOpacity(0.9),
                    child: Text(
                      '$page',
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
        ),
      );
    });
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
      child: child,
    );
  }
}

Future<File> _generateThumbnail(Slide slide, BuildContext context) async {
  final thumbnailFile =
      ReferenceService.instance.getAssetFile('thumbnail_${slide.key}.png');
  // if (!kCanRunProcess) {
  //   return thumbnailFile;
  // }
  // if (await thumbnailFile.exists()) {
  //   return thumbnailFile;
  // }

  final imageData = await SnapshotService.instance.generate(
    // ignore: use_build_context_synchronously
    quality: SnapshotQuality.low,
    slide: slide,
  );

  await thumbnailFile.writeAsBytes(imageData);

  return thumbnailFile;
}
