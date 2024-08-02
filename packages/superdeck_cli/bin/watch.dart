import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:superdeck_cli/src/slides_loader.dart';

void main(List<String> arguments) async {
  try {
    final loader = SlidesLoader();
    await loader.generate();
    await loader.watch();
  } on UsageException catch (e) {
    print(e);
    exit(64);
  }
}
