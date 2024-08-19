part of 'templates.dart';

class BaseTemplate extends TemplateBuilder<SimpleSlide> {
  const BaseTemplate(
    super.config, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return render();
  }
}
