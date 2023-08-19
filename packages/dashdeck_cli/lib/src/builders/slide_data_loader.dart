import 'package:dashdeck_cli/src/builders/parser/slides_parser.dart';
import 'package:dashdeck_cli/src/constants.dart';
import 'package:dashdeck_core/dashdeck_core.dart';

Future<List<SlideData>> loadSlide() async {
  final slidesMarkdown = kDashDeckDirectory.markdownFile;
  final stylesFile = kDashDeckDirectory.stylesFile;

  if (!slidesMarkdown.existsSync()) {
    print('No slides.md file found. One will be created for you!');
    await slidesMarkdown.create(recursive: true);
  }

  if (!stylesFile.existsSync()) {
    print('No styles file found. One will be created for you!');
    await stylesFile.create(recursive: true);
  }

  final presentationContent = await slidesMarkdown.readAsString();
  return SlidesParser(presentationContent).parse();
}
