import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../../superdeck.dart';
import '../../modules/common/helpers/measure_size.dart';
import '../../modules/common/helpers/utils.dart';
import '../atoms/cache_image_widget.dart';
import '../atoms/hero_widget.dart';
import '../atoms/markdown_viewer.dart';
import '../organisms/webview_wrapper.dart';

class BlockWidget<T extends ContentBlock> extends StatelessWidget {
  const BlockWidget(this.block, {super.key});

  final T block;

  @override
  Widget build(context) {
    final configuration = SlideConfiguration.of(context);
    return SpecBuilder(
        style: configuration.style.applyVariant(
          Variant(block.type.name),
        ),
        builder: (context) {
          final spec = SlideSpec.of(context);
          return MeasureSizeBuilder(
            builder: (size) {
              return BlockConfiguration(
                size: getSizeWithoutSpacing(size, spec),
                spec: spec,
                data: block,
                isCapturing: SlideConfiguration.isCapturing(context),
                child: switch (block) {
                  (ImageBlock p) => _ImageBlockWidget(p),
                  (ColumnBlock p) => _ColumnBlockWidget(p),
                  (WidgetBlock p) => _WidgetBlockWidget(p),
                  (DartPadBlock p) => _DartPadBlockWidget(p),
                  (SectionBlock p) => SectionBlockWidget(p),
                },
              );
            },
          );
        });
  }
}

enum _BlockConfigurationAspect {
  size,
  spec,
}

class BlockConfiguration<T extends Block>
    extends InheritedModel<_BlockConfigurationAspect> {
  const BlockConfiguration({
    required this.size,
    super.key,
    required this.spec,
    required this.data,
    required super.child,
    required this.isCapturing,
  });

  final Size size;
  final T data;
  final SlideSpec spec;
  final bool isCapturing;

  static BlockConfiguration of(BuildContext context,
      [_BlockConfigurationAspect? aspect]) {
    return InheritedModel.inheritFrom<BlockConfiguration>(
      context,
      aspect: aspect,
    )!;
  }

  static Size sizeOf(BuildContext context) {
    return of(context, _BlockConfigurationAspect.size).size;
  }

  static SlideSpec specOf(BuildContext context) {
    return of(context, _BlockConfigurationAspect.spec).spec;
  }

  @override
  bool updateShouldNotify(BlockConfiguration oldWidget) {
    return size != oldWidget.size;
  }

  @override
  bool updateShouldNotifyDependent(
    BlockConfiguration oldWidget,
    Set<Object> dependencies,
  ) {
    return dependencies.contains(_BlockConfigurationAspect.size) &&
        size != oldWidget.size;
  }
}

class SectionBlockWidget extends _BlockWidget<SectionBlock> {
  const SectionBlockWidget(super.block, {super.key});

  @override
  Widget build(context, configuration) {
    final options = configuration.data;
    final sectionFlex = options.flex ?? 1;
    final alignment = options.align ?? ContentAlignment.center;

    final (mainAxis, crossAxis) = toRowAlignment(alignment);

    final children = options.blocks.map((block) {
      final alignment = toAlignment(
        block.align,
      );
      final flex = block.flex ?? 1;
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

abstract class _BlockWidget<T extends Block> extends StatefulWidget {
  const _BlockWidget(this.block, {super.key});

  final T block;

  Widget build(BuildContext context, BlockConfiguration<T> configuration);

  @override
  State<_BlockWidget> createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<_BlockWidget> {
  @override
  Widget build(context) {
    final configuration = SlideConfiguration.of(context);
    return SpecBuilder(
      style: configuration.style.applyVariant(
        Variant(widget.block.type.name),
      ),
      builder: (context) {
        final spec = SlideSpec.of(context);
        return MeasureSizeBuilder(
          builder: (size) {
            return BlockConfiguration(
              size: getSizeWithoutSpacing(size, spec),
              spec: spec,
              data: widget.block,
              isCapturing: SlideConfiguration.isCapturing(context),
              child: Builder(builder: (context) {
                final configuration = BlockConfiguration.of(context);
                return widget.build(context, configuration);
              }),
            );
          },
        );
      },
    );
  }
}

class _ColumnBlockWidget extends _BlockWidget<ColumnBlock> {
  const _ColumnBlockWidget(super.block);

  @override
  Widget build(context, configuration) {
    final isCapturing = configuration.isCapturing;
    final options = configuration.data;

    final content = block.content;
    final alignment = options.align ?? ContentAlignment.center;
    final hasTag = options.tag != null;

    final spec = BlockConfiguration.specOf(context);

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
        tag: options.tag!,
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

class _ImageBlockWidget extends _BlockWidget<ImageBlock> {
  const _ImageBlockWidget(super.block);

  @override
  Widget build(context, configuration) {
    final options = configuration.data;
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

class _WidgetBlockWidget extends _BlockWidget<WidgetBlock> {
  const _WidgetBlockWidget(super.block);

  @override
  Widget build(context, configuration) {
    final options = configuration.data;
    final controller = DeckController.of(context);

    final widgetBuilder = controller.getWidget(options.name);

    if (widgetBuilder == null) {
      return Container(
        color: Colors.red,
        child: Center(
          child: Text('Widget not found: ${options.type}'),
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
              child: Text('Error building widget: ${options.type}\n$e'),
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

class _DartPadBlockWidget extends StatelessWidget {
  const _DartPadBlockWidget(this.block);

  final DartPadBlock block;

  @override
  Widget build(context) {
    final DartPadBlock(:id, :theme, :embed) = block;

    final themeName = theme?.name ?? DartPadTheme.dark.name;

    return WebViewWrapper(
      url: 'https://dartpad.dev/?id=$id&theme=$themeName&embed=$embed',
    );
  }
}
