import 'package:dash_deck_cli/src/constants.dart';
import 'package:dash_deck_cli/src/helper/pretty_json.dart';
import 'package:dash_deck_core/dash_deck_core.dart';

Future<void> storeSlideData(List<SlideData> slides) async {
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
