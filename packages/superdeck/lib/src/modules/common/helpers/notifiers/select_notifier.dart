import 'package:flutter/foundation.dart';

mixin SelectNotifierMixin<T> on ValueNotifier<T> {
  final List<SelectValueNotifier> _selectNotifiers = [];
  SelectValueNotifier<T, R> select<R>(R Function(T) selector,
      {String? debugLabel}) {
    final selectNotifier =
        SelectValueNotifier<T, R>(this, selector, debugLabel: debugLabel);
    _selectNotifiers.add(selectNotifier);

    return selectNotifier;
  }

  @override
  void dispose() {
    super.dispose();
    for (var notifier in _selectNotifiers) {
      notifier.dispose();
    }
  }
}

class SelectValueNotifier<T, R> extends ValueNotifier<R> {
  final ValueNotifier<T> _notifier;
  final R Function(T) _selector;
  final String? debugLabel;

  SelectValueNotifier(ValueNotifier<T> notifier, R Function(T) selector,
      {this.debugLabel})
      : _notifier = notifier,
        _selector = selector,
        super(
          selector(notifier.value),
        ) {
    _notifier.addListener(_updateValue);
  }

  void _updateValue() {
    final newValue = _selector(_notifier.value);
    print('$debugLabel: $newValue');
    if (value != newValue) {
      value = newValue;
    }
  }

  @override
  void dispose() {
    _notifier.removeListener(_updateValue);
    super.dispose();
  }
}
