import 'package:flutter/material.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/controller.dart';
import '../../modules/common/helpers/converters.dart';
import '../../modules/common/helpers/measure_size.dart';
import '../../modules/common/styles/style_spec.dart';
import '../../modules/deck/deck_controller.dart';
import '../atoms/cache_image_widget.dart';
import '../atoms/markdown_viewer.dart';
import '../organisms/webview_wrapper.dart';

class BlockData {
  BlockData({
    required this.spec,
    required this.block,
    required this.size,
  });

  final SlideSpec spec;
  final ContentBlock block;
  final Size size;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BlockData &&
        other.spec == spec &&
        other.block == block &&
        other.size == size;
  }

  @override
  int get hashCode => spec.hashCode ^ block.hashCode ^ size.hashCode;
}

class SectionBlockWidget extends StatelessWidget {
  const SectionBlockWidget(this.section, {super.key});

  final SectionBlock section;

  @override
  Widget build(context) {
    final sectionFlex = section.flex ?? 1;
    final alignment = section.align ?? ContentAlignment.center;

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
          child: SizeLayoutBuilder(builder: (context, size) {
            return Provider(
              data: BlockData(
                block: block,
                spec: SlideSpec.of(context),
                size: size,
              ),
              child: switch (block) {
                ColumnBlock block => ColumnBlockWidget(block),
                ImageBlock block => _ImageBlockWidget(block),
                WidgetBlock block => _WidgetBlockWidget(block),
                DartPadBlock block => _DartPadBlockWidget(block),
              },
            );
          }),
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

abstract class _BlockWidget<T extends ContentBlock> extends StatelessWidget {
  const _BlockWidget(
    this.block, {
    super.key,
  });

  final T block;
}

class ColumnBlockWidget extends _BlockWidget<ColumnBlock> {
  const ColumnBlockWidget(super.block, {super.key});

  @override
  Widget build(context) {
    final content = block.content;
    final alignment = block.align ?? ContentAlignment.center;

    return Align(
      alignment: ConverterHelper.toAlignment(alignment),
      child: Wrap(
        clipBehavior: Clip.hardEdge,
        children: [
          SingleChildScrollView(
            child: MarkdownViewer(
              content: content,
              spec: SlideSpec.of(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageBlockWidget extends _BlockWidget<ImageBlock> {
  const _ImageBlockWidget(super.block);

  @override
  Widget build(context) {
    final options = block;

    final alignment = options.align ?? ContentAlignment.center;
    final imageFit = options.fit ?? ImageFit.cover;
    final spec = SlideSpec.of(context);

    return CachedImage(
      uri: Uri.parse(options.src),
      spec: spec.image.copyWith(
        fit: ConverterHelper.toBoxFit(imageFit),
        alignment: ConverterHelper.toAlignment(alignment),
      ),
    );
  }
}

class _WidgetBlockWidget extends _BlockWidget<WidgetBlock> {
  const _WidgetBlockWidget(super.block);

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
  const _DartPadBlockWidget(super.block);

  @override
  Widget build(context) {
    final DartPadBlock(:id, :theme, :embed) = block;

    final themeName = theme?.name ?? DartPadTheme.dark.name;

    return WebViewWrapper(
      url: 'https://dartpad.dev/?id=$id&theme=$themeName&embed=$embed',
    );
  }
}
