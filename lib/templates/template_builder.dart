part of 'templates.dart';

sealed class TemplateBuilder<T extends Slide> extends StatelessWidget {
  @visibleForTesting
  final SlideModel<T> model;

  int get defaultFlex => 1;

  List<SlideAsset> get assets => model.assets;

  const TemplateBuilder(this.model, {super.key});

  static TemplateBuilder<T> buildTemplate<T extends Slide>(
    SlideModel<T> model,
  ) {
    return switch (model) {
      (SlideModel<SimpleSlide> m) => SimpleTemplate(m),
      (SlideModel<WidgetSlide> m) => WidgetTemplate(m),
      (SlideModel<ImageSlide> m) => ImageTemplate(m),
      (SlideModel<TwoColumnSlide> m) => TwoColumnTemplate(m),
      (SlideModel<TwoColumnHeaderSlide> m) => TwoColumnHeaderTemplate(m),
      (SlideModel<InvalidSlide> m) => InvalidTemplate(m),
      _ => throw UnimplementedError(
          'Slide config not implemented ${model.config.runtimeType}'),
    } as TemplateBuilder<T>;
  }

  Widget buildContent() {
    return _buildContent(
      model.config.content,
      model.config.contentOptions,
    );
  }

  @protected
  Widget _buildContent(String content, ContentOptions? options) {
    return SlideContent(
      data: content,
      options: options,
      spec: model.spec,
      isExporting: model.isSnapshot,
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
    super.model, {
    super.key,
  });

  Widget buildSplitSlide(Widget side) {
    final position = model.config.options.position;
    final flex = model.config.options.flex;

    List<Widget> children = [
      buildContentSection((
        content: model.config.content,
        options: model.config.contentOptions ?? const ContentOptions(),
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
