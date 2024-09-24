import 'dart:convert';
import 'dart:io';

import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/helpers/short_hash_id.dart';

class DartProcess {
  // static Future<Process> _run(List<String> args) async {
  //   return Process.start('dart', args, mode: ProcessStartMode.inheritStdio);
  // }

  // runSync
  static ProcessResult _runSync(List<String> args) {
    return Process.runSync('dart', args);
  }

  static String format(String code) {
    final hash = shortHashId(code); // Generate a hash for the code
    final tempFile = File('${Directory.systemTemp.path}/$hash.dart');
    try {
      tempFile.createSync(recursive: true);

      tempFile.writeAsStringSync(code);

      final result = _runSync(['format', '--fix', tempFile.path]);

      if (result.exitCode != 0) {
        throw _handleFormattingError(result.stderr as String, code);
      }
      return tempFile.readAsStringSync();
    } finally {
      if (tempFile.existsSync()) {
        tempFile.deleteSync();
      }
    }
  }
}

SdFormatException _handleFormattingError(String stderr, String source) {
  final match =
      RegExp(r'line (\d+), column (\d+) of .*: (.+)').firstMatch(stderr);

  if (match != null) {
    final line = int.parse(match.group(1)!);
    final column = int.parse(match.group(2)!);
    final message = match.group(3)!;

    // Calculate the zero-based offset
    final lines = LineSplitter().convert(source);
    int offset = 0;

    // Calculate the offset by summing the lengths of all preceding lines
    for (int i = 0; i < line - 1; i++) {
      offset += lines[i].length + 1; // +1 for the newline character
    }
    offset += column - 1; // Add the column offset within the line

    return SdFormatException(
      'Dart code formatting error: $message',
      source,
      offset,
    );
  } else {
    return SdFormatException('Error formatting dart code: $stderr');
  }
}
