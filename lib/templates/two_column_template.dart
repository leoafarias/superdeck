part of 'templates.dart';

class TwoColumnTemplate extends TemplateBuilder<TwoColumnSlide> {
  const TwoColumnTemplate(
    super.model, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final config = model.config;
    final options = config.contentOptions ?? const ContentOptions();
    final alignment = options.alignment;

    return Container(
      alignment: alignment.toAlignment(),
      child: Row(
        children: [
          buildContentSection(config.left),
          buildContentSection(config.right),
        ],
      ),
    );
  }
}

class TwoColumnHeaderTemplate extends TemplateBuilder<TwoColumnHeaderSlide> {
  const TwoColumnHeaderTemplate(
    super.model, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final config = model.config;
    final options = config.contentOptions ?? const ContentOptions();
    final alignment = options.alignment;
    final flex = options.flex ?? defaultFlex;

    final header = config.header;

    final left = config.left;
    final right = config.right;
    return Column(
      children: [
        Expanded(
          flex: header.options?.flex ?? defaultFlex,
          child: Row(
            children: [
              buildContentSection((
                content: header.content,
                options: options.merge(header.options),
              )),
            ],
          ),
        ),
        Expanded(
          flex: flex,
          child: Container(
            alignment: alignment.toAlignment(),
            child: Row(
              children: [
                buildContentSection((
                  content: left.content,
                  options: options.merge(left.options),
                )),
                buildContentSection((
                  content: right.content,
                  options: options.merge(right.options),
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
