import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

//  Create a ListNotifier like ValueNotifier that does comparison before setting the value
class ListNotifier<T> extends ChangeNotifier {
  ListNotifier(this._value);

  List<T> _value;

  List<T> get value => _value;

  set value(List<T> newValue) {
    if (listEquals(_value, newValue)) {
      return;
    }
    _value = newValue;
    notifyListeners();
  }

  int get length => _value.length;

  T operator [](int index) => _value[index];

  void operator []=(int index, T newValue) {
    _value[index] = newValue;
    notifyListeners();
  }

  void add(T newValue) {
    _value.add(newValue);
    notifyListeners();
  }
}

class StoredValueNotifier<T> extends ValueNotifier<T> {
  final String key;

  StoredValueNotifier(this.key, T defaultValue)
      : super(_getStoredValue(key, defaultValue)) {
    addListener(() {
      _setStoredValue(key, value);
    });
  }

  static T _getStoredValue<T>(String key, T defaultValue) {
    final stringValue = localStorage.getItem(key);
    return stringValue == null ? defaultValue : jsonDecode(stringValue) as T;
  }

  static void _setStoredValue<T>(String key, T value) {
    localStorage.setItem(key, jsonEncode(value));
  }
}
