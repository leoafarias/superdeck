import '../../superdeck_cli.dart';
import '../constants.dart';

Future<List<Map<String, dynamic>>> slidesMarkdownLoader() async {
  final slidesMarkdown = kSuperDeckConfig.markdownFile;
  final stylesFile = kSuperDeckConfig.stylesFile;

  if (!slidesMarkdown.existsSync()) {
    await slidesMarkdown.create(recursive: true);
  }

  if (!stylesFile.existsSync()) {
    await stylesFile.create(recursive: true);
  }

  final presentationContent = await slidesMarkdown.readAsString();

  return SlidesParser(presentationContent).parse();
}
