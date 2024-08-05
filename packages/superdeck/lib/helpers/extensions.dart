import 'package:flutter/widgets.dart';

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
