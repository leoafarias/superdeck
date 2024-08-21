import 'package:flutter/material.dart';
import 'package:superdeck_core/superdeck_core.dart';

typedef ExampleBuilder = Widget Function(
  BuildContext context,
  WidgetOptions options,
);

class WidgetExamplesProvider extends InheritedWidget {
  const WidgetExamplesProvider({
    super.key,
    required this.examples,
    required super.child,
  });

  final Map<String, ExampleBuilder> examples;

  static Map<String, ExampleBuilder> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WidgetExamplesProvider>()!
        .examples;
  }

  static WidgetExamplesProvider inherit({
    required BuildContext context,
    required Widget child,
  }) {
    return WidgetExamplesProvider(examples: of(context), child: child);
  }

  @override
  bool updateShouldNotify(covariant WidgetExamplesProvider oldWidget) {
    return examples != oldWidget.examples;
  }
}
