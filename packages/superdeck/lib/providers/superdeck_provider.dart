import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:watcher/watcher.dart';

part 'superdeck_provider.g.dart';

final _deckJsonFile = File(p.join('assets', 'dash_deck', 'deck.json'));

@riverpod
Slide? currentSlide(CurrentSlideRef ref) {
  final page = ref.watch(slidePageProvider);
  final deck = ref.watch(deckControllerProvider).when(data: (data) {
    return data.slides[page];
  }, loading: () {
    return null;
  }, error: (error, stack) {
    return null;
  });
  return deck;
}

@riverpod
class SlidePage extends _$SlidePage {
  @override
  int build() {
    return 0;
  }

  void setActivePage(int page) {
    state = page;
  }
}

@riverpod
class DeckController extends _$DeckController {
  @override
  Future<DashDeckData> build() {
    return _loadData();
  }

  Future<DashDeckData> _loadData() {
    if (kDebugMode) {
      _localListener();
      return _fetchFromLocal();
    } else {
      return _fetchDeckData();
    }
  }

  void _localListener() {
    final watcher = FileWatcher(_deckJsonFile.path);
    watcher.events.listen((event) async {
      if (event.type == ChangeType.MODIFY) {
        final contents = await _deckJsonFile.readAsString();
        state = AsyncValue.data(DashDeckData.fromJson(contents));
      }
    });
  }

  void updateSlideContent(Slide slide, String content) {
    final previousState = state.asData!.value;

    final slidesToUpdate = [...previousState.slides];
    // Change item at index for id
    final index =
        slidesToUpdate.indexWhere((element) => element.id == slide.id);

    slidesToUpdate[index] = slide.copyWith(content: content);

    state = AsyncValue.data(previousState.copyWith(slides: slidesToUpdate));
  }

  Future<DashDeckData> _fetchFromLocal() async {
    final slidesJson = await _deckJsonFile.readAsString();

    return DashDeckData.fromJson(slidesJson);
  }

  Future<DashDeckData> _fetchDeckData() async {
    final content = await rootBundle.loadString(
      _deckJsonFile.path,
    );

    return DashDeckData.fromJson(content);
  }
}
