import 'package:args/command_runner.dart';
import 'package:superdeck_cli/src/slides_loader.dart';

class BuildCommand extends Command {
  @override
  final name = 'build';

  @override
  final description = 'Builds the presentation';

  BuildCommand();

  @override
  Future<void> run() async {
    print('Building the presentation...');
    await SlidesLoader.instance.generate();
  }
}
