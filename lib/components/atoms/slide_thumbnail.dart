import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../helpers/slide_to_image.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';

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
  final Slide slide;

  const SlideThumbnail({
    super.key,
    required this.selected,
    required this.onTap,
    required this.slide,
  });

  @override
  State<SlideThumbnail> createState() => _SlideThumbnailState();
}

class _SlideThumbnailState extends State<SlideThumbnail> {
  late final thumbnailGen = SlideToImage.instance;
  late final quality = ExportQuality.low;

  late final slideImage = futureSignal(() async {
    const delay = Durations.short2;
    await Future.delayed(delay);
    while (_isGenerating) {
      await Future.delayed(delay);
    }

    _isGenerating = true;

    try {
      final data = await thumbnailGen.generate(
        // ignore: use_build_context_synchronously
        context: context,
        quality: quality,
        slide: widget.slide,
      );

      return data;
    } finally {
      _isGenerating = false;
    }
  });

  // if widget.slide changes, we need to refresh the widget
  @override
  void didUpdateWidget(covariant SlideThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.slide != widget.slide) {
      slideImage.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = widget.selected ? Colors.blue : Colors.transparent;

    final result = slideImage.watch(context);

    Widget buildChild() {
      final cacheData = thumbnailGen.getFromCache(widget.slide, quality);
      if (cacheData != null) {
        return Image.memory(cacheData);
      } else {
        return result.map(
          data: (data) => Image.memory(data),
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
      }
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: PreviewBox(
        style: Style(
          box.border.all.color(selectedColor),
        ),
        child: AbsorbPointer(
          child: AspectRatio(
            aspectRatio: kAspectRatio,
            child: buildChild(),
          ),
        ),
      ),
    );
  }
}
