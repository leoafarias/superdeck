import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../../superdeck.dart';
import '../../modules/common/helpers/controller.dart';
import '../../modules/common/helpers/measure_size.dart';
import '../../modules/common/helpers/utils.dart';
import '../atoms/cache_image_widget.dart';
import '../atoms/hero_widget.dart';
import '../atoms/markdown_viewer.dart';
import '../organisms/webview_wrapper.dart';

class BlockController extends Controller {
  BlockController({
    required this.size,
    required this.spec,
    required this.isCapturing,
  });

  final Size size;

  final SlideSpec spec;
  final bool isCapturing;
}

class SectionBlockWidget extends StatelessWidget {
  const SectionBlockWidget(this.section, {super.key});

  final SectionBlock section;

  @override
  Widget build(context) {
    final sectionFlex = section.flex ?? 1;
    final alignment = section.align ?? ContentAlignment.center;

    final (mainAxis, crossAxis) = toRowAlignment(alignment);

    final children = section.blocks.map((block) {
      final alignment = toAlignment(
        block.align,
      );
      final flex = block.flex ?? 1;
      return Expanded(
        flex: flex,
        child: Align(
          alignment: alignment,
          child: switch (block) {
            ColumnBlock block => _ColumnBlockWidget(block),
            ImageBlock block => _ImageBlockWidget(block),
            WidgetBlock block => _WidgetBlockWidget(block),
            DartPadBlock block => _DartPadBlockWidget(block),
          },
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

abstract class _BlockWidget<T extends ContentBlock> extends StatefulWidget {
  const _BlockWidget(this.block, {super.key});

  final T block;

  Widget build(BuildContext context, BlockController configuration);

  @override
  State<_BlockWidget<T>> createState() => _BlockWidgetState<T>();
}

class _BlockWidgetState<T extends ContentBlock> extends State<_BlockWidget<T>> {
  @override
  Widget build(context) {
    final configuration = SlideConfiguration.of(context);
    return SpecBuilder(
      style: configuration.style.applyVariant(
        Variant(widget.block.type.name),
      ),
      builder: (context) {
        return MeasureSizeBuilder(
          builder: (size) {
            final spec = SlideSpec.of(context);
            final configuration = BlockController(
              size: getSizeWithoutSpacing(size, spec),
              spec: spec,
              isCapturing: SlideConfiguration.isCapturing(context),
            );
            return Provider(
              controller: configuration,
              child: Builder(builder: (context) {
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

    final content = block.content;
    final alignment = block.align ?? ContentAlignment.center;
    final tag = block.tag;

    final spec = configuration.spec;

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

    if (tag != null) {
      child = BlockHero(
        tag: tag,
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
    final options = block;
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
    final controller = DeckController.of(context);

    final widgetBuilder = controller.getWidget(block.name);

    if (widgetBuilder == null) {
      return Container(
        color: Colors.red,
        child: Center(
          child: Text('Widget not found: ${block.type}'),
        ),
      );
    }

    return Builder(
      builder: (context) {
        try {
          final widget = widgetBuilder(context, block);
          if (block.tag != null) {
            return BlockHero(
              tag: configuration,
              child: Container(child: widget),
            );
          }

          return widget;
        } catch (e) {
          return Container(
            color: Colors.red,
            child: Center(
              child: Text('Error building widget: ${block.type}\n$e'),
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
