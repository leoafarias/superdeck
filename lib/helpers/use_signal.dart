import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';

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
  @override
  void initHook() {}

  @override
  T build(BuildContext context) {
    return hook.signal.watch(context);
  }
}

// useListen

Signal<T> useListen<T>(Signal<T> signal, [List<Object?>? keys]) {
  return use(
    _ListenHook<T>(
      signal: signal,
      keys: keys,
    ),
  );
}

class _ListenHook<T> extends Hook<Signal<T>> {
  const _ListenHook({super.keys, required this.signal});

  final Signal<T> signal;

  @override
  _UseListenHookState<T> createState() => _UseListenHookState<T>();
}

class _UseListenHookState<T> extends HookState<Signal<T>, _ListenHook<T>> {
  @override
  Signal<T> build(BuildContext context) {
    return hook.signal;
  }

  @override
  void dispose() {
    hook.signal.dispose();
  }

  @override
  String get debugLabel => 'useListen';
}

Signal<T> useSignal<T>(T initialData, [List<Object?>? keys]) {
  return use(
    _SignalHook(
      initialData: initialData,
      keys: keys,
    ),
  );
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
