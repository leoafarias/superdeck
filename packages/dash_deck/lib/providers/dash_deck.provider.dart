import 'dart:io';

import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:watcher/watcher.dart';

part 'dash_deck.provider.g.dart';

final _deckJsonFile = File(p.join('assets', 'dash_deck', 'deck.json'));

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
