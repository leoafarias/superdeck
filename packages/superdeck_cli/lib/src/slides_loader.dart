import 'dart:async';

import 'package:superdeck_cli/src/constants.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/tasks/dart_formatter_task.dart';
import 'package:superdeck_cli/src/tasks/image_cache_task.dart';
import 'package:superdeck_cli/src/tasks/mermaid_task.dart';
import 'package:superdeck_cli/src/tasks/slide_thumbnail_task.dart';
import 'package:watcher/watcher.dart';

import 'slides_pipeline.dart';

String _markdownContents = '';

class SlidesLoader {
  SlidesLoader();

  Future<void> watch() async {
    final watchingLabel = 'Watching for changes...';
    logger
      ..newLine()
      ..info(watchingLabel);
    final watcher = FileWatcher(kMarkdownFile.path);
    await for (final event in watcher.events) {
      if (event.type == ChangeType.MODIFY) {
        final newContents = await kMarkdownFile.readAsString();
        if (newContents != _markdownContents) {
          _markdownContents = newContents;
          try {
            await generate();
          } finally {
            logger
              ..newLine()
              ..info(watchingLabel);
          }
        }
      }
    }
  }

  Future<void> generate() async {
    final progress = logger.progress('Generating slides...');

    final pipeline = TaskPipeline([
      const MermaidConverterTask(),
      const DartFormatterTask(),
      const SlideThumbnailTask(),
      const ImageCachingTask(),
    ]);
    try {
      final references = await pipeline.run();
      progress.complete('Generated ${references.slides.length} slides.');
    } on Exception catch (e, stackTrace) {
      progress.fail();
      _handleException(e);

      logger.detail(stackTrace.toString());
    }
  }
}

void _handleException(Exception e) {
  if (e is SDTaskException) {
    logger
      ..err('slide: ${e.controller.slide.index}')
      ..err('Task error: ${e.taskName}');

    _handleException(e.exception);
  } else if (e is SDFormatException) {
    logger.formatError(e);
  } else if (e is SDMarkdownParsingException) {
    final errorMessages = e.messages.join('\n');
    logger
      ..newLine()
      ..alert(
        'Slide schema validation failed',
      )
      ..newLine()
      ..err(
        'slide ${e.slideLocation}: > ${e.location} > $errorMessages',
      )
      ..newLine();
  } else {
    logger.err(e.toString());
  }
}
