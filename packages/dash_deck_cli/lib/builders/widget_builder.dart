import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:dash_deck_core/dash_deck_core.dart';

Class statelessWidgetBuilder(String widgetName, Snippet snippet) {
  var widget = Class(
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
        Method((b) => b
          ..name = 'build'
          ..annotations.add(refer('override'))
          ..requiredParameters.add(
            Parameter(
              (b) => b
                ..name = 'context'
                ..type = refer('BuildContext'),
            ),
          )
          ..body = Code(snippet.source)
          ..returns = refer('Widget')),
      ),
  );

  final emitter = DartEmitter(orderDirectives: true);

  try {
    DartFormatter().format('${widget.accept(emitter)}');
  } catch (e) {
    throw Exception(
      'Error generating snippet for slide $widgetName\n ${e.toString()}',
    );
  }

  return widget;
}
