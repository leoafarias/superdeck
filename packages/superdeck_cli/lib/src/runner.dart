import 'package:cli_annotations/cli_annotations.dart';

import 'commands/build_command.dart';

part 'runner.g.dart';

const executableName = 'superdeck';
const packageName = 'superdeck_cli';
const description = 'SuperDeck CLI';

@CliRunner(name: executableName)
class SuperDeckRunner extends _$SuperDeckRunner<int> {
  SuperDeckRunner() {
    argParser.addFlag('version', abbr: 'v', help: 'Print the version');
  }

  /// Builds the slides configured within the project
  @cliCommand
  Future<int> build({
    @Flag(
      abbr: 'w',
      help: 'Watch for changes',
      negatable: false,
    )
    bool watch = false,
  }) {
    return buildCommandRunner(watch: watch);
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] == true) {
      print('1.0.0');
      return 0;
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
