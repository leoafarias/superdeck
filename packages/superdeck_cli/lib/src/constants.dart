import 'package:path/path.dart';

class SuperDeckConfig {
  SuperDeckConfig();

  String get _assetsDirName => 'assets';

  String get slidesMarkdownName => 'slides.md';
  String get slidesJsonPath => join(_assetsDirName, 'slides.json');

  String get imageDirPath => join(_assetsDirName, 'images');
}
