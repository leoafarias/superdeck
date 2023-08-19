import 'package:code_builder/code_builder.dart';
import 'package:dashdeck_cli/src/builders/builder_helpers.dart';
import 'package:dashdeck_cli/src/constants.dart';
import 'package:dashdeck_core/dashdeck_core.dart';

Future<void> buildSlideData(List<SlideData> slides) async {
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
          'image': options.image == null
              ? literalNull
              : literalString(options.image!),
          'imageFit': CodeExpression(
            Code(options.imageFit.toString()),
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

      return refer('Slide').newInstance([], {
        'id': literalString(slide.id),
        'content': literalString(RegExp.escape(slide.content ?? '')),
        'options': slideOptions,
      });
    }),
  );
  final varSlides = declareConst('_slides').assign(literalSlideList).statement;

  final varWidgets = declareConst('_snippets')
      .assign(
        literalMap(previewWidgets),
      )
      .statement;

  final varMixes = declareFinal('_mixes')
      .assign(
        literalMap(slideMixes),
      )
      .statement;

  final slidesReferenceLibrary = Library((b) {
    final builder = b
      ..body.addAll([varSlides, varWidgets, varMixes])
      ..directives.addAll([
        Directive.import('package:dashdeck/dashdeck.dart'),
      ]);
    // if (hasCodePreview) {
    //   builder.directives.add(Directive.import('./code_preview.g.dart'));
    // }
    if (hasStyles) {
      builder.directives.add(Directive.import('../styles.dart'));
    }
  });

  await runCodeEmitter(
    slidesReferenceLibrary,
    kDashDeckDirectory.generatedSlidesFile,
  );
}
