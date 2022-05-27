import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

Future<void> runCodeEmitter(Library library, File file) async {
  final emitter = DartEmitter(orderDirectives: true);
  final code =
      DartFormatter(fixes: StyleFix.all).format('${library.accept(emitter)}');

  if (!await file.exists()) {
    await file.create(recursive: true);
  }

  await file.writeAsString(code);
}
