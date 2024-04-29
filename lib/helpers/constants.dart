import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

const kAspectRatio = 16 / 9;

const _kWidth = 1280.0;
const _kHeight = 720.0;

const kResolution = Size(_kWidth, _kHeight);

const kCanRunProcess = kDebugMode && !kIsWeb;

const kProjectRefs = SDProjectRefs.instance;

class SDProjectRefs {
  const SDProjectRefs._();

  static const instance = SDProjectRefs._();

  String get _markdownFileName => 'slides.md';
  String get _assetsDirName => 'superdeck';
  String get _generatedDirName => 'generated';
  String get _configFileName => 'superdeck.yaml';

  File get markdownFile => File(_markdownFileName);

  Directory get assetsDir => Directory(_assetsDirName);

  Directory get generatedAssetsDir =>
      Directory(join(assetsDir.path, _generatedDirName));
  File get projectConfigFile => File(_configFileName);

  File get slideRef => File(join(assetsDir.path, 'slides.json'));
  File get configRef => File(join(assetsDir.path, 'config.json'));
  File get assetsRef => File(join(assetsDir.path, 'assets.json'));
}
