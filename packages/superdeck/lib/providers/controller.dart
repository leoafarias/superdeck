import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:localstorage/localstorage.dart';

import '../models/asset_model.dart';
import '../models/slide_model.dart';
import '../services/reference_service.dart';

final $superdeck = SuperDeckController.instance;

class SuperDeckController extends ChangeNotifier {
  SuperDeckController._() {
    _loadData();
    ReferenceService.instance.listen(_loadData);
  }
  bool _loading = false;
  Object? _error;
  List<Slide> _slides = [];
  List<SlideAsset> _assets = [];
  bool _completed = false;
  bool _isRefreshing = false;

  bool get loading => _loading;
  Object? get error => _error;
  List<Slide> get slides => _slides;
  List<SlideAsset> get assets => _assets;
  bool get completed => _completed;
  bool get isRefreshing => _isRefreshing;

  static final instance = SuperDeckController._();

  Future<void> _loadData() async {
    _loading = true;
    _error = null;
    _completed = false;
    notifyListeners();

    try {
      final data = await ReferenceService.instance.loadReference();

      _slides = data.slides;
      _assets = data.assets;
    } catch (e) {
      _error = e;
    } finally {
      _completed = true;
      _loading = false;
      _isRefreshing = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    _isRefreshing = true;
    await _loadData();
  }
}

List<Slide> useSlides() {
  return useListenableSelector(
    $superdeck,
    () => $superdeck.slides,
  );
}

List<InvalidSlide> useInvalidSlides() {
  return useListenableSelector(
    $superdeck,
    () => $superdeck.slides.whereType<InvalidSlide>().toList(),
  );
}

NavigationController useNavigation() {
  return useListenable(NavigationController.instance);
}

T useNavigationSelector<T>(T Function(NavigationController) selector) {
  return useListenableSelector(
    NavigationController.instance,
    () => selector(NavigationController.instance),
  );
}

class NavigationController extends ChangeNotifier {
  NavigationController._() {
    _page = _getStoredValue('page', 0);
    _sideIsOpen = _getStoredValue('sideIsOpen', false);
    _screen = _getStoredValue('screen', 0);

    addListener(() {
      _setStoredValue('page', _page);
      _setStoredValue('sideIsOpen', _sideIsOpen);
      _setStoredValue('screen', _screen);
    });
  }

  static final instance = NavigationController._();

  int _page = 0;
  bool _sideIsOpen = false;
  int _screen = 0;

  int get page => _page;
  bool get sideIsOpen => _sideIsOpen;
  int get screen => _screen;

  void openSide() {
    _sideIsOpen = true;
    notifyListeners();
  }

  void closeSide() {
    _sideIsOpen = false;
    notifyListeners();
  }

  void toggleSide() {
    if (_sideIsOpen) {
      _screen = 0;
    }
    _sideIsOpen = !_sideIsOpen;
    notifyListeners();
  }

  void goToPage(int slide) {
    if (slide < 0 || slide >= $superdeck.slides.length) {
      return;
    }
    _page = slide;

    notifyListeners();
  }

  void nextSlide() => goToPage(page + 1);

  void previousSlide() => goToPage(page - 1);

  void goToScreen(int screen) {
    _screen = screen;
    notifyListeners();
  }
}

T _getStoredValue<T>(String key, T defaultValue) {
  final stringValue = localStorage.getItem(key);
  return stringValue == null ? defaultValue : jsonDecode(stringValue) as T;
}

void _setStoredValue<T>(String key, T value) {
  localStorage.setItem(key, jsonEncode(value));
}
