import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../../superdeck.dart';
import '../../modules/common/helpers/measure_size.dart';
import '../../modules/thumbnail/slide_capture_provider.dart';
import '../atoms/cache_image_widget.dart';
import '../atoms/hero_widget.dart';
import '../atoms/markdown_viewer.dart';
import '../organisms/webview_wrapper.dart';

class BlockWidget<T extends SubSectionBlockDto> extends StatelessWidget {
  const BlockWidget(this.block, {super.key});

  final T block;

  @override
  Widget build(context) {
    final configuration = SlideConfiguration.of(context);
    return SpecBuilder(
      style: configuration.slideStyle.applyVariant(Variant(block.type.name)),
      builder: (context) {
        return switch (block) {
          (ImageBlockDto p) => _ImageBlockWidget(p),
          (ColumnBlockDto p) => _ColumnBlockWidget(p),
          (WidgetBlockDto p) => _WidgetBlockWidget(p),
          (GistBlockDto p) => _GistBlockWidget(p),
          (SectionBlockDto p) => SectionBlockWidget(p),
        };
      },
    );
  }
}

class BlockProvider extends InheritedWidget {
  const BlockProvider({
    super.key,
    required this.data,
    required super.child,
  });

  final BlockConfiguration data;

  @override
  bool updateShouldNotify(BlockProvider oldWidget) {
    return data != oldWidget.data;
  }
}

class BlockConfiguration {
  const BlockConfiguration({required this.size});

  final Size size;

  static BlockConfiguration of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<BlockProvider>();
    return provider!.data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BlockConfiguration && other.size == size;
  }

  @override
  int get hashCode => size.hashCode;
}

class SectionBlockWidget extends StatelessWidget {
  const SectionBlockWidget(this.section, {super.key});

  final SectionBlockDto section;

  @override
  Widget build(context) {
    final options = section.options;
    final sectionFlex = section.options?.flex ?? 1;
    final alignment = options?.align ?? ContentAlignment.center;

    final (mainAxis, crossAxis) = toRowAlignment(alignment);

    final children = section.blocks.map((block) {
      final alignment = toAlignment(
        block.options?.align,
      );
      final flex = block.options?.flex ?? 1;
      return Expanded(
        flex: flex,
        child: Align(
          alignment: alignment,
          child: BlockWidget(block),
        ),
      );
    }).toList();

    return Expanded(
      flex: sectionFlex,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: crossAxis,
        children: children,
      ),
    );
  }
}

class _ColumnBlockWidget extends StatelessWidget {
  const _ColumnBlockWidget(this.block);

  final ColumnBlockDto block;

  @override
  Widget build(context) {
    final isCapturing = SnapshotProvider.isCapturingOf(context);
    final options = block.options;
    final content = block.content;
    final alignment = options?.align ?? ContentAlignment.center;
    final hasTag = options?.tag != null;

    final spec = SlideSpec.of(context);

    Widget child = spec.contentBlock(
      child: MarkdownViewer(
        content: content,
        spec: spec,
        duration: Durations.medium1,
      ),
    );

    child = Wrap(
      clipBehavior: Clip.hardEdge,
      children: [
        child,
      ],
    );

    if (hasTag) {
      child = BlockHero(
        tag: options!.tag!,
        child: child,
      );
    }

    if (!isCapturing) {
      child = SingleChildScrollView(
        child: child,
      );
    }

    child = Align(
      alignment: toAlignment(alignment),
      child: child,
    );

    return child;
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

    Widget widget = MeasureSizeBuilder(
      builder: (size) {
        return CacheDecorationImage(
          uri: Uri.parse(options.src),
          fit: toBoxFit(imageFit),
          alignment: toAlignment(alignment),
        );
      },
    );

    return widget;
  }
}

class _WidgetBlockWidget extends StatelessWidget {
  const _WidgetBlockWidget(this.block);

  final WidgetBlockDto block;

  @override
  Widget build(context) {
    final options = block.options;
    final controller = DeckController.of(context);

    final widgetBuilder = controller.getWidget(options.name);

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
        try {
          final widget = widgetBuilder(context, options);
          if (options.tag != null) {
            return BlockHero(
              tag: options.tag!,
              child: Container(child: widget),
            );
          }

          return widget;
        } catch (e) {
          return Container(
            color: Colors.red,
            child: Center(
              child: Text('Error building widget: ${options.name}\n$e'),
            ),
          );
        }
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

Alignment toAlignment(ContentAlignment? alignment) {
  if (alignment == null) {
    return Alignment.center;
  }
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
