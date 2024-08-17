part of 'templates.dart';

class SimpleTemplate extends TemplateBuilder<SimpleSlide> {
  const SimpleTemplate(
    super.config, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return render();
  }
}
