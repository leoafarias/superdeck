import 'dart:io';

import 'package:path/path.dart';

const String kSuperDeckDirName = 'superdeck';
const String kMarkdownFileName = 'slides.md';
const String kStylesFileName = 'styles.dart';
const String kConfigFileName = 'config.yml';
const String kGeneratedCodePreviewFileName = 'code_preview.g.dart';
const String kGeneratedSlidesFileName = 'slides.g.dart';

final kWorkingDirectory = Directory.current;

SuperDeckConfig kSuperDeckConfig = SuperDeckConfig();

class SuperDeckConfig {
  SuperDeckConfig() : rootDir = kWorkingDirectory;

  Directory rootDir;

  File _getFile([
    String? path1,
    String? path2,
    String? path3,
    String? path4,
  ]) {
    return File(
      join(
        rootDir.path,
        path1,
        path2,
        path3,
        path4,
      ),
    );
  }

  Directory _getDirectory([
    String? path1,
    String? path2,
    String? path3,
  ]) {
    return Directory(
      join(
        rootDir.path,
        path1,
        path2,
        path3,
      ),
    );
  }

  File _getAssetDirectory([
    String? path1,
    String? path2,
    String? path3,
  ]) {
    return File(
      join(
        rootDir.path,
        'assets',
        'superdeck',
        path1,
        path2,
        path3,
      ),
    );
  }

  File _getLocalSuperDeckFile(
    String path1, [
    String? path2,
  ]) {
    return _getFile(
      'lib',
      kSuperDeckDirName,
      path1,
      path2,
    );
  }

  File _getGeneratedFile(String fileName) {
    return _getLocalSuperDeckFile(
      'generated',
      fileName,
    );
  }

  File get configFile => _getFile(kConfigFileName);
  File get markdownFile => _getFile(kMarkdownFileName);
  File get stylesFile => _getLocalSuperDeckFile(kStylesFileName);

  Directory get appLibDir => _getDirectory('lib');

  File get generatedCodePreviewFile => _getGeneratedFile(
        kGeneratedCodePreviewFileName,
      );
  File get generatedSlidesFile => _getGeneratedFile(
        kGeneratedSlidesFileName,
      );

  File imageFileName(String fileName) {
    return _getAssetDirectory('images', fileName);
  }

  File get generatedSlidesJsonFile => _getAssetDirectory(
        'slides.json',
      );
}
