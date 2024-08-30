import 'package:flutter/widgets.dart';

import '../async_value.dart';
import 'select_notifier.dart';

class FutureNotifier<T> extends ValueNotifier<AsyncValue<T>>
    with SelectNotifierMixin<AsyncValue<T>> {
  late Future<T> Function() future;

  FutureNotifier(this.future) : super(AsyncValue<T>.loading()) {
    _updateFuture(future());
  }

  Future<void> _updateFuture(Future<T> future) async {
    value = value.copyWith(status: AsyncStatus.loading);
    try {
      final result = await future;
      value = value.copyWith(status: AsyncStatus.sucess, data: result);
    } catch (error) {
      value = value.copyWith(status: AsyncStatus.error, error: error);
    }
  }

  void refresh() {
    _updateFuture(future());
  }

  void reload() {
    // trigger a fulle load again
    value = AsyncValue.loading();
    _updateFuture(future());
  }

  E map<E>({
    required E Function(T) data,
    required E Function(Object) error,
    required E Function() loading,
    E Function()? reloading,
    E Function()? refreshing,
  }) {
    if (value.isRefreshing && refreshing != null) return refreshing();
    if (value.isLoading && reloading != null) return reloading();
    if (value.hasValue) return data(value.data as T);
    if (value.hasError) return error(value.error!);
    return loading();
  }
}
