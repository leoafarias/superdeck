import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

class StoredValueNotifier<T> extends ValueNotifier<T> {
  final String key;

  StoredValueNotifier(this.key, T defaultValue)
      : super(
          _get(key, defaultValue),
        ) {
    addListener(() => _set(key, value));
  }

  static T _get<T>(String key, T defaultValue) {
    final stringValue = localStorage.getItem(key);
    return stringValue == null ? defaultValue : jsonDecode(stringValue) as T;
  }

  static void _set<T>(String key, T value) {
    localStorage.setItem(key, jsonEncode(value));
  }
}
