import 'dart:io';

import 'package:path/path.dart';

final kConfig = SuperDeckConfig();

class SuperDeckConfig {
  SuperDeckConfig();

  String get _assetsDirName => 'assets';

  String get _slidesMarkdownName => 'slides.md';

  File get slidesMarkdownFile => File(_slidesMarkdownName);
  Directory get assetsDir => Directory(_assetsDirName);
  Directory get assetsImageDir => Directory(join(_assetsDirName, 'images'));
  File get slidesJsonFile => File(join(_assetsDirName, 'slides.json'));
  File get assetsJsonFile => File(join(_assetsDirName, 'assets.json'));
  File get projectConfigFile => File('superdeck.yaml');
}
