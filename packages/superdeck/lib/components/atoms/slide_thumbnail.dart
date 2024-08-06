import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../helpers/constants.dart';
import '../../helpers/extensions.dart';
import '../../services/reference_service.dart';
import '../../services/snapshot_service.dart';
import '../../superdeck.dart';
import '../molecules/scaled_app.dart';
import 'cache_image_widget.dart';
import 'loading_indicator.dart';
import 'slide_view.dart';

class SlideThumbnail extends HookWidget {
  final VoidCallback onTap;
  final int index;
  final Slide slide;

  const SlideThumbnail({
    super.key,
    required this.index,
    required this.onTap,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    final navigation = useNavigation();

    final processThumbnail = useFuture(
      useMemoized(() => _generateThumbnail(slide), [slide]),
    );
    return LayoutBuilder(builder: (context, constraints) {
      final selectedColor =
          index == navigation.page ? Colors.blue : Colors.transparent;

      final child = LoadingOverlay(
        isLoading: processThumbnail.isLoading,
        child: processThumbnail.when(
          data: (file) {
            return Image(
              gaplessPlayback: true,
              image: getImageProvider(
                url: file.path,
              ),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (error, _) {
            return const Center(
              child: Text('Error loading image'),
            );
          },
        ),
      );

      return GestureDetector(
        onTap: onTap,
        child: _PreviewContainer(
          selectedColor: selectedColor,
          child: AbsorbPointer(
            child: AspectRatio(
              aspectRatio: kAspectRatio,
              child: Stack(
                children: [
                  child,
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
                      margin: const EdgeInsets.all(1),
                      color: Colors.black.withOpacity(0.5),
                      child: Text(
                        '${index + 1}',
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
        ),
      );
    });
  }
}

class SlideThumbnailDynamic<T extends Slide> extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final int index;
  final T slide;

  const SlideThumbnailDynamic({
    super.key,
    required this.selected,
    required this.index,
    required this.onTap,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = selected ? Colors.blue : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: _PreviewContainer(
        selectedColor: selectedColor,
        child: AbsorbPointer(
          child: AspectRatio(
            aspectRatio: kAspectRatio,
            child: ScaledWidget(
              child: SlideView(slide),
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewContainer extends StatelessWidget {
  final Color selectedColor;
  final Widget child;

  const _PreviewContainer({
    required this.selectedColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style(
      $box.color.grey.shade900(),
      $box.margin.all(8),
      $box.border.width(2),
      $box.shadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 4,
        spreadRadius: 1,
      ),
    );

    return Box(
      style: style.add(
        $box.border.color(selectedColor),
      ),
      child: child,
    );
  }
}

Future<File> _generateThumbnail(Slide slide) async {
  final thumbnailFile =
      ReferenceService.instance.getAssetFile('thumbnail_${slide.key}.png');
  if (!kCanRunProcess) {
    return thumbnailFile;
  }
  if (await thumbnailFile.exists()) {
    return thumbnailFile;
  }

  final imageData = await SnapshotService.instance.generate(
    // ignore: use_build_context_synchronously
    quality: SnapshotQuality.low,
    slide: slide,
  );

  await thumbnailFile.writeAsBytes(imageData);

  return thumbnailFile;
}
