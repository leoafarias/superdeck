import 'package:flutter/widgets.dart';

import 'deck_reference_controller.dart';

/// An inherited notifier that provides access to a [DeckReferenceController].
///
/// This class is used internally by [DeckReferenceProvider] to propagate the
/// [DeckReferenceController] down the widget tree.
class DeckReferenceProvider extends InheritedNotifier<DeckReferenceController> {
  /// Creates a [DeckReferenceProvider] with the given [controller] and [child].
  const DeckReferenceProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  /// The [DeckReferenceController] instance associated with this inherited notifier.
  final DeckReferenceController controller;
}
