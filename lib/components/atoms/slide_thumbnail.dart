import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../helpers/slide_to_image.dart';
import '../../models/slide_model.dart';
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
  late final imageGenerator = ImageGenerationService.instance;
  late final imageCache = ImageCacheService(
    slide: widget.slide,
    quality: ExportQuality.low,
    cacheKey: widget.index.toString(),
  );
  late final quality = ExportQuality.low;

  late final asyncState = signal<AsyncState<Uint8List>>(AsyncState.loading());

  @override
  void initState() {
    super.initState();
    _getLocalAsset().then((value) => getThumbnail());
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
      final asset = await imageCache.get();

      if (asset != null) {
        asyncState.value = AsyncState.data(asset);
      }
    } on Exception catch (e) {
      asyncState.value = AsyncState.error(e);
    }
  }

  Future<void> _generateThumbnail() async {
    try {
      const delay = Durations.short2;
      while (_isGenerating) {
        await Future.delayed(delay);
      }

      _isGenerating = true;

      await Future.delayed(delay * 3);
      final data = await imageGenerator.generate(
        // ignore: use_build_context_synchronously
        context: context,
        quality: quality,
        slide: widget.slide,
      );

      await imageCache.set(data);

      asyncState.value = AsyncState.data(data);
    } on Exception catch (e) {
      asyncState.value = AsyncState.error(e);
    } finally {
      _isGenerating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = widget.selected ? Colors.blue : Colors.transparent;

    final result = asyncState.watch(context);

    final child = result.map(
      data: (data) => Image.memory(
        data,
        gaplessPlayback: true,
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
