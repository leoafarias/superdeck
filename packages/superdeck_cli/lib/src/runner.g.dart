// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runner.dart';

// **************************************************************************
// CliRunnerGenerator
// **************************************************************************

/// A CLI for creating and managing superdeck presentations
///
/// A class for invoking [Command]s based on raw command-line arguments.
///
/// The type argument `T` represents the type returned by [Command.run] and
/// [CommandRunner.run]; it can be ommitted if you're not using the return
/// values.
class _$SuperDeckRunner<T extends dynamic> extends CommandRunner<int> {
  _$SuperDeckRunner()
      : super(
          'superdeck',
          'A CLI for creating and managing superdeck presentations',
        ) {
    final upcastedType = (this as SuperDeckRunner);
    addCommand(BuildCommand(upcastedType.build));
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    try {
      return await super.runCommand(topLevelResults);
    } on UsageException catch (e) {
      stdout.writeln('${e.message}\n');
      stdout.writeln(e.usage);
    }
    return null;
  }
}

class BuildCommand extends Command<int> {
  BuildCommand(this.userMethod) {
    argParser.addFlag(
      'watch',
      abbr: 'w',
      help: 'Watch for changes to the slides.md file',
      defaultsTo: false,
      negatable: false,
    );
  }

  final Future<int> Function({bool watch}) userMethod;

  @override
  String get name => 'build';

  @override
  String get description => 'Builds the slides configured within the project';

  @override
  Future<int> run() {
    final results = argResults!;
    return userMethod(watch: (results['watch'] as bool?) ?? false);
  }
}
