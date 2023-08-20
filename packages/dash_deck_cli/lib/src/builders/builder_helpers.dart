import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:recase/recase.dart';

String widgetName(String slideName, int snippetIndex) {
  return ReCase('${slideName}_snippet_${snippetIndex}_widget').pascalCase;
}

Class widgetBuildMethodBuilder(String widgetName, CodeBlock codeBlock) {
  final widget = Class(
    (b) => b
      ..name = widgetName
      ..extend = refer('StatelessWidget')
      ..constructors.add(
        Constructor(
          (b) => b
            ..initializers.add(refer('super').call([refer('key : key')]).code)
            ..constant = true
            ..optionalParameters.add(
              Parameter(
                (b) => b
                  ..name = 'key'
                  ..type = refer('Key?', 'package:flutter/material.dart') //HERE
                  ..named = true,
              ),
            ),
        ),
      )
      ..methods.add(
        Method(
          (b) => b
            ..name = 'build'
            ..annotations.add(refer('override'))
            ..requiredParameters.add(
              Parameter(
                (b) => b
                  ..name = 'context'
                  ..type = refer('BuildContext'),
              ),
            )
            ..body = Code(codeBlock.source)
            ..returns = refer('Widget'),
        ),
      ),
  );

  final emitter = DartEmitter(orderDirectives: true);

  try {
    DartFormatter().format('${widget.accept(emitter)}');
  } catch (e) {
    throw Exception(
      'Error generating snippet for slide $widgetName\n $e',
    );
  }

  return widget;
}

Library libraryBuilder(
  List<Class> widgets, {
  Iterable<Directive> directives = const [],
}) {
  final library = Library(
    (b) => b
      ..body.addAll(widgets)
      ..directives.addAll(directives),
  );

  return library;
}

Future<void> runCodeEmitter(Library library, File file) async {
  final emitter = DartEmitter(orderDirectives: true);
  final code =
      DartFormatter(fixes: StyleFix.all).format('${library.accept(emitter)}');

  if (!file.existsSync()) {
    await file.create(recursive: true);
  }

  await file.writeAsString(code);
}
