class SectionTag {
  const SectionTag._();
  static const left = '::left::';
  static const right = '::right::';
  static const first = '::first::';
}

Map<String, String> parseContentSections(String input) {
  final result = <String, String>{};
  final lines = input.split('\n');
  var currentTag = SectionTag.first;
  var currentContent = '';

  // If ::tag:: is inside a ``` block, it should be ignored
  var isCodeBlock = false;

  // For loop with index
  for (var idx = 0; idx < lines.length; idx++) {
    final line = lines[idx];

    // Check if line is codeblock
    if (line.trim().startsWith('```')) {
      isCodeBlock = !isCodeBlock;
    }

    final isTag = line.trim().startsWith('::') &&
        line.trim().endsWith('::') &&
        !isCodeBlock;

    if (isTag) {
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
