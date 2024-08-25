const _tagMarker = '@';

const _startAsTag = '{$_tagMarker';

final _regexMatchTagContents = RegExp('{$_tagMarker(.*?)}');

bool isValidTag(String line) {
  final trimmedLine = line.trim();
  if (trimmedLine.startsWith(_startAsTag)) {
    if (_regexMatchTagContents.firstMatch(trimmedLine) == null) {
      throw FormatException(
        'Invalid tag format on $line \nTags must be in the format {@tag_name key: value key2: value2}',
      );
    }
    return true;
  }
  return false;
}

RegExpMatch _getTagContentsMatch(String line) {
  final match = _regexMatchTagContents.firstMatch(line);
  if (match == null) {
    throw FormatException(
      'Invalid tag format on $line \nTags must be in the format {@tag_name key: value key2: value2}',
    );
  }
  return match;
}

String getTagContents(String line) {
  final match = _getTagContentsMatch(line);
  return match.group(1)?.trim() ?? '';
}
