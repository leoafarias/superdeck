import 'dart:async';

import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/helpers/dart_process.dart';

class DartFormatterTask extends Task {
  const DartFormatterTask() : super('dart_formatter');

  @override
  FutureOr<TaskController> run(controller) async {
    final formattedMarkdown = _formatDartCodeBlocks(controller);

    return controller.copyWith(
      slide: controller.slide.copyWith(markdown: formattedMarkdown),
    );
  }

  String _formatDartCodeBlocks(
    TaskController controller,
  ) {
    final codeBlockRegex = RegExp('```dart\n(.*?)\n```');
    final markdown = controller.slide.markdown;
    return markdown.replaceAllMapped(codeBlockRegex, (match) {
      final code = match.group(1)!;

      final formattedCode = DartProcess.format(code);

      return '```dart\n$formattedCode\n```';
    });
  }
}
