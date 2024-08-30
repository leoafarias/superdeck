enum AsyncStatus { loading, sucess, error }

class AsyncValue<T> {
  final AsyncStatus status;

  final T? data;
  final Object? error;
  final StackTrace? stackTrace;

  const AsyncValue.loading() : this(AsyncStatus.loading);
  const AsyncValue.data(T data) : this(AsyncStatus.sucess, data);
  const AsyncValue.error(Object error, StackTrace? stackTrace)
      : this(AsyncStatus.error, null, error, stackTrace);

  const AsyncValue(
    this.status, [
    this.data,
    this.error,
    this.stackTrace,
  ]);

  bool get isRefreshing => data != null && status == AsyncStatus.loading;
  bool get isSuccess => status == AsyncStatus.sucess;
  bool get hasError => status == AsyncStatus.error;
  bool get hasValue => data != null;
  bool get isLoading => status == AsyncStatus.loading;

  T get requireData {
    assert(data != null, 'Data is null');
    return data!;
  }

  AsyncValue<T> copyWith({
    AsyncStatus? status,
    T? data,
    Object? error,
  }) {
    return AsyncValue<T>(
      status ?? this.status,
      data ?? this.data,
      error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AsyncValue<T> &&
        other.status == status &&
        other.data == data &&
        other.error == error;
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode ^ error.hashCode;
}
