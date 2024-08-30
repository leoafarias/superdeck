import 'package:flutter/foundation.dart';

class MapNotifier<K, V> extends ValueNotifier<Map<K, V>> {
  MapNotifier([Map<K, V>? initialValue]) : super(initialValue ?? {});

  V? operator [](K key) => value[key];

  void operator []=(K key, V value) {
    this.value[key] = value;
    notifyListeners();
  }

  void addAll(Map<K, V> other) {
    value.addAll(other);
    notifyListeners();
  }

  void clear() {
    value.clear();
    notifyListeners();
  }

  void remove(K key) {
    value.remove(key);
    notifyListeners();
  }

  void removeWhere(bool Function(K key, V value) predicate) {
    value.removeWhere(predicate);
    notifyListeners();
  }

  void update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    value.update(key, update, ifAbsent: ifAbsent);
    notifyListeners();
  }

  void updateAll(V Function(K key, V value) update) {
    value.updateAll(update);
    notifyListeners();
  }

  bool containsKey(K key) => value.containsKey(key);

  bool containsValue(V value) => this.value.containsValue(value);

  Iterable<K> get keys => value.keys;

  Iterable<V> get values => value.values;

  int get length => value.length;

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;

  void forEach(void Function(K key, V value) action) {
    value.forEach(action);
  }

  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) {
    return value.map(convert);
  }
}
