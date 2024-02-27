import 'dart:convert';

import '../../superdeck_cli.dart';
import '../context.dart';
import '../helper/helper.dart';

void loadSlideMarkdown() {
  final slidesMarkdown = ctx.slidesMarkdownFile;

  if (!slidesMarkdown.existsSync()) {
    throw Exception('Slides markdown file not found');
  }

  final presentationContent = slidesMarkdown.readAsStringSync();

  final slides = SlidesParser(presentationContent).parse();

  _saveSlideJson(slides);
}

void _saveSlideJson(List<Map<String, dynamic>> contents) {
  String content = json.encode(contents);
  content = replaceMermaidContent(content);
  final slidesJson = ctx.slidesJsonFile;

  if (!slidesJson.existsSync()) {
    slidesJson.createSync(recursive: true);
  }

  // Write a json file with a list of slides
  slidesJson.writeAsStringSync(prettyJson(contents));
}
