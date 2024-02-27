import 'package:cli_annotations/cli_annotations.dart';
import 'package:mason_logger/mason_logger.dart';

import 'commands/build_command.dart';
import 'helper/logger.dart';
import 'version.dart';

part 'runner.g.dart';

const _packageName = 'superdeck';

@CliRunner(
  name: _packageName,
  description: 'A CLI for creating and managing $_packageName presentations',
)
class SuperDeckRunner extends _$SuperDeckRunner<int> {
  SuperDeckRunner() {
    argParser.addFlag('version', abbr: 'v', help: 'Print the version');
  }

  /// Builds the slides configured within the project
  @cliCommand
  Future<int> build({
    @Flag(
      abbr: 'w',
      help: 'Watch for changes to the slides.md file',
      negatable: false,
    )
    bool watch = false,
  }) {
    return buildCommandRunner(watch: watch);
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] == true) {
      logger.info(packageVersion);
      return ExitCode.success.code;
    }
    try {
      return await super.runCommand(topLevelResults);
    } on UsageException catch (e) {
      stdout.writeln('${e.message}\n');
      stdout.writeln(e.usage);
    }
    return null;
  }
}
