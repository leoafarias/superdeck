part of 'templates.dart';

sealed class TemplateBuilder<T extends Slide> extends StatelessWidget {
  @visibleForTesting
  final T config;

  int get defaultFlex => 1;

  const TemplateBuilder(this.config, {super.key});

  static TemplateBuilder<T> buildTemplate<T extends Slide>(T config) {
    return switch (config) {
      (SimpleSlide c) => SimpleTemplate(c),
      (WidgetSlide c) => WidgetTemplate(c),
      (ImageSlide c) => ImageTemplate(c),
      (TwoColumnSlide c) => TwoColumnTemplate(c),
      (TwoColumnHeaderSlide c) => TwoColumnHeaderTemplate(c),
      (InvalidSlide c) => InvalidTemplate(c),
      _ => throw UnimplementedError(
          'Slide config not implemented ${config.runtimeType}'),
    } as TemplateBuilder<T>;
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

  Widget buildContentSection(SectionData section) {
    return Expanded(
      flex: section.options?.flex ?? defaultFlex,
      child: _buildContent(section.content, section.options),
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
      buildContentSection((
        content: config.content,
        options: config.contentOptions ?? const ContentOptions(),
      )),
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
