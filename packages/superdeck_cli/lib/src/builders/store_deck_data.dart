import 'mermaid_builder.dart';
import '../constants.dart';
import 'package:superdeck_core/superdeck_core.dart';

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
