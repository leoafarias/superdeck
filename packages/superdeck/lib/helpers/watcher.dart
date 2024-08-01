import 'dart:async';
import 'dart:io';

class FileWatcher {
  final String filePath;
  StreamSubscription<FileSystemEvent>? _subscription;

  FileWatcher(this.filePath);

  /// Starts watching the file for changes
  void start(void Function() onFileChange) {
    final file = File(filePath);
    _subscription = file.watch().listen((_) => onFileChange());
  }

  /// Stops watching the file
  void stop() {
    _subscription?.cancel();
  }

  /// Checks if the file is currently being watched
  bool get isWatching => _subscription != null;
}
