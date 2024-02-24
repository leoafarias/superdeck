import 'package:superdeck_cli/superdeck_cli.dart';
import 'package:superdeck_core/superdeck_core.dart';

Future<void> createPresentation(String topic) async {
  final slidesMarkdown = kDashDeckDirectory.markdownFile;

  final presentation = await PromptsService.createPresentation(topic);

  if (!slidesMarkdown.existsSync()) {
    slidesMarkdown.createSync(recursive: true);
  }

  // final parsedPresentation = SlidesParser(presentation).parse();

  // final presentationString = DashDeckData(slides: parsedPresentation).toJson();

  slidesMarkdown.writeAsStringSync(presentation);
}

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
