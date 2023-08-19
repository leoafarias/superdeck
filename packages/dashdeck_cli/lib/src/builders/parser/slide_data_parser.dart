class SlideDataParser {
  SlideDataParser(this.content);
  final String content;

  List<String> parse() {
    // Split the content by three consecutive hyphens.
    final parts = content.split('---');

    // Initialize an empty list to store the slides.
    final slides = <String>[];

    // Iterate through the parts, combining every two parts into a slide.
    // Skip the first part if it's empty, as it's likely just leading whitespace before the first slide.
    for (var i = parts[0].trim().isEmpty ? 1 : 0;
        i < parts.length - 1;
        i += 2) {
      slides.add('${'---${parts[i]}'}---${parts[i + 1]}');
    }

    // If there's an odd number of parts, the last slide won't have trailing hyphens, so add the last part separately.
    if (parts.length.isEven) {
      slides.add('---${parts.last}');
    }

    return slides;
  }
}
