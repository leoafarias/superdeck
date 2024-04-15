import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';

Signal<T> useSignal<T>(T initialData, [List<Object?>? keys]) {
  return use(
    _SignalHook(
      initialData: initialData,
      keys: keys,
    ),
  );
}

T useWatch<T>(Signal<T> signal, [List<Object?>? keys]) {
  return use(
    _WatchHook<T>(
      signal: signal,
      keys: keys,
    ),
  );
}

class _WatchHook<T> extends Hook<T> {
  const _WatchHook({super.keys, required this.signal});

  final Signal<T> signal;

  @override
  _UseWatchHookState<T> createState() => _UseWatchHookState<T>();
}

class _UseWatchHookState<T> extends HookState<T, _WatchHook<T>> {
  late T data;

  @override
  void initHook() {
    hook.signal.listen(context, () {
      setState(() => this.data = hook.signal.value);
    });
  }

  @override
  T build(BuildContext context) {
    return data;
  }
}

class _SignalHook<T> extends Hook<Signal<T>> {
  const _SignalHook({super.keys, required this.initialData});

  final T initialData;

  @override
  _UseSignalHookState<T> createState() => _UseSignalHookState<T>();
}

class _UseSignalHookState<T> extends HookState<Signal<T>, _SignalHook<T>> {
  late final signal = Signal<T>(hook.initialData);

  @override
  Signal<T> build(BuildContext context) {
    return signal;
  }

  @override
  void dispose() {
    signal.dispose();
  }

  @override
  String get debugLabel => 'useSignal';
}
