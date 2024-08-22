import 'dart:async';

import 'package:superdeck_cli/src/helpers/dart_process.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/slides_pipeline.dart';

class DartFormatterTask extends Task {
  const DartFormatterTask() : super('dart_formatter');

  @override
  FutureOr<TaskController> run(controller) async {
    final formattedMarkdown = _formatDartCodeBlocks(controller);

    return controller.copyWith(
      slide: controller.slide.copyWith(content: formattedMarkdown),
    );
  }

  String _formatDartCodeBlocks(
    TaskController controller,
  ) {
    final codeBlockRegex = RegExp(r'```dart\n([\s\S]*?)\n```');
    final markdown = controller.slide.content;
    return markdown.replaceAllMapped(codeBlockRegex, (match) {
      final code = match.group(1)!;
      // Analyze the code
      String formattedCode;
      try {
        formattedCode = DartProcess.format(code);
      } on SDFormatException catch (e) {
        logger
          ..newLine()
          ..warn('slide position: ${controller.position}')
          ..formatError(e)
          ..newLine();

        throw Exception('Failed to format the code block');
      }

      final replacement = '```dart\n$formattedCode\n```';

      controller.markdownReplacements.add(
        (
          pattern: match.group(0)!,
          replacement: replacement,
        ),
      );

      return replacement;
    });
  }
}
