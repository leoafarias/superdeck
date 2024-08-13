import 'dart:io';

extension FileExt on File {
  Future<void> ensureWrite(String content) async {
    if (!await exists()) {
      await create(recursive: true);
    }

    await writeAsString(content);
  }

  Future<void> ensureExists() async {
    if (!await exists()) {
      await create(recursive: true);
    }
  }
}

extension DirectoryExt on Directory {
  Future<void> ensureExists() async {
    if (!await exists()) {
      await create(recursive: true);
    }
  }
}
