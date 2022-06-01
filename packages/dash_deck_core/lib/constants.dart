import 'dart:io';

import 'package:path/path.dart';

class Constants {
  static final workingDirectory = Directory.current.path;
  static const String presentationFileName = 'slides.md';
  static const String codePreviewFileName = 'code_preview.g.dart';
  static const String slidesFileName = 'slides.g.dart';
  static const String stylesFileName = 'styles.dart';
  static const String configFileName = 'dash_deck.yml';
  static const String dashDeckDirName = 'dash_deck';
}

DashDeckDirectory kDashDeckDirectory = DashDeckDirectory();

class DashDeckDirectory {
  late Directory _root;
  late Directory _dashDeckDir;

  DashDeckDirectory({String? customDirectory}) {
    final path =
        customDirectory ?? join(libDir.path, Constants.dashDeckDirName);
    _dashDeckDir = Directory(path);
    _root = Directory(join(Constants.workingDirectory));
  }

  File get configFile {
    return File(join(_root.path, Constants.configFileName));
  }

  Directory get libDir {
    return Directory(join(Constants.workingDirectory, 'lib'));
  }

  Directory get dashDeckDir => _dashDeckDir;

  File get slidesMarkdown {
    return File(
      join(
        _dashDeckDir.path,
        Constants.presentationFileName,
      ),
    );
  }

  File get stylesFile {
    return File(
      join(
        _dashDeckDir.path,
        Constants.stylesFileName,
      ),
    );
  }

  File get codePreviewFile {
    return File(
      join(
        _dashDeckDir.path,
        'generated',
        Constants.codePreviewFileName,
      ),
    );
  }

  File get slidesFile {
    return File(
      join(
        _dashDeckDir.path,
        'generated',
        Constants.slidesFileName,
      ),
    );
  }
}
