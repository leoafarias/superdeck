import 'package:flutter/widgets.dart';

extension ValueNotifierExtension<T> on ValueNotifier<T> {
  Widget build(Widget Function(T value) builder) {
    return ListenableBuilder(
      listenable: this,
      builder: (BuildContext context, Widget? child) {
        return builder(value);
      },
    );
  }
}