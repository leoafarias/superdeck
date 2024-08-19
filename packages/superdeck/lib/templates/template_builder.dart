part of 'templates.dart';

sealed class TemplateBuilder<T extends Slide> extends StatelessWidget {
  @visibleForTesting
  final T config;

  const TemplateBuilder(this.config, {super.key});

  static TemplateBuilder<T> buildTemplate<T extends Slide>(T config) {
    return switch (config) {
      (SimpleSlide c) => BaseTemplate(c),
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
              return Expanded(
                flex: part.options.flex ?? 1,
                child: switch (part) {
                  (ImagePart p) => ImageContent(
                      options: p.options,
                    ),
                  (ContentPart p) => SlideContent(
                      content: p.content,
                      options: p.options,
                    ),
                },
              );
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
