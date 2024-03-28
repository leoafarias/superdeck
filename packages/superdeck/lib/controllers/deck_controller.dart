import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mix/mix.dart';
import 'package:path/path.dart' as p;
import 'package:signals_flutter/signals_flutter.dart';
import 'package:watcher/watcher.dart';

import '../helpers/service_locator.dart';
import '../models/deck_data_model.dart';
import '../models/slide_model.dart';
import '../styles/style_util.dart';

final _slidesJsonFile = File(p.join('assets', 'slides.json'));
final _assetsJsonFile = File(p.join('assets', 'assets.json'));

final deckController = getIt<SuperDeckController>();
final styles = getIt<StyleController>();

class StyleController {
  final _data = signal(SlideStyle.base());

  void load(SlideStyle? style) {
    _data.value = _data.value.merge(style);
  }

  SlideStyle get(String? variant) {
    return variant == null
        ? _data()
        : _data().applyVariants([Variant(variant)]);
  }
}

class SuperDeckController {
  final data = signal(
    const DeckData(),
  );
  final currentPage = signal(
    0,
  );
  late final currentSlide = computed(
    () => data().slides[currentPage()],
  );
  final isLoading = signal<bool>(true);

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
      _subscriptions.add(_listenAssetsJson());
      return _fetchFromLocal();
    } else {
      return _fetchDeckData();
    }
  }

  StreamSubscription _listenAssetsJson() {
    final watcher = FileWatcher(_assetsJsonFile.path);
    return watcher.events.listen((event) async {
      if (event.type == ChangeType.MODIFY) {
        final contents = await _assetsJsonFile.readAsString();

        data.value = data.value.copyWith(assets: _parseAssets(contents));
      }
    });
  }

  StreamSubscription _localListener() {
    final watcher = FileWatcher(_slidesJsonFile.path);

    return watcher.events.listen((event) async {
      if (event.type == ChangeType.MODIFY) {
        final contents = await _slidesJsonFile.readAsString();
        data.value = data.value.copyWith(slides: _parseSlides(contents));
      }
    });
  }

  List<SlideConfig> _parseSlides(String contents) {
    final slides = jsonDecode(contents) as List<dynamic>;
    return slides.map((e) {
      final templateId = e['layout'];

      return switch (templateId) {
        'image' => ImageSlideConfig.fromMap(e),
        'two-column' => TwoColumnSlideConfig.fromMap(e),
        'two-column-header' => TwoColumnHeaderSlideConfig.fromMap(e),
        'simple' => SimpleSlideConfig.fromMap(e),
        _ => SimpleSlideConfig.fromMap(e),
      };
    }).toList();
  }

  List<SlideAsset> _parseAssets(String contents) {
    final assets = jsonDecode(contents) as List<dynamic>;
    return assets.map((e) => SlideAsset.fromMap(e)).toList();
  }

  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
  }

  void updateSlideContent(SlideConfig slide, String content) {
    final previousData = data.value;

    final slidesToUpdate = [...previousData.slides];
    // Change item at index for id
    final index =
        slidesToUpdate.indexWhere((element) => element.title == slide.title);

    slidesToUpdate[index] = slide.copyWith(
      content: content,
    );

    data.value = previousData.copyWith(slides: slidesToUpdate);
  }

  Future<DeckData> _fetchFromLocal() async {
    final slidesJson = await _slidesJsonFile.readAsString();
    final assetsJson = await _assetsJsonFile.readAsString();

    return DeckData(
      slides: _parseSlides(slidesJson),
      assets: _parseAssets(assetsJson),
    );
  }

  Future<DeckData> _fetchDeckData() async {
    final content = await rootBundle.loadString(_slidesJsonFile.path);
    final assets = await rootBundle.loadString(_assetsJsonFile.path);

    return DeckData(
      slides: _parseSlides(content),
      assets: _parseAssets(assets),
    );
  }
}
