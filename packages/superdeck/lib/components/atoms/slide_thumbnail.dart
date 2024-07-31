import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../services/snapshot_service.dart';
import '../../superdeck.dart';
import '../molecules/scaled_app.dart';
import 'cache_image_widget.dart';
import 'loading_indicator.dart';
import 'slide_view.dart';

final _previewStyle = AnimatedStyle(
  Style(
    $box.color.grey.shade900(),
    $box.margin.all(8),
    $box.border.all.width(2),
    $box.shadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 4,
      spreadRadius: 1,
    ),
  ),
  duration: const Duration(milliseconds: 300),
  curve: Curves.ease,
);

// ignore: non_constant_identifier_names
final PreviewBox = _previewStyle.box;

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
  late final imageGenerator = SnapshotService.instance;
  late File _thumbnailFile = File('');

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
      _thumbnailFile = File('');
      _thumbnailLoader.refresh();
    }
  }

  String _getLocalAsset() {
    return _thumbnailFile.path;
  }

  Future<String> _generateThumbnail() async {
    if (await _thumbnailFile.exists()) {
      return _getLocalAsset();
    }

    final imageData = await imageGenerator.generate(
      // ignore: use_build_context_synchronously
      quality: SnapshotQuality.low,
      slide: widget.slide,
    );

    await _thumbnailFile.writeAsBytes(imageData);

    return _getLocalAsset();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final selectedColor = widget.selected ? Colors.blue : Colors.transparent;

      final result = _thumbnailLoader.watch(context);

      final child = LoadingOverlay(
        isLoading: result.isLoading,
        child: result.map(
          data: (path) {
            return Image(
              image: getImageProvider(
                context: context,
                url: path,
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
        child: PreviewBox(
          style: Style(
            $box.border.all.color(selectedColor),
          ),
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

class SlideThumbnailDynamic extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final int index;
  final Slide slide;

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
      child: PreviewBox(
        style: Style(
          $box.border.all.color(selectedColor),
        ),
        child: AbsorbPointer(
          child: AspectRatio(
              aspectRatio: kAspectRatio,
              child: ScaledWidget(
                child: SlideView(
                  slide,
                ),
              )),
        ),
      ),
    );
  }
}
