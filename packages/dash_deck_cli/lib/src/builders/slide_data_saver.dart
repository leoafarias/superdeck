import 'dart:io';

import 'package:dash_deck/dash_deck.dart';
import 'package:dash_deck_cli/src/constants.dart';

Future<void> slideDataBuilder(List<SlideData> slides) async {
  File generatedCodePreviewFile = kDashDeckDirectory.generatedCodePreviewFile;

  // Save a json list of slides
  generatedCodePreviewFile.writeAsStringSync(
    slides.map((slide) => slide.toJson()).toList().toString(),
  );
}
