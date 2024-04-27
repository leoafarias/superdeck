import 'dart:io';

import 'package:path/path.dart';

const sdConfig = SDConfig.instance;

class SDConfig {
  const SDConfig._();

  static const instance = SDConfig._();

  String get _assetsDirName => 'assets';

  String get _slidesMarkdownName => 'slides.md';
  String get imageDirName => 'images';

  File get slidesMarkdownFile => File(_slidesMarkdownName);
  Directory get assetsDir => Directory(_assetsDirName);
  Directory get assetsImageDir => Directory(join(_assetsDirName, imageDirName));
  File get projectConfigFile => File('superdeck.yaml');

  ({
    File slides,
    File config,
    File assets,
  }) get references => (
        slides: File(join(_assetsDirName, 'slides.json')),
        config: File(join(_assetsDirName, 'config.json')),
        assets: File(join(_assetsDirName, 'assets.json')),
      );
}
