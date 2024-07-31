import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExamplePreview<T> extends StatelessWidget {
  const ExamplePreview({
    super.key,
    required this.args,
    required this.builder,
  });

  final Map<String, T> args;

  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return ExampleArgsProvider(
      args: args,
      child: Center(
        child: Builder(builder: builder),
      ),
    );
  }
}

extension BuildContextExampleX on BuildContext {
  Map<String, dynamic> get args {
    return ExampleArgsProvider.of(this);
  }
}

class ExampleArgsProvider extends InheritedWidget {
  const ExampleArgsProvider({
    required this.args,
    required super.child,
    super.key,
  });

  final Map<String, dynamic> args;

  static Map<String, dynamic> of<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ExampleArgsProvider>();
    return provider?.args ?? {};
  }

  @override
  bool updateShouldNotify(ExampleArgsProvider oldWidget) {
    return !mapEquals(args, oldWidget.args);
  }
}
