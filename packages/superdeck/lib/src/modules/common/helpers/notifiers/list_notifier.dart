import 'dart:math';

import 'package:flutter/foundation.dart';

import 'select_notifier.dart';

class ListNotifier<T> extends ValueNotifier<List<T>>
    with SelectNotifierMixin<List<T>> {
  ListNotifier([List<T>? initialValue]) : super(initialValue ?? []);

  T operator [](int index) => value[index];

  void operator []=(int index, T value) {
    this.value[index] = value;
    notifyListeners();
  }

  void add(T element) {
    value.add(element);
    notifyListeners();
  }

  void addAll(Iterable<T> iterable) {
    value.addAll(iterable);
    notifyListeners();
  }

  void insert(int index, T element) {
    value.insert(index, element);
    notifyListeners();
  }

  void insertAll(int index, Iterable<T> iterable) {
    value.insertAll(index, iterable);
    notifyListeners();
  }

  void remove(T element) {
    value.remove(element);
    notifyListeners();
  }

  void removeAt(int index) {
    value.removeAt(index);
    notifyListeners();
  }

  void removeLast() {
    value.removeLast();
    notifyListeners();
  }

  void removeWhere(bool Function(T element) test) {
    value.removeWhere(test);
    notifyListeners();
  }

  void replaceRange(int start, int end, Iterable<T> replacement) {
    value.replaceRange(start, end, replacement);
    notifyListeners();
  }

  void clear() {
    value.clear();
    notifyListeners();
  }

  void sort([int Function(T a, T b)? compare]) {
    value.sort(compare);
    notifyListeners();
  }

  void shuffle([Random? random]) {
    value.shuffle(random);
    notifyListeners();
  }

  int get length => value.length;

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;

  Iterable<T> get reversed => value.reversed;

  bool contains(T element) => value.contains(element);

  int indexOf(T element, [int start = 0]) => value.indexOf(element, start);

  int lastIndexOf(T element, [int? start]) => value.lastIndexOf(element, start);

  void forEach(void Function(T element) action) {
    value.forEach(action);
  }

  Iterable<R> map<R>(R Function(T element) toElement) {
    return value.map(toElement);
  }

  T reduce(T Function(T value, T element) combine) {
    return value.reduce(combine);
  }

  T? firstWhere(bool Function(T element) test, {T Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  T? lastWhere(bool Function(T element) test, {T Function()? orElse}) {
    return value.lastWhere(test, orElse: orElse);
  }
}
