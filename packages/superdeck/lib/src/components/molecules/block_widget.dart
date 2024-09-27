import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../../superdeck.dart';
import '../../modules/common/helpers/constants.dart';
import '../../modules/common/helpers/controller.dart';
import '../../modules/common/helpers/converters.dart';
import '../../modules/common/helpers/measure_size.dart';
import '../../modules/common/helpers/utils.dart';
import '../atoms/cache_image_widget.dart';
import '../atoms/hero_widget.dart';
import '../atoms/markdown_viewer.dart';
import '../organisms/webview_wrapper.dart';

class BlockController extends Controller {
  BlockController({
    required Size size,
    required SlideSpec spec,
    required ContentBlock block,
  })  : _size = size,
        _spec = spec,
        _block = block;

  Size _size;

  SlideSpec _spec;
  ContentBlock _block;

  Size get size => getBlockSpecSizeWithoutSpacing(_size, spec.contentBlock);

  set size(Size size) {
    _size = size;
    notifyListeners();
  }

  SlideSpec get spec => _spec;

  ContentBlock get block => _block;

  set spec(SlideSpec spec) {
    _spec = spec;
    notifyListeners();
  }

  set block(ContentBlock block) {
    _block = block;
    notifyListeners();
  }
}

class SectionBlockWidget extends StatelessWidget {
  const SectionBlockWidget(this.section, {super.key});

  final SectionBlock section;

  @override
  Widget build(context) {
    final sectionFlex = section.flex ?? 1;
    final alignment = section.align ?? ContentAlignment.center;
    final configuration = SlideConfiguration.of(context);

    final (mainAxis, crossAxis) = ConverterHelper.toRowAlignment(alignment);

    final children = section.blocks.map((block) {
      final alignment = ConverterHelper.toAlignment(
        block.align,
      );
      final flex = block.flex ?? 1;
      return Expanded(
        flex: flex,
        child: Align(
          alignment: alignment,
          child: switch (block) {
            ColumnBlock block => ColumnBlockWidget(block),
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
  const _BlockWidget({
    required this.block,
    required this.spec,
    super.key,
  });

  final T block;
  final SlideSpec spec;

  Widget build(BuildContext context);

  @override
  State<_BlockWidget<T>> createState() => _BlockWidgetState<T>();
}

class _BlockWidgetState<T extends ContentBlock> extends State<_BlockWidget<T>> {
  late final BlockController _controller;

  @override
  @override
  void initState() {
    super.initState();
    _controller = BlockController(
      size: kResolution,
      spec: widget.spec,
      block: widget.block,
    );
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.block != oldWidget.block) {
      _controller.block = widget.block;
    }
    if (widget.spec != oldWidget.spec) {
      _controller.spec = widget.spec;
    }
  }

  @override
  Widget build(context) {
    final configuration = Controller.of<SlideController>(context);
    return SpecBuilder(
        style: configuration.style.applyVariant(
          Variant(widget.block.type.name),
        ),
        builder: (context) {
          final spec = SlideSpec.of(context);
          return spec.contentBlock(
            child: MeasureSizeBuilder(
                cacheKey: Key('${widget.block}-$spec'),
                builder: (size) {
                  return Provider(
                    controller: BlockController(
                      size: size ?? kResolution,
                      spec: spec,
                      block: widget.block,
                    ),
                    child: widget.build(context),
                  );
                }),
          );
        });
  }
}

class ColumnBlockWidget extends _BlockWidget<ColumnBlock> {
  const ColumnBlockWidget(super.block, {super.key});

  @override
  Widget build(context) {
    final content = block.content;
    final alignment = block.align ?? ContentAlignment.center;
    final tag = block.hero;

    Widget child = Wrap(
      clipBehavior: Clip.hardEdge,
      children: [
        MarkdownViewer(
          content: content,
          spec: SlideSpec.of(context),
        ),
      ],
    );

    if (tag != null) {
      child = BlockHero(
        block: block,
        child: child,
      );
    }

    child = SingleChildScrollView(
      child: child,
    );

    child = Align(
      alignment: ConverterHelper.toAlignment(alignment),
      child: child,
    );

    return child;
  }
}

class _ImageBlockWidget extends _BlockWidget<ImageBlock> {
  const _ImageBlockWidget({required super.block, required super.spec});

  @override
  Widget build(context) {
    final options = block;
    final tag = options.hero;
    final alignment = options.align ?? ContentAlignment.center;
    final imageFit = options.fit ?? ImageFit.cover;

    return CacheDecorationImage(
      uri: Uri.parse(options.src),
      fit: ConverterHelper.toBoxFit(imageFit),
      alignment: ConverterHelper.toAlignment(alignment),
    );
  }
}

class _WidgetBlockWidget extends _BlockWidget<WidgetBlock> {
  const _WidgetBlockWidget({required super.block, required super.spec});

  @override
  Widget build(context) {
    final controller = Controller.of<DeckController>(context);

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
          if (block.hero != null) {
            return BlockHero(
              tag: block.hero!,
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

class _DartPadBlockWidget extends _BlockWidget<DartPadBlock> {
  const _DartPadBlockWidget({required super.block, required super.spec});

  @override
  Widget build(context) {
    final DartPadBlock(:id, :theme, :embed) = block;

    final themeName = theme?.name ?? DartPadTheme.dark.name;

    return WebViewWrapper(
      url: 'https://dartpad.dev/?id=$id&theme=$themeName&embed=$embed',
    );
  }
}
