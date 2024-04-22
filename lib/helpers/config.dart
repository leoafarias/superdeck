import 'dart:io';

import 'package:path/path.dart';

final kConfig = SuperDeckConfig();

class SuperDeckConfig {
  SuperDeckConfig();

  String get _assetsDirName => 'assets';

  String get _slidesMarkdownName => 'slides.md';
  String get imageDirName => 'images';

  File get slidesMarkdownFile => File(_slidesMarkdownName);
  Directory get assetsDir => Directory(_assetsDirName);
  Directory get assetsImageDir => Directory(join(_assetsDirName, imageDirName));
  File get projectConfigFile => File('superdeck.yaml');

  ({
    File slides,
    File assets,
    File config,
  }) get references {
    return (
      slides: File(join(_assetsDirName, 'slides.json')),
      assets: File(join(_assetsDirName, 'assets.json')),
      config: File(join(_assetsDirName, 'config.json')),
    );
  }
}
