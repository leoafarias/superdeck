import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:signals_flutter/signals_flutter.dart';
import 'package:watcher/watcher.dart';

import '../helpers/service_locator.dart';
import '../models/config_model.dart';
import '../models/slide_asset_model.dart';

const _assetsDirectory = 'assets';
final _slidesJsonFile = File(p.join(_assetsDirectory, 'slides.json'));
final _assetsJsonFile = File(p.join(_assetsDirectory, 'assets.json'));

final superdeck = getIt<SuperDeckController>();

class SuperDeckController {
  final slides = listSignal<SlideOptions>([]);
  final assets = listSignal<SlideAsset>([]);

  final currentPage = signal(0);
  late final currentSlide = computed(
    () => slides.value[currentPage.value],
  );
  int get _slideCount => slides.value.length;
  final isLoading = signal<bool>(true);

  SuperDeckController() {
    _loadData();
  }

  final _subscriptions = <StreamSubscription>[];

  void goToPage(int page) {
    currentPage.value = page.clamp(0, _slideCount - 1);
  }

  void nextPage() => goToPage(currentPage.value + 1);

  void previousPage() => goToPage(currentPage.value - 1);

  Future<void> _loadData() async {
    try {
      if (kDebugMode) {
        _registerLocalListener();
        await _fetchFromLocal();
      } else {
        await _fetchDeckData();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void _registerLocalListener() {
    final slidesSub =
        FileWatcher(_slidesJsonFile.path).events.listen((event) async {
      if (event.type == ChangeType.MODIFY) {
        final contents = await _slidesJsonFile.readAsString();
        final slides = _parseSlides(contents);

        print(slides[0].templateId);

        this.slides.value = slides;
      }
    });

    final assetsSub =
        FileWatcher(_assetsJsonFile.path).events.listen((event) async {
      if (event.type == ChangeType.MODIFY) {
        final contents = await _assetsJsonFile.readAsString();
        assets.value = _parseAssets(contents);
      }
    });

    _subscriptions.addAll([slidesSub, assetsSub]);
  }

  List<SlideOptions> _parseSlides(String contents) {
    final slides = json.decode(contents) as List<dynamic>;
    return slides.map((e) {
      switch (e['layout']) {
        case null:
        case BaseSlideOptions.template:
          return BaseSlideOptions.fromMap(e);
        case ImageSlideOptions.template:
          return ImageSlideOptions.fromMap(e);
        case TwoColumnSlideOptions.template:
          return TwoColumnSlideOptions.fromMap(e);
        case TwoColumnHeaderSlideOptions.template:
          return TwoColumnHeaderSlideOptions.fromMap(e);
        default:
          return BaseSlideOptions.fromMap(e);
      }
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

  Future<void> _fetchFromLocal() async {
    final slidesJson = await _slidesJsonFile.readAsString();
    final assetsJson = await _assetsJsonFile.readAsString();

    slides.value = _parseSlides(slidesJson);
    assets.value = _parseAssets(assetsJson);
  }

  Future<void> _fetchDeckData() async {
    final content = await rootBundle.loadString(_slidesJsonFile.path);
    final assets = await rootBundle.loadString(_assetsJsonFile.path);

    slides.value = _parseSlides(content);
    this.assets.value = _parseAssets(assets);
  }
}
