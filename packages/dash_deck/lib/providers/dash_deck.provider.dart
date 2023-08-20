import 'dart:convert';
import 'dart:io';

import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:watcher/watcher.dart';

part 'dash_deck.provider.g.dart';

// final rootBundleWatcherProvider = StreamProvider<String>((ref) async* {
//   const dirPath = 'assets/slides.g.json';
//   final dir = Directory(dirPath);
//   final watcher = DirectoryWatcher(dir.path);

//   await for (final event in watcher.events) {
//     if (event.type == ChangeType.MODIFY) {
//       ref.container.refresh(fetchSlidesProvider);
//     }
//   }
// });

// @riverpod
// Future<List<SlideData>> fetchSlides(FetchSlidesRef ref) async {
//   final content = json.decode(
//     await rootBundle.loadString('assets/slides.g.json'),
//   ) as List<Map<String, Object?>>;

//   return content.map(SlideData.fromJson).toList();
// }

const _slidesJsonFile = 'assets/dash_deck/slides.json';

@riverpod
class Slides extends _$Slides {
  @override
  List<SlideData> build() {
    _initialize();
    return [];
  }

  void _initialize() {
    _listener();
  }

  void _listener() {
    _fetchFromLocal();
    final file = File(_slidesJsonFile);
    final watcher = FileWatcher(file.path);
    watcher.events.listen((event) {
      if (event.type == ChangeType.MODIFY) {
        _fetchFromLocal();
      }
    });
  }

  Future<void> _fetchFromLocal() async {
    final file = File(_slidesJsonFile);
    final contents = await file.readAsString();
    final content = json.decode(contents) as List<dynamic>;

    final slides = content
        .map(((e) => SlideData.fromJson(e as Map<String, dynamic>)))
        .toList();
    state = [...slides];
  }

  Future<void> _fetchSlides() async {
    final content = json.decode(
      await rootBundle.loadString(
        _slidesJsonFile,
      ),
    ) as List<dynamic>;

    final slides = content
        .map(((e) => SlideData.fromJson(e as Map<String, dynamic>)))
        .toList();
    state = [...slides];
  }
}

// final dashDeckDataProvider = StateProvider((ref) => DashDeckData(slides: []));

// final slidesListenerProvider = Provider<void>((ref) {
//   final fileEvent = ref.watch(rootBundleWatcherProvider);

//   fileEvent.whenData(
//     (event) {
//       if (event.contains('slides.g.json')) {
//         final file = File(event);
//         final content = file.readAsStringSync();
//         final slidesJson = jsonDecode(content) as List<Map<String, dynamic>>;
//         final slides = slidesJson.map(SlideData.fromJson).toList();
//         ref.read(dashDeckDataProvider.notifier).state =
//             DashDeckData(slides: slides);
//       }
//     },
//   );
// });
