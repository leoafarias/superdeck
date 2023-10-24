import 'package:dash_deck_cli/src/builders/mermaid_builder.dart';
import 'package:dash_deck_cli/src/constants.dart';
import 'package:dash_deck_core/dash_deck_core.dart';

Future<void> storeDeckData(DashDeckData deck) async {
  String content = deck.toJson();
  content = await replaceMermaidContent(content);
  final slidesJson = kDashDeckDirectory.generatedSlidesJsonFile;

  if (!slidesJson.existsSync()) {
    await slidesJson.create(recursive: true);
  }

  // Write a json file with a list of slides
  await slidesJson.writeAsString(content);
}
