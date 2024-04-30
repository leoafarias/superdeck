import 'dart:async';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../services/snapshot_service.dart';
import '../../superdeck.dart';
import '../molecules/scaled_app.dart';
import 'cache_image_widget.dart';
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
  late final imageGenerator = SnapshotService.instance;
  late final _thumbnailFile = SlideAsset.thumbnail(widget.slide);

  late final imageLoader = futureSignal(() {
    return kCanRunProcess
        ? _generateThumbnail()
        : Future.value(_getLocalAsset());
  });

  @override
  void dispose() {
    super.dispose();
    imageLoader.dispose();
  }

  @override
  void didUpdateWidget(SlideThumbnail oldWidget) {
    if (oldWidget.index != widget.index ||
        oldWidget.slide.hashKey != widget.slide.hashKey) {
      print('reloading');
      imageLoader.reload();
    }
    super.didUpdateWidget(oldWidget);
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

      final result = imageLoader.watch(context);
      final asset = SuperDeckController.instance
          .asset(widget.slide.hashKey)
          .watch(context);

      if (asset != null) {}

      final child = result.map(
        data: (data) {
          return Image(
            image: getImageProvider(
              context: context,
              url: data,
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
