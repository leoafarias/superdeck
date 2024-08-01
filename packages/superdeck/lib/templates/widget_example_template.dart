part of 'templates.dart';

class WidgetTemplate extends SplitTemplateBuilder<WidgetSlide> {
  const WidgetTemplate(
    super.model, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final options = config.options;

    final exampleBuilder = ExamplesProvider.of(context)[options.name];

    return buildSplitSlide(SlideConstraints(
      child: Builder(builder: (context) {
        final constraints = SlideConstraints.of(context);
        return MediaQuery(
          data: MediaQueryData(size: constraints.biggest),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.biggest.width,
              maxHeight: constraints.biggest.height,
            ),
            child: ExamplePreview(
              args: options.args,
              builder: exampleBuilder!,
            ),
          ),
        );
      }),
    ));
  }
}
