import 'package:flutter/material.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/extensions.dart';
import '../../modules/common/styles/style_spec.dart';
import '../../modules/deck_reference/deck_reference_provider.dart';
import '../../modules/widget_capture/widget_capture_provider.dart';
import '../atoms/cache_image_widget.dart';
import '../atoms/markdown_viewer.dart';
import '../organisms/webview_wrapper.dart';

class BlockWidget<T extends SubSectionBlockDto> extends StatelessWidget {
  const BlockWidget(this.block, {super.key});

  final T block;

  @override
  Widget build(context) {
    return switch (block) {
      (ImageBlockDto p) => _ImageBlockWidget(p),
      (ColumnBlockDto p) => _ContentBlockWidget(p),
      (WidgetBlockDto p) => _WidgetBlockWidget(p),
      (GistBlockDto p) => _GistBlockWidget(p),
    };
  }
}

class _ContentBlockWidget extends StatelessWidget {
  const _ContentBlockWidget(this.block);

  final ColumnBlockDto block;

  @override
  Widget build(context) {
    final isCapturing = SnapshotProvider.isCapturingOf(context);
    final options = block.options;
    final content = block.content;
    final alignment = options?.align ?? ContentAlignment.center;

    final spec = SlideSpec.of(context);

    Widget child = MarkdownViewer(
      content: content,
      spec: spec,
      duration: Durations.medium1,
    );

    if (options?.tag != null) {
      child = Hero(
        tag: options!.tag!,
        child: child,
      );
    }

    if (!isCapturing) {
      child = SingleChildScrollView(
        child: child,
      );
    } else {
      child = Wrap(
        clipBehavior: Clip.hardEdge,
        children: [
          child,
        ],
      );
    }
    return Align(
      alignment: toAlignment(alignment),
      child: child,
    );
  }
}

class _ImageBlockWidget extends StatelessWidget {
  const _ImageBlockWidget(this.block);

  final ImageBlockDto block;

  @override
  Widget build(context) {
    final options = block.options;
    final tag = options.tag;
    final alignment = options.align ?? ContentAlignment.center;
    final imageFit = options.fit ?? ImageFit.cover;

    Widget widget = CacheDecorationImage(
      uri: Uri.parse(options.src),
      fit: toBoxFit(imageFit),
      alignment: toAlignment(alignment),
    );

    if (tag != null) {
      widget = Hero(
        tag: tag,
        child: widget,
      );
    }

    return widget;
  }
}

class _WidgetBlockWidget extends StatelessWidget {
  const _WidgetBlockWidget(this.block);

  final WidgetBlockDto block;

  @override
  Widget build(context) {
    final options = block.options;
    final widgetBuilder = context
        .watch<DeckReferenceProvider>()
        .controller
        .getExampleWidget(options.name);

    if (widgetBuilder == null) {
      return Container(
        color: Colors.red,
        child: Center(
          child: Text('Widget not found: ${options.name}'),
        ),
      );
    }

    return Builder(
      builder: (context) {
        final widget = widgetBuilder(context, options);

        if (options.tag != null) {
          return Hero(
            tag: options.tag!,
            child: widget,
          );
        }

        return widget;
      },
    );
  }
}

BoxFit toBoxFit(ImageFit fit) {
  return switch (fit) {
    ImageFit.fill => BoxFit.fill,
    ImageFit.contain => BoxFit.contain,
    ImageFit.cover => BoxFit.cover,
    ImageFit.fitWidth => BoxFit.fitWidth,
    ImageFit.fitHeight => BoxFit.fitHeight,
    ImageFit.none => BoxFit.none,
    ImageFit.scaleDown => BoxFit.scaleDown,
  };
}

Alignment toAlignment(ContentAlignment alignment) {
  return switch (alignment) {
    ContentAlignment.topLeft => Alignment.topLeft,
    ContentAlignment.topCenter => Alignment.topCenter,
    ContentAlignment.topRight => Alignment.topRight,
    ContentAlignment.centerLeft => Alignment.centerLeft,
    ContentAlignment.center => Alignment.center,
    ContentAlignment.centerRight => Alignment.centerRight,
    ContentAlignment.bottomLeft => Alignment.bottomLeft,
    ContentAlignment.bottomCenter => Alignment.bottomCenter,
    ContentAlignment.bottomRight => Alignment.bottomRight,
  };
}

(MainAxisAlignment mainAxis, CrossAxisAlignment crossAxis) toFlexAlignment(
    Axis axis, ContentAlignment alignment) {
  final isHorizontal = axis == Axis.horizontal;
  final (mainStart, mainCenter, mainEnd) = isHorizontal
      ? (
          MainAxisAlignment.start,
          MainAxisAlignment.center,
          MainAxisAlignment.end
        )
      : (
          MainAxisAlignment.end,
          MainAxisAlignment.center,
          MainAxisAlignment.start
        );

  final (crossStart, crossCenter, crossEnd) = (
    CrossAxisAlignment.start,
    CrossAxisAlignment.center,
    CrossAxisAlignment.end
  );

  return switch (alignment) {
    ContentAlignment.topLeft => (mainStart, crossStart),
    ContentAlignment.topCenter => (mainStart, crossCenter),
    ContentAlignment.topRight => (mainStart, crossEnd),
    ContentAlignment.centerLeft => (mainCenter, crossStart),
    ContentAlignment.center => (mainCenter, crossCenter),
    ContentAlignment.centerRight => (mainCenter, crossEnd),
    ContentAlignment.bottomLeft => (mainEnd, crossStart),
    ContentAlignment.bottomCenter => (mainEnd, crossCenter),
    ContentAlignment.bottomRight => (mainEnd, crossEnd),
  };
}

(MainAxisAlignment mainAxis, CrossAxisAlignment crossAxis) toRowAlignment(
    ContentAlignment alignment) {
  return switch (alignment) {
    ContentAlignment.topLeft => (
        MainAxisAlignment.start,
        CrossAxisAlignment.start
      ),
    ContentAlignment.topCenter => (
        MainAxisAlignment.start,
        CrossAxisAlignment.center
      ),
    ContentAlignment.topRight => (
        MainAxisAlignment.start,
        CrossAxisAlignment.end
      ),
    ContentAlignment.centerLeft => (
        MainAxisAlignment.center,
        CrossAxisAlignment.start
      ),
    ContentAlignment.center => (
        MainAxisAlignment.center,
        CrossAxisAlignment.center
      ),
    ContentAlignment.centerRight => (
        MainAxisAlignment.center,
        CrossAxisAlignment.end
      ),
    ContentAlignment.bottomLeft => (
        MainAxisAlignment.end,
        CrossAxisAlignment.start
      ),
    ContentAlignment.bottomCenter => (
        MainAxisAlignment.end,
        CrossAxisAlignment.center
      ),
    ContentAlignment.bottomRight => (
        MainAxisAlignment.end,
        CrossAxisAlignment.end
      ),
  };
}

class _GistBlockWidget extends StatelessWidget {
  const _GistBlockWidget(this.block);

  final GistBlockDto block;

  @override
  Widget build(context) {
    final options = block.options;
    final DartPadOptions(:id, :theme, :embed) = options;

    final themeName = theme?.name ?? DartPadTheme.dark.name;

    return WebViewWrapper(
      url: 'https://dartpad.dev/?id=$id&theme=$themeName&embed=$embed',
    );
  }
}
