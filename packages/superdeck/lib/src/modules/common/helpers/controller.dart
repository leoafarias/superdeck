import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Base class for controllers that extends [ChangeNotifier].
///
/// Controllers should extend this class to be used with [Provider].
abstract class Controller extends ChangeNotifier {
  // No static methods here; access the controller via SdProvider.of<T>(context).
}

/// An [InheritedNotifier] that provides an [Controller] to its descendants.
///
/// Widgets can access the controller using [Provider.of] or [Provider.maybeOf].
class Provider<T extends Controller> extends InheritedNotifier<T> {
  /// Creates an [Provider] that provides the [controller] to its descendants.
  ///
  /// The [controller] must not be null.
  const Provider({
    super.key,
    required T controller,
    required super.child,
  }) : super(notifier: controller);

  /// Retrieves the controller of type [T] from the nearest [Provider].
  ///
  /// Throws a [FlutterError] if no [Provider] is found in the context.
  static T of<T extends Controller>(BuildContext context) {
    final controller = maybeOf<T>(context);

    if (controller == null) {
      throw FlutterError('The controller (notifier) in Provider<$T> is null');
    }
    return controller;
  }

  /// Retrieves the controller of type [T] from the nearest [Provider], or null if not found.
  static T? maybeOf<T extends Controller>(BuildContext context) {
    final Provider<T>? provider =
        context.dependOnInheritedWidgetOfExactType<Provider<T>>();
    return provider?.notifier;
  }
}

/// An [InheritedNotifier] that provides an [Controller] to its descendants.
///
/// Widgets can access the controller using [Provider.of] or [Provider.maybeOf].
class Provider<T extends Controller> extends InheritedNotifier<T> {
  /// Creates an [Provider] that provides the [controller] to its descendants.
  ///
  /// The [controller] must not be null.
  const Provider({
    super.key,
    required T controller,
    required super.child,
  }) : super(notifier: controller);
}

T useController<T extends Controller>() {
  final context = useContext();

  return Controller.of<T>(context);
}

T useSelector<P extends Controller, T>(T Function(P) selector) {
  final controller = useController<P>();
  return useListenableSelector(
    controller,
    () => selector(controller),
  );
}
