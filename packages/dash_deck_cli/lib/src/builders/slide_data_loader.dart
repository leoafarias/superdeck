import 'package:dash_deck/dash_deck.dart';
import 'package:dash_deck_cli/src/builders/parser/slides_parser.dart';
import 'package:dash_deck_cli/src/constants.dart';

Future<List<SlideData>> slideDataLoader() async {
  final slidesMarkdown = kDashDeckDirectory.markdownFile;
  final stylesFile = kDashDeckDirectory.stylesFile;

  if (!slidesMarkdown.existsSync()) {
    await slidesMarkdown.create(recursive: true);
  }

  if (!stylesFile.existsSync()) {
    await stylesFile.create(recursive: true);
  }

  final presentationContent = await slidesMarkdown.readAsString();

  return SlidesParser(presentationContent).parse();
}
