import 'package:flutter/material.dart';

import '../../deck/deck_controller.dart';
import '../../deck/slide_provider.dart';
import '../../navigation/navigation_controller.dart';

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

  DeckController get deck => DeckController.of(this);

  SlideConfiguration get slide => SlideConfiguration.of(this);

  NavigationController get navigation => NavigationController.of(this);
}
