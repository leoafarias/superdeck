import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../services/reference_service.dart';
import '../../services/snapshot_service.dart';
import '../../superdeck.dart';
import '../molecules/scaled_app.dart';
import 'cache_image_widget.dart';
import 'loading_indicator.dart';
import 'slide_view.dart';

class SlideThumbnail extends StatefulWidget {
  final bool selected;
  final VoidCallback onTap;
  final int index;
  final Slide slide;

  const SlideThumbnail({
    super.key,
    required this.selected,
    required this.index,
    required this.onTap,
    required this.slide,
  });

  @override
  State<SlideThumbnail> createState() => _SlideThumbnailState();
}

class _SlideThumbnailState extends State<SlideThumbnail> {
  final snapshotService = SnapshotService.instance;
  final referenceService = ReferenceService.instance;

  late final _thumbnailLoader = futureSignal(() {
    return kCanRunProcess
        ? _generateThumbnail()
        : Future.value(_getLocalAsset());
  });

  @override
  void dispose() {
    super.dispose();

    _thumbnailLoader.dispose();
  }

  @override
  void didUpdateWidget(SlideThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide.key != widget.slide.key) {
      _thumbnailLoader.refresh();
    }
  }

  File _getLocalAsset() {
    return referenceService.getAssetFile('thumbnail_${widget.slide.key}.png');
  }

  Future<File> _generateThumbnail() async {
    final thumbnailFile = _getLocalAsset();
    if (await thumbnailFile.exists()) {
      return thumbnailFile;
    }

    final imageData = await snapshotService.generate(
      // ignore: use_build_context_synchronously
      quality: SnapshotQuality.low,
      slide: widget.slide,
    );

    await thumbnailFile.writeAsBytes(imageData);

    return thumbnailFile;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final selectedColor = widget.selected ? Colors.blue : Colors.transparent;

      final result = _thumbnailLoader.watch(context);

      final child = LoadingOverlay(
        isLoading: result.isLoading,
        child: result.map(
          data: (file) {
            return Image(
              image: getImageProvider(
                context: context,
                url: file.path,
                targetSize: constraints.biggest,
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
        onTap: widget.onTap,
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
                      child: result.isRefreshing
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
                        '${widget.index + 1}',
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
              child: SlideView(
                slide,
              ),
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
