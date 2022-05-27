import 'package:code_builder/code_builder.dart';

Library libraryBuilder(
  List<Class> widgets, {
  Iterable<Directive> directives = const [],
}) {
  final library = Library(
    (b) => b
      ..body.addAll(widgets)
      ..directives.addAll(directives),
  );

  return library;
}
