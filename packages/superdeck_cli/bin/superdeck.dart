#!/usr/bin/env dart

import 'dart:io';

import 'package:superdeck_cli/src/runner.dart';

Future<void> main(List<String> args) async {
  await _flushThenExit(await SuperDeckRunner().run(args) ?? exitCode);
}

/// Flushes the stdout and stderr streams, then exits the program with the given
/// status code.
///
/// This returns a Future that will never complete, since the program will have
/// exited already. This is useful to prevent Future chains from proceeding
/// after you've decided to exit.
Future<void> _flushThenExit(int status) {
  return Future.wait<void>([stdout.close(), stderr.close()])
      .then<void>((_) => exit(status));
}