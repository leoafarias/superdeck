import 'package:dash_deck_cli/dash_deck.dart';
import 'package:dash_deck_core/constants.dart';
import 'package:watcher/watcher.dart';

void main(List<String> arguments) async {
  var watcher = DirectoryWatcher(kShowtimeDirectory.rootPath);

  print('loading slides');

  await loadSlide();

  watcher.events.listen((event) async {
    // print(event.path);
    // print(kSlidesFilePath);
    if (event.path.contains(Constants.presentationFileName)) {
      print('Changes to slides.md');
      try {
        await loadSlide();
      } on Exception catch (e) {
        print(e);
      }
    }
  });

  await Future.delayed(Duration(minutes: 500));
}
