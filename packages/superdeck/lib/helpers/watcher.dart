import 'dart:async';
import 'dart:io';

class FileWatcher {
  final File file;
  Timer? _timer;
  DateTime? _lastModified;

  FileWatcher(this.file);

  /// Starts watching the file for changes
  void start(void Function() onFileChange) {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) async {
      final hasChanged = await _checkFileChanges(file);

      if (hasChanged) {
        onFileChange();
      }
    });
  }

  /// Stops watching the file
  void stop() {
    _timer?.cancel();
  }

  /// Checks if the file is currently being watched
  bool get isWatching => _timer != null;

  Future<bool> _checkFileChanges(File file) async {
    final currentLastModified = await file.lastModified();

    if (_lastModified == null) {
      _lastModified = currentLastModified;
      return false;
    }

    final result = currentLastModified != _lastModified;

    _lastModified = currentLastModified;

    return result;
  }
}
