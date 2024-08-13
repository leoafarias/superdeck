import 'package:flutter/material.dart';

extension AsyncSnapshotX<T> on AsyncSnapshot<T> {
  bool get isLoading => connectionState == ConnectionState.waiting;

  bool get isRefreshing => connectionState == ConnectionState.active;
  Widget when({
    required Widget Function(T data) data,
    required Widget Function(Object? error, StackTrace? stackTrace) error,
    required Widget Function() loading,
  }) {
    if (hasError) {
      return error(error, stackTrace);
    }

    if (isLoading) {
      return loading();
    }

    return data(this.data as T);
  }
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
}

extension StringX on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String snakeCase() {
    return this
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAllMapped(
            RegExp(
                r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
            (match) => "${match.group(0)!.toLowerCase()}_")
        .replaceAll(RegExp(r'(_)\1+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
  }
}
