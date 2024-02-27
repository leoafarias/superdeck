import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:signals_flutter/signals_flutter.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:watcher/watcher.dart';

import '../helpers/service_locator.dart';

final _deckJsonFile = File(p.join('assets', 'superdeck', 'deck.json'));

final sdeck = getIt<SuperDeckController>();

class SuperDeckController {
  final data =
      signal<DeckData>(const DeckData(), debugLabel: 'Controller: data');
  final currentPage = signal<int>(0, debugLabel: 'Controller: currentPage');
  late final currentSlide = computed(() => data().slides[currentPage()],
      debugLabel: "Controller: currentSlide");
  final isLoading = signal<bool>(true, debugLabel: 'Controller: isLoading');

  SuperDeckController() {
    _loadData().then((value) {
      data.value = value;
      isLoading.value = false;
    });
  }

  final _subscriptions = <StreamSubscription>[];

  void goToPage(int page) => currentPage.value = page;
  void nextPage() => currentPage.value++;
  void previousPage() {
    if (currentPage() > 0) {
      currentPage.value--;
    } else {
      // Go to the last page
      currentPage.value = data().slides.length - 1;
    }
  }

  Future<DeckData> _loadData() {
    if (kDebugMode) {
      _subscriptions.add(_localListener());
      return _fetchFromLocal();
    } else {
      return _fetchDeckData();
    }
  }

  StreamSubscription _localListener() {
    final watcher = FileWatcher(_deckJsonFile.path);
    return watcher.events.listen((event) async {
      if (event.type == ChangeType.MODIFY) {
        final contents = await _deckJsonFile.readAsString();
        data.value = DeckData.fromJson(contents);
      }
    });
  }

  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
  }

  void updateSlideContent(Slide slide, String content) {
    final previousData = data.value;

    final slidesToUpdate = [...previousData.slides];
    // Change item at index for id
    final index =
        slidesToUpdate.indexWhere((element) => element.id == slide.id);

    slidesToUpdate[index] = slide.copyWith(content: content);

    data.value = previousData.copyWith(slides: slidesToUpdate);
  }

  Future<DeckData> _fetchFromLocal() async {
    final slidesJson = await _deckJsonFile.readAsString();

    return DeckData.fromJson(slidesJson);
  }

  Future<DeckData> _fetchDeckData() async {
    final content = await rootBundle.loadString(_deckJsonFile.path);

    return DeckData.fromJson(content);
  }
}
