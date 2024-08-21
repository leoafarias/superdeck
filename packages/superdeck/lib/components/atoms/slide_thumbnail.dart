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

enum _PopMenuAction {
  refreshThumbnail('Refresh Thumbnail', Icons.refresh);

  const _PopMenuAction(this.label, this.icon);

  final String label;
  final IconData icon;
}

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
  bool _shouldRegenerate = false;
  late final thumbnailRequest = futureSignal(() async {
    final thumbnailFile = ReferenceService.instance
        .getAssetFile('thumbnail_${widget.slide.key}.png');

    if ((!kCanRunProcess || await thumbnailFile.exists()) &&
        !_shouldRegenerate) {
      return thumbnailFile;
    }

    try {
      if (!context.mounted) {
        return thumbnailFile;
      }
      final imageData = await SnapshotService.instance.generate(
        quality: SnapshotQuality.low,
        slide: widget.slide,
      );

      return await thumbnailFile.writeAsBytes(imageData, flush: true);
    } finally {
      _shouldRegenerate = false;
    }
  });

  @override
  void didUpdateWidget(covariant SlideThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slide != widget.slide) {
      thumbnailRequest.refresh();
    }
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
      onSecondaryTapDown: (details) {
        final overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final menuItem =
            (_PopMenuAction action) => PopupMenuItem<_PopMenuAction>(
                value: action,
                onTap: () {
                  switch (action) {
                    case _PopMenuAction.refreshThumbnail:
                      _shouldRegenerate = true;
                      thumbnailRequest.reset(AsyncState.loading());
                      thumbnailRequest.reload();
                      break;
                  }
                },
                mouseCursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(action.icon),
                    const SizedBox(width: 8),
                    Text(action.label),
                  ],
                ));
        showMenu(
          context: context,
          menuPadding: EdgeInsets.zero,
          items: [
            menuItem(_PopMenuAction.refreshThumbnail),
          ],
          position: RelativeRect.fromSize(
            details.globalPosition & Size.zero,
            overlay.size,
          ),
        );
      },
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
