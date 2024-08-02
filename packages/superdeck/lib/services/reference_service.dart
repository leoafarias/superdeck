import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import '../helpers/constants.dart';
import '../helpers/watcher.dart';
import '../models/reference_model.dart';

final _assetDir = Directory(p.join('.superdeck'));
final _slideRef = File(p.join(_assetDir.path, 'slides.json'));
final _generatedDir = Directory(p.join(_assetDir.path, 'generated'));

class ReferenceService {
  final _watcher = FileWatcher(_slideRef);
  ReferenceService._();

  static final instance = ReferenceService._();

  Future<String> loadString(String path) async {
    if (kCanRunProcess) {
      return File(path).readAsString();
    } else {
      return rootBundle.loadString(path);
    }
  }

  File getAssetFile(String fileName) {
    return File(p.join(_generatedDir.path, fileName));
  }

  void listen(Function() callback) {
    if (kCanRunProcess) {
      if (!_watcher.isWatching) {
        _watcher.start(callback);
      }
    }
  }

  Future<SuperDeckReference> loadReference() async {
    final slidesJson = await loadString(_slideRef.path);
    try {
      return compute(SuperDeckReference.fromJson, slidesJson);
    } catch (e) {
      log('Error loading deck: $e');
      return const SuperDeckReference.empty();
    }
  }
}
