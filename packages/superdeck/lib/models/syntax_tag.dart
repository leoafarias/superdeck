class SyntaxTag {
  const SyntaxTag._();
  static const left = '::left::';
  static const right = '::right::';
  static const content = '::content::';
}

Map<String, String> parseContentWithTags(
  String input,
  List<String> tags,
) {
  final result = <String, String>{};
  final lines = input.split('\n');
  var currentTag = SyntaxTag.content;
  var currentContent = '';

  // For loop with index
  for (var idx = 0; idx < lines.length; idx++) {
    final line = lines[idx];
    if (tags.contains(line.trim())) {
      final tagName = line.trim();
      if (result.containsKey(tagName) || currentTag == tagName) {
        throw Exception('Tag $tagName already exists');
      }

      if (currentContent.isNotEmpty) {
        result[currentTag] = currentContent;
      }

      currentContent = '';
      currentTag = tagName;
    } else {
      // check if its last line
      if (idx == lines.length - 1) {
        currentContent += line;
      } else {
        currentContent += '$line\n';
      }
    }
  }
  if (currentContent.isNotEmpty) {
    result[currentTag] = currentContent;
  }
  return result;
}
