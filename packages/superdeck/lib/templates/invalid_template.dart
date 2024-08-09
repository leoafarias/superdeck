part of 'templates.dart';

class InvalidTemplate extends TemplateBuilder<InvalidSlide> {
  const InvalidTemplate(
    super.config, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const red = Color.fromARGB(255, 166, 6, 6);

    return SpecBuilder(
        style: _invalidStyle,
        builder: (context) {
          //  Maybe there are no validation errors just return the content
          return Container(
            decoration: BoxDecoration(
              color: red,
              border: Border.all(color: red, width: 20),
            ),
            child: buildContent(),
          );
        });
  }
}

final _ = SlideSpecUtility.self;

final _invalidStyle = Style(
  _.paragraph.textStyle.color(Colors.white),
  _.h1.textStyle.color(const Color.fromARGB(255, 71, 1, 1)),
  _.h1.textStyle.fontSize(36.0),
  _.h1.textStyle.bold(),
  _.h2.padding.top(0),
  _.h2.textStyle.bold(),
  _.h2.textStyle.color.yellow(),
  _.code.textStyle.color.yellow(),
  _.code.textStyle.backgroundColor(const Color.fromARGB(255, 84, 6, 6)),
);
