import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

import '../../components/atoms/conditional_widget.dart';
import '../../components/atoms/loading_indicator.dart';
import 'deck_reference_controller.dart';

/// An inherited notifier that provides access to a [DeckReferenceController].
///
/// This class is used internally by [DecKReferenceProvider] to propagate the
/// [DeckReferenceController] down the widget tree.
class _ReferenceControllerInherited extends InheritedNotifier {
  /// Creates a [_ReferenceControllerInherited] with the given [controller] and [child].
  const _ReferenceControllerInherited({
    required this.controller,
    required super.child,
  });

  /// The [DeckReferenceController] instance associated with this inherited notifier.
  final DeckReferenceController controller;
}

/// A widget that provides a [DeckReferenceController] to its descendants.
///
/// [DecKReferenceProvider] listens to changes in the [controller] and rebuilds its
/// subtree when necessary. It also displays a loading overlay when the controller
/// is loading or refreshing.
class DecKReferenceProvider extends StatefulWidget {
  /// Creates a [DecKReferenceProvider] with the given [controller] and [child].
  const DecKReferenceProvider({
    super.key,
    required this.child,
    required this.baseStyle,
    required this.examples,
    required this.styles,
  });

  /// A unique key used to identify this [DecKReferenceProvider] instance.
  static final _uniqueKey = UniqueKey();

  /// Creates a [DecKReferenceProvider] by inheriting the [DeckReferenceController] from the given [context].
  ///
  /// This method is useful when you want to create a [DecKReferenceProvider] with
  /// the same [DeckReferenceController] as an ancestor [DecKReferenceProvider].
  static DecKReferenceProvider inherit({
    required BuildContext context,
    required Widget child,
  }) {
    final controller = DecKReferenceProvider.read(context);
    return DecKReferenceProvider(
      styles: controller.styles,
      baseStyle: controller.baseStyle,
      examples: controller.examples,
      child: child,
    );
  }

  final Style baseStyle;

  final Map<String, ExampleBuilder> examples;

  final Map<String, Style> styles;

  /// Returns the [DeckReferenceController] associated with the nearest ancestor [DecKReferenceProvider].
  /// If no [DecKReferenceProvider] is found, an error is thrown.
  ///
  /// If you want to create a [DecKReferenceProvider] with the same [DeckReferenceController]
  static DeckReferenceController watch(BuildContext context) {
    return of(context, listen: true)!;
  }

  /// Returns the [DeckReferenceController] associated with the nearest ancestor [DecKReferenceProvider].
  /// Without listening to changes in the [DeckReferenceController].
  static DeckReferenceController read(BuildContext context) {
    return of(context, listen: false)!;
  }

  static DeckReferenceController? of(
    BuildContext context, {
    bool listen = true,
  }) {
    final inheritedWidget = listen
        ? context
            .dependOnInheritedWidgetOfExactType<_ReferenceControllerInherited>()
        : context
            .getElementForInheritedWidgetOfExactType<
                _ReferenceControllerInherited>()
            ?.widget as _ReferenceControllerInherited?;

    return inheritedWidget?.controller;
  }

  /// The widget below this [DecKReferenceProvider] in the tree.
  final Widget child;

  @override
  State<DecKReferenceProvider> createState() => _DecKReferenceProviderState();
}

class _DecKReferenceProviderState extends State<DecKReferenceProvider> {
  /// The [DeckReferenceController] instance associated with this [DecKReferenceProvider].
  late DeckReferenceController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DeckReferenceController(
      styles: widget.styles,
      baseStyle: widget.baseStyle,
      examples: widget.examples,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return _ReferenceControllerInherited(
          controller: _controller,
          child: Stack(
            key: DecKReferenceProvider._uniqueKey,
            children: [
              ConditionalWidget(
                condition: _controller.hasData,
                fallback: const SizedBox(),
                child: widget.child,
              ),
              LoadingOverlay(
                isLoading: _controller.isLoading || _controller.isRefreshing,
              ),
            ],
          ),
        );
      },
    );
  }
}

extension BuildContextSuperDeckControllerExtension on BuildContext {
  DeckReferenceController get deck {
    return DecKReferenceProvider.watch(this);
  }
}
