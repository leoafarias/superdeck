import 'package:flutter/material.dart';

/// Base class for controllers that extends [ChangeNotifier].
///
/// Controllers should extend this class to be used with [Provider].
abstract class Controller extends ChangeNotifier {
  // No static methods here; access the controller via SdProvider.of<T>(context).
}

/// An [InheritedNotifier] that provides an [Controller] to its descendants.
///
/// Widgets can access the controller using [Provider.ofType] or [Provider.maybeOf].
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
  static T ofType<T extends Controller>(BuildContext context) {
    final Provider<T>? provider =
        context.dependOnInheritedWidgetOfExactType<Provider<T>>();
    if (provider == null) {
      throw FlutterError('No Provider<$T> found in context');
    }

    final T? controller = provider.notifier;
    if (controller == null) {
      throw FlutterError('The controller (notifier) in SdProvider<$T> is null');
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
