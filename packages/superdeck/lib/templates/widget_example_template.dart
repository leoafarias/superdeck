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

    return buildSplitSlide(
      Builder(
        builder: (context) {
          return ExamplePreview(
            args: options.args,
            builder: exampleBuilder!,
          );
        },
      ),
    );
  }
}
