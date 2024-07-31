import 'package:args/command_runner.dart';
import 'package:superdeck_cli/src/commands/build_command.dart';

class SuperdeckRunner extends CommandRunner {
  SuperdeckRunner() : super('superdeck', 'Superdeck CLI') {
    addCommand(BuildCommand());
  }
}
