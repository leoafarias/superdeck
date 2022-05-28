import 'package:dash_deck_cli/builders/slide_data_builder.dart';
import 'package:dash_deck_cli/helpers/slides_parser.dart';
import 'package:dash_deck_core/constants.dart';

Future<void> loadSlide() async {
  final presentationFile = kDashDeckDirectory.presentationFile;
  final stylesFile = kDashDeckDirectory.stylesFile;

  if (!presentationFile.existsSync()) {
    print('No slides.md file found. One will be created for you!');
    await presentationFile.create(recursive: true);
  }

  if (!stylesFile.existsSync()) {
    print('No styles file found. One will be created for you!');
    await stylesFile.create(recursive: true);
  }

  final presentationContent = await presentationFile.readAsString();
  final slideContents = slideMarkdownParser(presentationContent);

  await buildSlideData(slideContents);
}
