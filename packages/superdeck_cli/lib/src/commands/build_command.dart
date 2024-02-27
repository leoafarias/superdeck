import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';
import 'package:watcher/watcher.dart';

import '../../superdeck_cli.dart';
import '../context.dart';

final _logger = Logger();

Future<int> buildCommandRunner({
  required bool watch,
}) async {
  Future<void> runBuildProcess() async {
    final progress = _logger.progress('Updating slides');

    try {
      loadSlideMarkdown();

      progress.complete('Slides updated');
    } catch (e, stackTrace) {
      progress.fail('Failed to update slides');
      _logger
        ..err(e.toString())
        ..detail(stackTrace.toString());

      throw Exception('Failed to update slides, $e');
    }
  }

  // Run first build
  await runBuildProcess();

  if (watch) {
    await _watchForChanges(runBuildProcess);
  }
  return ExitCode.success.code;
}

Future<void> _watchForChanges(Future<void> Function() callback) async {
  _logger.info('Watching for changes...');

  final filesToWatch = [ctx.slidesMarkdownFile.path];
  for (final filePath in filesToWatch) {
    final fileWatcher = FileWatcher(filePath);

    await for (final WatchEvent event in fileWatcher.events) {
      // Get name of file that changed
      final filePath = event.path;

      final fileName = basename(filePath);

      switch (event.type) {
        case ChangeType.MODIFY:
          _logger.info('Changes detected in $fileName');

          await callback();
      }
    }
  }
}
