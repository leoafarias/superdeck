import 'package:args/command_runner.dart';

class BuildCommand extends Command {
  @override
  final name = 'build';

  @override
  final description = 'Builds the presentation';

  BuildCommand() {
    argParser.addOption(
      'output',
      abbr: 'o',
      help: 'The output directory',
      defaultsTo: 'build',
      valueHelp: 'output',
    );
  }

  @override
  Future<void> run() async {
    final output = argResults!['output'] as String;

    print('Building presentation to $output');
  }
}
