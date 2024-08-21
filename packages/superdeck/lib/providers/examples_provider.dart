import 'package:flutter/material.dart';

typedef ExampleBuilder = Widget Function(BuildContext context);

class ExamplesProvider extends InheritedWidget {
  const ExamplesProvider({
    super.key,
    required this.examples,
    required super.child,
  });

  final Map<String, ExampleBuilder> examples;

  static Map<String, ExampleBuilder> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ExamplesProvider>()!
        .examples;
  }

  static ExamplesProvider inherit({
    required BuildContext context,
    required Widget child,
  }) {
    return ExamplesProvider(examples: of(context), child: child);
  }

  @override
  bool updateShouldNotify(covariant ExamplesProvider oldWidget) {
    return examples != oldWidget.examples;
  }
}
