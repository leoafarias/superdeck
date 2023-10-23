import 'package:dash_deck_cli/src/constants.dart';
import 'package:dash_deck_cli/src/helper/pretty_json.dart';
import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:mason_logger/mason_logger.dart';

Future<void> storeSlideData(List<Slide> slides, Logger logger) async {
  final slidesJson = kDashDeckDirectory.generatedSlidesJsonFile;

  final progress = logger.progress('Saving slides');

  try {
    progress.complete(
      'Saving complete',
    );

    if (!slidesJson.existsSync()) {
      await slidesJson.create(recursive: true);
    }

    // Write a json file with a list of slides
    await slidesJson.writeAsString(
      prettyJson(
        slides.map((slide) => slide.toJson()).toList(),
      ),
    );
  } catch (e) {
    progress.fail(
      'Failed to store slides',
    );
    logger.err(e.toString());
    return;
  }
}
