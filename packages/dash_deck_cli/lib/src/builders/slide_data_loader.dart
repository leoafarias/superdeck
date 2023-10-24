import 'package:dash_deck_cli/src/builders/slides_parser.dart';
import 'package:dash_deck_cli/src/constants.dart';
import 'package:dash_deck_core/dash_deck_core.dart';

Future<List<Slide>> slidesMarkdownLoader() async {
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
