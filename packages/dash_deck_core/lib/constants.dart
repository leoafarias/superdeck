import 'dart:io';

import 'package:path/path.dart';

class Constants {
  static final workingDirectory = Directory.current.path;
  static const String presentationFileName = 'slides.md';
  static const String codePreviewFileName = 'code_preview.g.dart';
  static const String slidesFileName = 'slides.g.dart';
  static const String stylesFileName = 'styles.dart';
}

DashDeckDirectory kShowtimeDirectory = DashDeckDirectory();

class DashDeckDirectory {
  late Directory _rootDir;

  DashDeckDirectory({String? customDirectory}) {
    final path = customDirectory ?? join('lib', 'dash_deck');
    _rootDir = Directory(join(Constants.workingDirectory, path));
  }

  String get rootPath => _rootDir.path;
  String get projectLibPath =>
      Directory(join(Constants.workingDirectory, 'lib')).path;

  File get presentationFile {
    return File(join(rootPath, Constants.presentationFileName));
  }

  File get stylesFile {
    return File(join(rootPath, Constants.stylesFileName));
  }

  File get codePreviewFile {
    return File(join(rootPath, 'generated', Constants.codePreviewFileName));
  }

  File get slidesFile {
    return File(join(rootPath, 'generated', Constants.slidesFileName));
  }
}
