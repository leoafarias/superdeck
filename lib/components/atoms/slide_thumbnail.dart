import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../services/assets_service.dart';
import '../../services/image_generation_service.dart';
import '../../superdeck.dart';
import '../molecules/scaled_app.dart';
import 'slide_view.dart';

final _previewStyle = AnimatedStyle(
  Style(
    box.color.grey.shade900(),
    box.margin.all(8),
    box.border.all.width(2),
    box.shadow(
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
  late final imageGenerator = ImageGenerationService.instance;
  late final _thumbnailFile = SlideAsset.thumbnail('${widget.slide.hash}.png');
  bool _isDisposed = false;
  late final imageLoader = futureSignal(() {
    return kCanRunProcess ? _generateThumbnail() : _getLocalAsset();
  });

  static final _generationQueue = <String>{};
  static const _maxConcurrentGenerations = 3;

  @override
  void dispose() {
    super.dispose();
    imageLoader.dispose();
    _isDisposed = true;
  }

  @override
  void didUpdateWidget(SlideThumbnail oldWidget) {
    if (oldWidget.index != widget.index || oldWidget.slide != widget.slide) {
      imageLoader.refresh();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<Uint8List> _getLocalAsset() async {
    return AssetService.instance.loadBytes(_thumbnailFile.path);
  }

  Future<Uint8List> _generateThumbnail() async {
    if (await _thumbnailFile.exists()) {
      return _getLocalAsset();
    }

    // while (_generationQueue.length > _maxConcurrentGenerations) {
    //   await Future.delayed(const Duration(milliseconds: 100));
    // }
    try {
      // _generationQueue.add(widget.slide.hash);

      // if (_isDisposed) {
      //   return Uint8List(0);
      // }

      final imageData = await imageGenerator.generate(
        // ignore: use_build_context_synchronously
        quality: SnapshotQuality.low,
        slide: widget.slide,
      );

      await _thumbnailFile.writeAsBytes(imageData);

      return imageData;
    } finally {
      // _generationQueue.remove(widget.slide.hash);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final selectedColor = widget.selected ? Colors.blue : Colors.transparent;

      final result = imageLoader.watch(context);

      final child = result.map(
        data: (data) => Image.memory(
          data,
          gaplessPlayback: true,
          cacheWidth: constraints.maxWidth.toInt(),
        ),
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
      );

      return GestureDetector(
        onTap: widget.onTap,
        child: PreviewBox(
          style: Style(
            box.border.all.color(selectedColor),
          ),
          child: AbsorbPointer(
            child: AspectRatio(
              aspectRatio: kAspectRatio,
              child: child,
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
          box.border.all.color(selectedColor),
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
