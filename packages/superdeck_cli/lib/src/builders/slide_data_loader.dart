import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../../superdeck_cli.dart';
import '../context.dart';
import '../helper/helper.dart';

void loadSlideMarkdown() {
  final slidesMarkdown = ctx.slidesMarkdownFile;

  if (!slidesMarkdown.existsSync()) {
    throw Exception('Slides markdown file not found');
  }

  // Clean up assets folder
  ctx.assetsImageDir.listSync().forEach((element) {
    if (element is File) {
      element.deleteSync(recursive: true);
    }
  });

  final presentationContent = slidesMarkdown.readAsStringSync();

  final replacedContent = replaceMermaidContent(presentationContent);

  final slides = SlidesParser(replacedContent).parse();

  _saveSlideJson(slides);
}

void _saveSlideJson(List<Map<String, dynamic>> contents) {
  final slidesJson = ctx.slidesJsonFile;
  final assetsJson = ctx.assetsJsonFile;

  if (!slidesJson.existsSync()) {
    slidesJson.createSync(recursive: true);
  }

  if (!assetsJson.existsSync()) {
    assetsJson.createSync(recursive: true);
  }
  // Write a json file with a list of slides
  slidesJson.writeAsStringSync(prettyJson(contents));
  // Map<String,String> assets = {};
  // The key will be the file name and the value will be a base64 encoded string
  final files = ctx.assetsImageDir.listSync();
  var assetMap = {};

  for (var file in files) {
    if (file is File) {
      final bytes = file.readAsBytesSync();
      final base64 = base64Encode(bytes);
      // assets[file.path] = base64;
      final relativePath = relative(file.path, from: ctx.assetsDir.parent.path);

      assetMap[relativePath] = base64;
    }
  }
  //  conver a map to a an array of objects with key and value
  final listOfAssets =
      assetMap.entries.map((e) => {'name': e.key, 'base64': e.value}).toList();
  assetsJson.writeAsStringSync(prettyJson(listOfAssets));
}
