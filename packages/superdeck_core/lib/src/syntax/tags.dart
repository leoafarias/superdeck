class SyntaxTags {
  const SyntaxTags._();
  static final left = '::left::';
  static final right = '::right::';
  static final content = '::content::';
}

Map<String, List<String>> parseContentWithTags(
    String input, List<String> tags) {
  final Map<String, List<String>> parsedContent = {};
  int lastTagEndIndex = 0;
  String currentTag = SyntaxTags.content;

  for (int i = 0; i < input.length; i++) {
    for (String tag in tags) {
      if (input.substring(i).startsWith(tag)) {
        // Add the content before this tag to the list
        final content = input.substring(lastTagEndIndex, i).trim();
        if (content.isNotEmpty) {
          parsedContent.putIfAbsent(currentTag, () => []).add(content);
        }

        // Update the current tag and last tag end index
        currentTag = tag;
        lastTagEndIndex = i + tag.length;

        // Skip the characters of this tag
        i += tag.length - 1;
        break;
      }
    }
  }

  // Add remaining content if any
  if (lastTagEndIndex < input.length) {
    final content = input.substring(lastTagEndIndex).trim();
    if (content.isNotEmpty) {
      parsedContent.putIfAbsent(currentTag, () => []).add(content);
    }
  }

  return parsedContent;
}
