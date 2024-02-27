import 'package:superdeck_core/superdeck_core.dart';

import '../constants.dart';
import 'mermaid_builder.dart';

Future<void> storeDeckData(DeckData deck) async {
  String content = deck.toJson();
  content = await replaceMermaidContent(content);
  final slidesJson = kDashDeckDirectory.generatedSlidesJsonFile;

  if (!slidesJson.existsSync()) {
    await slidesJson.create(recursive: true);
  }

  // Write a json file with a list of slides
  await slidesJson.writeAsString(content);
}
