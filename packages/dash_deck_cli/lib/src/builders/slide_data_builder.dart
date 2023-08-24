import 'package:dash_deck_cli/src/constants.dart';

Future<void> storeSlideData(String content) async {
  final slidesJson = kDashDeckDirectory.generatedSlidesJsonFile;

  if (!slidesJson.existsSync()) {
    await slidesJson.create(recursive: true);
  }

  // Write a json file with a list of slides
  await slidesJson.writeAsString(content);
}
