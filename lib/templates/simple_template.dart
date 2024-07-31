part of 'templates.dart';

class SimpleTemplate extends TemplateBuilder<SimpleSlide> {
  const SimpleTemplate(
    super.model, {
    super.key,
  });

  @override
  Widget build(BuildContext context) => buildContent();
}
