import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';

typedef ListeableSignal<T>
    = SignalValueListenable<T, ValueListenable<T>, ReadonlySignal<T>>;

R useSignal<R>(R initialValue) {
  return use(_UseSignal(initialValue));
}

class _UseSignal<T extends Signal<V>, V> extends Hook<T> {
  final V initialValue;
  const _UseSignal(
    this.initialValue, {
    super.keys,
  });

  @override
  HookState<T, Hook<T>> createState() => _UseSignalState();
}

class _UseSignalState<T extends Signal<V>, V>
    extends HookState<T, _UseSignal<T, V>> {
  late T _signal;
  late ListeableSignal<V> _listenable;

  _UseSignalState();

  @override
  void initHook() {
    // Initialize the ValueNotifier with the initial value
    _signal = signal(hook.initialValue) as T;

    // Automatically add a listener that triggers setState when the notifier's value changes
    _listenable = _signal.toValueListenable();

    _listenable.addListener(_notifyChange);
  }

  _notifyChange() {
    setState(() {});
  }

  @override
  T build(BuildContext context) {
    // Return the current value of the notifier
    return _signal;
  }

  @override
  void dispose() {
    // Remove the listener and dispose of the notifier when the hook is disposed
    _listenable.removeListener(_notifyChange);
    _signal.dispose();
  }
}
