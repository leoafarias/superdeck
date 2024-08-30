import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/constants.dart';
import '../../modules/common/helpers/notifiers/future_notifier.dart';
import '../../modules/common/helpers/notifiers/notifier_extensions.dart';
import '../../modules/widget_capture/widget_capture_service.dart';
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
  late final thumbnailRequest = FutureNotifier(() async {
    final thumbnailFile = widget.slide.thumbnailFile;

    if ((!kCanRunProcess || await thumbnailFile.exists()) &&
        !_shouldRegenerate) {
      return thumbnailFile;
    }

    try {
      if (!context.mounted) {
        return thumbnailFile;
      }
      final imageData = await WidgetCaptureService.instance.generate(
        quality: WidgetCaptureQuality.low,
        slide: widget.slide,
      );

      return await thumbnailFile.writeAsBytes(imageData, flush: true);
    } finally {
      _shouldRegenerate = false;
    }
  });

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      thumbnailRequest.reload();
    });
  }

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
    return GestureDetector(
      onTap: widget.onTap,
      onSecondaryTapDown: (details) {
        final overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        menuItem(_PopMenuAction action) => PopupMenuItem<_PopMenuAction>(
            value: action,
            onTap: () {
              switch (action) {
                case _PopMenuAction.refreshThumbnail:
                  _shouldRegenerate = true;

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
              child: ListenableBuilder(
                  listenable: thumbnailRequest,
                  builder: (context, _) {
                    return thumbnailRequest.map(
                      data: (file) {
                        return Image(
                          gaplessPlayback: true,
                          image: getImageProvider(context, file.uri),
                        );
                      },
                      loading: () => const IsometricLoading(),
                      error: (error) {
                        return const Center(
                          child: Text('Error loading image'),
                        );
                      },
                    );
                  }),
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
      $box.color.grey(),
      $box.margin.all(8),
      $box.border.width(2),
      $box.shadow(
        blurRadius: 4,
        spreadRadius: 1,
      ),
      selected ? $box.wrap.scale(1.05) : $box.wrap.scale(1),
      selected ? $box.wrap.opacity(1) : $box.wrap.opacity(0.5),
      selected ? $box.border.color.cyan() : $box.border.color.transparent(),
    ).animate();

    return Box(
      style: style,
      child: AspectRatio(aspectRatio: kAspectRatio, child: child),
    );
  }
}
