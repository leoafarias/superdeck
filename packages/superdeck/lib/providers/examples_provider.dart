import 'package:flutter/material.dart';

import '../superdeck.dart';

class ExamplesProvider extends InheritedWidget {
  const ExamplesProvider({
    super.key,
    required this.examples,
    required super.child,
  });

  final Map<String, ExampleBuilder> examples;

  static ExamplesProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExamplesProvider>()!;
  }

  operator [](String key) {
    final example = examples[key];
    assert(example != null, 'Example $key not found');
    return example!;
  }

  @override
  bool updateShouldNotify(covariant ExamplesProvider oldWidget) {
    return examples != oldWidget.examples;
  }
}
