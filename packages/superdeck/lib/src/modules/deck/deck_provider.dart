import 'package:flutter/widgets.dart';

import 'deck_controller.dart';

/// An inherited notifier that provides access to a [DeckController].
///
/// This class is used internally by [DeckProvider] to propagate the
/// [DeckController] down the widget tree.
class DeckProvider extends InheritedNotifier<DeckController> {
  /// Creates a [DeckProvider] with the given [controller] and [child].
  const DeckProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  /// The [DeckController] instance associated with this inherited notifier.
  final DeckController controller;
}
