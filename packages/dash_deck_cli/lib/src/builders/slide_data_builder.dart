import 'package:code_builder/code_builder.dart';
import 'package:dash_deck_cli/src/builders/builder_helpers.dart';
import 'package:dash_deck_cli/src/constants.dart';
import 'package:dash_deck_cli/src/helper/pretty_json.dart';
import 'package:dash_deck_core/dash_deck_core.dart';

Future<void> storeSlideData(List<SlideData> slides) async {
  var hasStyles = false;
  // final hasCodePreview = false;

  // Side widgets
  final previewWidgets = <String, Expression>{};
  final slideMixes = <String, Expression>{};

  final previewWidgetClasses = <Class>[];

  // Build Code snippet references
  for (final slide in slides) {
    // var codeBlockIndex = 0;
    // for (final snippet in slide.codeBlocks) {
    //   if (slide.options.codePreview) {
    //     final nameOfWidget = widgetName(slide.id, snippetIndex);
    //     snippetIndex++;
    //     hasCodePreview = true;
    //     previewWidgets[slide.id] = refer(nameOfWidget).newInstance([]);

    //     final widget = widgetBuildMethodBuilder(nameOfWidget, snippet);
    //     previewWidgetClasses.add(widget);
    //   }
    // }

    if (slide.options.styles != null) {
      // Trigger the import for mixes
      hasStyles = true;
      slideMixes[slide.id] = CodeExpression(
        Code(slide.options.styles.toString()),
      );
    }
  }

  final previewWidgetLibrary = libraryBuilder(
    previewWidgetClasses,
    directives: [
      Directive.import('package:flutter/material.dart'),
    ],
  );

  await runCodeEmitter(
    previewWidgetLibrary,
    kDashDeckDirectory.generatedCodePreviewFile,
  );

  final literalSlideList = literalList(
    slides.map((slide) {
      final options = slide.options;

      // return literalString(slide.data.toJson(), raw: false);

      final slideOptions = refer('SlideOptions').newInstance(
        [],
        {
          'scrollable': literalBool(options.scrollable),
          'layout': CodeExpression(Code(options.layout.toString())),
          'background': options.background == null
              ? literalNull
              : literalString(options.background!),
          'backgroundFit': CodeExpression(
            Code(options.backgroundFit.toString()),
          ),
          'contentAlignment': CodeExpression(
            Code(options.contentAlignment.toString()),
          ),
          'styles': slide.options.styles == null
              ? literalNull
              : literalString(
                  slide.options.styles.toString(),
                ),
        },
      );

      return refer('SlideData').newInstance([], {
        'id': literalString(slide.id),
        'content': literalString(RegExp.escape(slide.content ?? '')),
        'options': slideOptions,
      });
    }),
  );
  // final varSlides =
  //     declareConst('_slides', type: const Reference('List<SlideData>'))
  //         .assign(literalSlideList)
  //         .statement;

  // Create getter that returns the slides
  final getterSlides = Method((b) {
    final builder = b
      ..name = 'slides'
      ..type = MethodType.getter
      ..returns = const Reference('List<SlideData>')
      ..lambda = true
      // Assign literalSlideList
      ..body = literalSlideList.code;
  });

  final varWidgets = declareConst('_snippets')
      .assign(
        literalMap(previewWidgets),
      )
      .statement;

  final varMixes = declareFinal('_styles')
      .assign(
        literalMap(slideMixes),
      )
      .statement;

  // Create a class called DasDeckApp that extends DashDeck and
  // passes super(data:DashDeckData(_slides) to the constructor)

  final dashDeckApp = Class((b) {
    final builder = b
      ..name = 'DashDeckApp'
      ..extend = refer('DashDeckShell')
      ..constructors.add(
        Constructor(
          (b) => b
            // Add {Key? key} optional parameter to constructor
            ..optionalParameters.add(
              Parameter(
                (b) => b
                  ..name = 'key'
                  ..named = true
                  ..type = refer('Key?'),
              ),
            )
            ..initializers.add(
              const Code('super(data: DashDeckData(slides:slides), key:key,)'),
            ),
        ),
      );
  });

  final slidesReferenceLibrary = Library((b) {
    final builder = b
      ..comments.add('ignore_for_file: prefer_const_constructors')
      ..body.addAll([varWidgets, varMixes, dashDeckApp, getterSlides])
      ..directives.addAll([
        Directive.import('package:dash_deck/dash_deck.dart'),
        Directive.import('package:flutter/material.dart'),
      ]);
    // if (hasCodePreview) {
    //   builder.directives.add(Directive.import('./code_preview.g.dart'));
    // }
    if (hasStyles) {
      builder.directives.add(Directive.import('../styles.dart'));
    }

    // Add the following comment on top of the file // ignore_for_file: prefer_const_constructors
  });

  await runCodeEmitter(
    slidesReferenceLibrary,
    kDashDeckDirectory.generatedSlidesFile,
  );

  final slidesJson = kDashDeckDirectory.generatedSlidesJsonFile;

  if (!slidesJson.existsSync()) {
    await slidesJson.create(recursive: true);
  }

  // Write a json file with a list of slides
  await slidesJson.writeAsString(
    prettyJson(
      slides.map((slide) => slide.toJson()).toList(),
    ),
  );
}
