/// Error message for invalid YAML.
const invalidYamlError = 'Front matter is not valid YAML.';

/// No front matter found.
const frontMatterRequired = 'Slide content must contain front matter.';

/// Exception thrown when there's an internal error.
class FrontMatterException implements Exception {
  const FrontMatterException(this.message);

  final String message;

  @override
  String toString() => 'FrontMatterException: $message';
}
