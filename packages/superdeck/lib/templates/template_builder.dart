part of 'templates.dart';

sealed class TemplateBuilder<T extends Slide> extends StatelessWidget {
  @visibleForTesting
  final T config;

  const TemplateBuilder(this.config, {super.key});

  static TemplateBuilder<T> buildTemplate<T extends Slide>(T config) {
    return switch (config) {
      (SimpleSlide c) => SimpleTemplate(c),
      (WidgetSlide c) => WidgetTemplate(c),
      (ImageSlide c) => ImageTemplate(c),
      (InvalidSlide c) => InvalidTemplate(c),
      _ => throw UnimplementedError(
          'Slide config not implemented ${config.runtimeType}'),
    } as TemplateBuilder<T>;
  }

  Widget render() {
    final sections = parseSections(config.content, config.contentOptions);

    return Column(
      children: sections.map((section) {
        final sectionFlex = section.options.flex ?? 1;

        return Expanded(
          flex: sectionFlex,
          child: Row(
            children: section.subSections.map((part) {
              if (part is ContentPart) {
                return Expanded(
                  flex: part.options.flex ?? 1,
                  child: SlideContent(
                    content: part.content,
                    options: part.options,
                  ),
                );
              }
              return Container();
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget buildContent() {
    return _buildContent(
      config.content,
      config.contentOptions,
    );
  }

  @protected
  Widget _buildContent(String content, ContentOptions? options) {
    return SlideContent(
      content: content,
      options: options,
    );
  }
}

abstract class SplitTemplateBuilder<T extends SplitSlide>
    extends TemplateBuilder<T> {
  const SplitTemplateBuilder(
    super.config, {
    super.key,
  });

  Widget buildSplitSlide(Widget side) {
    final position = config.options.position;
    final flex = config.options.flex;

    List<Widget> children = [
      Expanded(child: render()),
      Expanded(flex: flex, child: side),
    ];

    if (position == LayoutPosition.left || position == LayoutPosition.top) {
      children = children.reversed.toList();
    }

    final isVertical =
        position == LayoutPosition.top || position == LayoutPosition.bottom;

    if (isVertical) {
      return Column(children: children);
    } else {
      return Row(children: children);
    }
  }
}
