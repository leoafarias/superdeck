import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

const _currentSlideKey = 'currentSlideIndex';
const _isPresenterMenuOpenKey = 'isPresenterMenuOpen';

class NavigationController extends ChangeNotifier {
  late int currentSlideIndex;
  late bool isPresenterMenuOpen;

  static Future<void> initialize() => initLocalStorage();

  NavigationController() {
    currentSlideIndex = _get(_currentSlideKey, 0);
    isPresenterMenuOpen = _get(_isPresenterMenuOpenKey, false);

    addListener(() {
      _set(_currentSlideKey, currentSlideIndex);
      _set(_isPresenterMenuOpenKey, isPresenterMenuOpen);
    });
  }

  void goToSlide(int index) {
    currentSlideIndex = index;
    notifyListeners();
  }

  void nextSlide() => goToSlide(currentSlideIndex + 1);

  void previousSlide() => goToSlide(currentSlideIndex - 1);

  void togglePresenterMenu() {
    isPresenterMenuOpen = !isPresenterMenuOpen;
    notifyListeners();
  }

  void closePresenterMenu() {
    isPresenterMenuOpen = false;
    notifyListeners();
  }

  void openPresenterMenu() {
    isPresenterMenuOpen = true;
    notifyListeners();
  }

  static T _get<T>(String key, T defaultValue) {
    final stringValue = localStorage.getItem(key);
    return stringValue == null ? defaultValue : jsonDecode(stringValue) as T;
  }

  static void _set<T>(String key, T value) {
    localStorage.setItem(key, jsonEncode(value));
  }
}
