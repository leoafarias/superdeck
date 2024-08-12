import 'dart:async';

import 'package:superdeck_cli/src/constants.dart';
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
    print('Watching for changes...');
    final watcher = FileWatcher(kMarkdownFile.path);
    await for (final event in watcher.events) {
      if (event.type == ChangeType.MODIFY) {
        final newContents = await kMarkdownFile.readAsString();
        if (newContents != _markdownContents) {
          _markdownContents = newContents;
          await generate();
        }
      }
    }
  }

  Future<void> generate() async {
    print('Generating slides...');

    final pipeline = TaskPipeline([
      const MermaidConverterTask(),
      const DartFormatterTask(),
      const SlideThumbnailTask(),
      const ImageCachingTask(),
    ]);

    await pipeline.run();
  }
}
