import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';
import 'package:watcher/watcher.dart';

import '../../superdeck_cli.dart';
import '../constants.dart';

final _logger = Logger();

Future<int> buildCommandRunner({
  required bool watch,
}) async {
  kSuperDeckConfig.rootDir = Directory(
    join(
      kWorkingDirectory.path,
    ),
  );

  Future<void> runBuildProcess() async {
    final progress = _logger.progress('Updating slides');

    try {
      // final response = await PromptsService.createOutline(
      //   topic!,
      // );

      // await storeSlideData(response);
      final slides = await slidesMarkdownLoader();

      await storeDeckData(slides);
      progress.complete('Slides updated');
    } catch (e, stackTrace) {
      progress.fail(
        'Failed to update slides',
      );
      _logger
        ..err(e.toString())
        ..detail(stackTrace.toString());

      return;
    }
  }

  // Run first build
  await runBuildProcess();

  if (watch) {
    _logger.info('Watching for changes...');

    final filesToWatch = [
      kSuperDeckConfig.markdownFile.path,
      kSuperDeckConfig.stylesFile.path,
    ];
    for (final filePath in filesToWatch) {
      final fileWatcher = FileWatcher(filePath);

      await for (final WatchEvent event in fileWatcher.events) {
        // Get name of file that changed
        final filePath = event.path;

        final fileName = basename(filePath);

        switch (event.type) {
          case ChangeType.MODIFY:
            _logger.info(
              'Changes detected in $fileName',
            );

            // Call your function to rebuild the slides
            // You can handle other change types as needed
            await runBuildProcess();
        }
      }
    }
  }
  return ExitCode.success.code;
}
