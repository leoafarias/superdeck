class SlideContentParser {
  SlideContentParser(this.text);
  final String text;

  static const delimiter = '---';

  String parse() {
    final value = text.trimLeft();

    // If there's no starting delimiter, there's no front matter.
    if (!value.startsWith(delimiter)) {
      throw const FormatException('Slide content not found');
    }

    // Get the index of the closing delimiter.
    final closeIndex = value.indexOf(delimiter, delimiter.length);

    // The content begins after the closing delimiter index.
    final slideContent =
        value.substring(closeIndex + delimiter.length + 1).trim();

    return slideContent;
  }
}
