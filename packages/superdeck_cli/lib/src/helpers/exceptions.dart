import 'package:superdeck_cli/src/slides_pipeline.dart';
import 'package:superdeck_core/superdeck_core.dart';

class SDMarkdownParsingException implements Exception {
  final SchemaValidationException exception;
  final int slideLocation;

  SDMarkdownParsingException(this.exception, this.slideLocation);

  String get location => exception.result.key.join(' | ');

  List<String> get messages {
    return exception.result.errors.map((e) => e.message).toList();
  }
}

class SDTaskException implements Exception {
  final String taskName;
  final TaskController controller;
  final Exception exception;

  SDTaskException(
    this.taskName,
    this.controller,
    this.exception,
  );

  String get message {
    return 'Error running task on slide ${controller.slide.index}';
  }

  @override
  String toString() => message;
}

class SDFormatException implements Exception {
  final String message;
  final int? offset;
  final String source;

  SDFormatException(
    this.message, [
    this.source = '',
    this.offset,
  ]);

  int? get lineNumber {
    return source.substring(0, offset).split('\n').length;
  }

  String? get lineContent {
    return source.split('\n')[lineNumber! - 1];
  }

  int? get columnNumber {
    final lines = source.split('\n');
    int totalOffset = 0;

    for (int i = 0; i < lineNumber! - 1; i++) {
      // +1 for the newline character
      totalOffset += lines[i].length + 1;
    }

    // Convert zero-based index to one-based
    return offset! - totalOffset + 1;
  }

  @override
  String toString() {
    return message;
  }
}
