import 'package:code_builder/code_builder.dart';
import 'package:dash_deck_cli/builders/code_preview_builder.dart';
import 'package:dash_deck_cli/builders/emitter.dart';
import 'package:dash_deck_cli/dto/slide_build_data.dart';
import 'package:dash_deck_core/constants.dart';

Future<void> buildSlideData(List<SlideBuildData> slides) async {
  bool hasMixes = false;
  bool hasCodePreview = false;

  // Side widgets
  final previewWidgets = <String, Expression>{};
  final slideMixes = <String, Expression>{};

  // Build Code snippet references
  for (var slide in slides) {
    for (var snippet in slide.snippets) {
      if (slide.options.codePreview) {
        hasCodePreview = true;
        previewWidgets[slide.id] = refer(snippet.widgetName).newInstance([]);
      }
    }

    if (slide.options.mix != null) {
      // Trigger the import for mixes
      hasMixes = true;
      slideMixes[slide.id] = CodeExpression(
        Code(slide.options.mix.toString()),
      );
      // slideMixes[slide.id];
    }
  }

  await buildCodePreviewBuilder(slides);

  final literalSlideList = literalList(slides.map((slide) {
    final options = slide.options;

    // return literalString(slide.data.toJson(), raw: false);

    final slideOptions = refer('SlideOptions').newInstance(
      [],
      {
        'devicePreview': literalBool(options.devicePreview),
        'scrollable': literalBool(options.scrollable),
        'layout': CodeExpression(Code(options.layout.toString())),
        'image':
            options.image == null ? literalNull : literalString(options.image!),
        'imageFit': CodeExpression(
          Code(options.imageFit.toString()),
        ),
        'contentAlignment': CodeExpression(
          Code(options.contentAlignment.toString()),
        ),
        'mix': slide.options.mix == null
            ? literalNull
            : literalString(
                slide.options.mix.toString(),
              ),
        'codePreview': CodeExpression(
          Code(options.codePreview.toString() + ','),
        ),
      },
    );

    return refer('Slide').newInstance([], {
      'id': literalString(slide.id),
      'content': literalString(RegExp.escape(slide.content ?? ""), raw: false),
      'options': slideOptions,
    });
  }));
  final varSlides = literalSlideList.assignConst('_slides').statement;

  final varWidgets =
      literalMap(previewWidgets).assignConst('_snippets').statement;

  final varMixes = literalMap(slideMixes).assignFinal('_mixes').statement;

  final varData = refer('DashDeckData').newInstance({}, {
    'slides': CodeExpression(Code('_slides')),
    'previewWidgets': CodeExpression(Code('_snippets')),
    'mixes': CodeExpression(Code('_mixes,')),
  });

  final finalData = varData.assignFinal('dashDeckData').statement;

  final library = Library((b) {
    final builder = b
      ..body.addAll([varSlides, varWidgets, varMixes, finalData])
      ..directives.addAll([
        Directive.import('package:dash_deck/dash_deck.dart'),
      ]);
    if (hasCodePreview) {
      builder.directives.add(Directive.import('./code_preview.g.dart'));
    }
    if (hasMixes) {
      builder.directives.add(Directive.import('../styles.dart'));
    }
  });

  final slidesFile = kShowtimeDirectory.slidesFile;

  await runCodeEmitter(library, slidesFile);
}
