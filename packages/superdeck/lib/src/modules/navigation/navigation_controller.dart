import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

const _isPresenterMenuOpenKey = 'isPresenterMenuOpen';
const _showNotesKey = 'showNotes';

class NavigationController extends ChangeNotifier {
  late bool isPresenterMenuOpen;
  late bool showNotes;

  static Future<void> initialize() => initLocalStorage();

  NavigationController() {
    isPresenterMenuOpen = _get(_isPresenterMenuOpenKey, false);
    showNotes = _get(_showNotesKey, false);

    addListener(() {
      _set(_isPresenterMenuOpenKey, isPresenterMenuOpen);
      _set(_showNotesKey, showNotes);
    });
  }

  static NavigationController of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<NavigationProvider>();
    return provider!.controller;
  }

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

  void toggleShowNotes() {
    showNotes = !showNotes;
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

class NavigationProvider extends InheritedNotifier<NavigationController> {
  const NavigationProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  final NavigationController controller;
}
