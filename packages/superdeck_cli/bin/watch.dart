import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:superdeck_cli/src/deck_generator.dart';

void main(List<String> arguments) async {
  try {
    await SlidesLoader().watch();
  } on UsageException catch (e) {
    print(e);
    exit(64);
  }
}
