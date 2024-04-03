import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../../superdeck_cli.dart';
import '../helper/helper.dart';

final config = SuperDeckConfig();

class SuperDeckConfig {
  SuperDeckConfig();

  String get _assetsDirName => 'assets';

  String get _slidesMarkdownName => 'slides.md';

  File get slidesMarkdownFile => File(_slidesMarkdownName);
  Directory get assetsDir => Directory(_assetsDirName);
  Directory get assetsImageDir => Directory(join(_assetsDirName, 'images'));
  File get slidesJsonFile => File(join(_assetsDirName, 'slides.json'));
  File get assetsJsonFile => File(join(_assetsDirName, 'assets.json'));
}

void loadSlideMarkdown() {
  final slidesMarkdown = config.slidesMarkdownFile;

  if (!slidesMarkdown.existsSync()) {
    throw Exception('Slides markdown file not found');
  }

  // Clean up assets folder
  config.assetsImageDir.listSync().forEach((element) {
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
  final slidesJson = config.slidesJsonFile;
  final assetsJson = config.assetsJsonFile;

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
  final files = config.assetsImageDir.listSync();
  var assetMap = {};

  for (var file in files) {
    if (file is File) {
      final bytes = file.readAsBytesSync();
      final base64 = base64Encode(bytes);
      // assets[file.path] = base64;
      final relativePath =
          relative(file.path, from: config.assetsDir.parent.path);

      assetMap[relativePath] = base64;
    }
  }
  //  conver a map to a an array of objects with key and value
  final listOfAssets =
      assetMap.entries.map((e) => {'name': e.key, 'base64': e.value}).toList();
  assetsJson.writeAsStringSync(prettyJson(listOfAssets));
}
