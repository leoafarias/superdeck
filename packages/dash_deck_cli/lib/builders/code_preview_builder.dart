import 'package:code_builder/code_builder.dart';
import 'package:dash_deck_cli/builders/emitter.dart';
import 'package:dash_deck_cli/builders/library_builder.dart';
import 'package:dash_deck_cli/builders/widget_builder.dart';
import 'package:dash_deck_cli/dto/slide_build_data.dart';
import 'package:dash_deck_core/constants.dart';

// Future<void> _createPreviewWidget(CodeSnippet snippet) async {
//   final codeGenDirectory = kShowtimeDirectory.codeGenDirectory;
//   final widgetFile = File(
//     join(codeGenDirectory.path, snippet.fileNameWithExt),
//   );

List<Class> widgets = [];
//   await widgetFile.create(recursive: true);
//   await widgetFile.writeAsString(snippet.source);
// }

// final codeGenDirectory = kShowtimeDirectory.codeGenDirectory;
// if (await codeGenDirectory.exists()) {
//   await codeGenDirectory.delete(recursive: true);
// }
// await codeGenDirectory.create(recursive: true);
Future<void> buildCodePreviewBuilder(List<SlideBuildData> slides) async {
  for (var slide in slides) {
    if (slide.options.codePreview) {
      for (var snippet in slide.snippets) {
        final widget = statelessWidgetBuilder(snippet);
        widgets.add(widget);
      }
    }
  }
  final library = libraryBuilder(
    widgets,
    directives: [
      Directive.import('package:flutter/material.dart'),
      Directive.import('package:mix/mix.dart'),
    ],
  );

  final codePreviewFile = kShowtimeDirectory.codePreviewFile;

  await runCodeEmitter(library, codePreviewFile);
}
