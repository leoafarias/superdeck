import 'dart:convert';

import '../../superdeck_cli.dart';
import '../constants.dart';
import '../helper/helper.dart';

Future<void> storeDeckData(List<Map<String, dynamic>> contents) async {
  String content = json.encode(contents);
  content = await replaceMermaidContent(content);
  final slidesJson = kSuperDeckConfig.generatedSlidesJsonFile;

  if (!slidesJson.existsSync()) {
    await slidesJson.create(recursive: true);
  }

  // Write a json file with a list of slides
  await slidesJson.writeAsString(prettyJson(contents));
}
