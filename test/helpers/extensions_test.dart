import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/helpers/extensions.dart';

void main() {
  group('FileExt', () {
    late File file;
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
      file = File('${tempDir.path}/test.txt');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('ensureWrite creates file and writes content', () async {
      await file.ensureWrite('test content');
      expect(await file.exists(), true);
      expect(await file.readAsString(), 'test content');
    });

    test('ensureWrite overwrites existing file content', () async {
      await file.writeAsString('old content');
      await file.ensureWrite('new content');
      expect(await file.readAsString(), 'new content');
    });

    test('ensureExists creates file if it does not exist', () async {
      await file.ensureExists();
      expect(await file.exists(), true);
    });

    test('ensureExists does not modify existing file', () async {
      await file.writeAsString('test content');
      await file.ensureExists();
      expect(await file.readAsString(), 'test content');
    });
  });

  group('DirectoryExt', () {
    late Directory dir;

    setUp(() {
      dir = Directory('${Directory.systemTemp.path}/test_dir');
    });

    tearDown(() {
      if (dir.existsSync()) {
        dir.deleteSync(recursive: true);
      }
    });

    test('ensureExists creates directory if it does not exist', () async {
      await dir.ensureExists();
      expect(dir.existsSync(), true);
    });

    test('ensureExists does not modify existing directory', () async {
      await dir.create();
      await dir.ensureExists();
      expect(dir.existsSync(), true);
    });
  });
}
