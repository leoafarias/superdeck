import 'dart:developer';

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

bool _isGenerating = false;

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
  late final imageGenerator = ImageGenerationService(context);
  final quality = SnapshotQuality.good;

  late final asyncState = signal<AsyncState<Uint8List>>(AsyncState.loading());

  @override
  void initState() {
    super.initState();
    _getLocalAsset().then((value) => getThumbnail());
  }

  @override
  void dispose() {
    imageGenerator.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SlideThumbnail oldWidget) {
    if (oldWidget.index != widget.index || oldWidget.slide != widget.slide) {
      getThumbnail();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> getThumbnail() async {
    if (kCanRunProcess) {
      await _generateThumbnail();
    } else {
      await _getLocalAsset();
    }
  }

  Future<void> _getLocalAsset() async {
    try {
      asyncState.value = AsyncState.loading();
      final asset = await assetService.loadThumbnailAsset(widget.slide.hash);

      if (asset != null) {
        final data = await assetService.loadBytes(asset.localPath);
        asyncState.value = AsyncState.data(data);
      }
    } on Exception catch (e) {
      asyncState.value = AsyncState.error(e);
    }
  }

  Future<void> _generateThumbnail() async {
    final asset = await assetService.loadThumbnailAsset(widget.slide.hash);

    if (asset != null) {
      await _getLocalAsset();
      return;
    }
    try {
      while (_isGenerating) {
        await Future.delayed(const Duration(milliseconds: 1));
      }

      if (!mounted) {
        log('Context is unmounted');
        return;
      }

      Uint8List image;

      _isGenerating = true;

      image = await imageGenerator.generate(
        quality: quality,
        slide: widget.slide,
      );

      await assetService.saveThumbnailAsset(
        hash: widget.slide.hash,
        data: image,
      );

      asyncState.value = AsyncState.data(image);
    } on Exception catch (e) {
      asyncState.value = AsyncState.error(e);
      log('Error generating thumbnail: $e');
      return;
    } finally {
      _isGenerating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final selectedColor = widget.selected ? Colors.blue : Colors.transparent;

      final result = asyncState.watch(context);

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
