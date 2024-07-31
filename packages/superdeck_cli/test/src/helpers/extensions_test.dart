import 'dart:io';

import 'package:superdeck_cli/src/helpers/extensions.dart';
import 'package:test/test.dart';

void main() {
  group('FileExt', () {
    late File file;
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp();
      file = File('${tempDir.path}/test.txt');
    });

    tearDown(() async {
      await tempDir.delete(recursive: true);
    });

    test('ensureWrite creates file if it does not exist', () async {
      await file.ensureWrite('test content');
      expect(await file.exists(), isTrue);
      expect(await file.readAsString(), 'test content');
    });

    test('ensureWrite overwrites existing file', () async {
      await file.writeAsString('old content');
      await file.ensureWrite('new content');
      expect(await file.readAsString(), 'new content');
    });

    test('ensureExists creates file if it does not exist', () async {
      await file.ensureExists();
      expect(await file.exists(), isTrue);
    });

    test('ensureExists does not modify existing file', () async {
      await file.writeAsString('test content');
      await file.ensureExists();
      expect(await file.readAsString(), 'test content');
    });
  });

  group('DirectoryExt', () {
    late Directory dir;
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp();
      dir = Directory('${tempDir.path}/test_dir');
    });

    tearDown(() async {
      await tempDir.delete(recursive: true);
    });

    test('ensureExists creates directory if it does not exist', () async {
      await dir.ensureExists();
      expect(await dir.exists(), isTrue);
    });

    test('ensureExists does not modify existing directory', () async {
      await dir.create();
      await dir.ensureExists();
      expect(await dir.exists(), isTrue);
    });
  });
}
