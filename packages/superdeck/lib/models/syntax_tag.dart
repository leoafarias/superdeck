import 'package:dart_mappable/dart_mappable.dart';

part 'syntax_tag.mapper.dart';

@MappableEnum()
enum SyntaxTag {
  @MappableValue('::left::')
  left,
  @MappableValue('::right::')
  right,
  @MappableValue('::content::')
  content;
}

Map<String, List<String>> parseContentWithTags(
    String input, List<SyntaxTag> tags) {
  final Map<String, List<String>> parsedContent = {};
  int lastTagEndIndex = 0;
  SyntaxTag currentTag = SyntaxTag.content;

  for (int i = 0; i < input.length; i++) {
    for (SyntaxTag tag in tags) {
      if (input.substring(i).startsWith(tag.name)) {
        // Add the content before this tag to the list
        final content = input.substring(lastTagEndIndex, i).trim();
        if (content.isNotEmpty) {
          parsedContent.putIfAbsent(currentTag.name, () => []).add(content);
        }

        // Update the current tag and last tag end index
        currentTag = tag;
        lastTagEndIndex = i + tag.name.length;

        // Skip the characters of this tag
        i += tag.name.length - 1;
        break;
      }
    }
  }

  // Add remaining content if any
  if (lastTagEndIndex < input.length) {
    final content = input.substring(lastTagEndIndex).trim();
    if (content.isNotEmpty) {
      parsedContent.putIfAbsent(currentTag.name, () => []).add(content);
    }
  }

  return parsedContent;
}
