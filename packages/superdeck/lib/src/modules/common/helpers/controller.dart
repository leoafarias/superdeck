import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Base class for controllers that extends [ChangeNotifier].
///
/// Controllers should extend this class to be used with [ControllerProvider].
abstract class Controller extends ChangeNotifier {
  /// Retrieves the controller of type [T] from the nearest [ControllerProvider].
  ///
  /// Throws a [FlutterError] if no [ControllerProvider] is found in the context.
  static T of<T extends Controller>(BuildContext context) {
    final controller = maybeOf<T>(context);

    if (controller == null) {
      throw FlutterError('The controller (notifier) in Provider<$T> is null');
    }
    return controller;
  }

  /// Retrieves the controller of type [T] from the nearest [ControllerProvider], or null if not found.
  static T? maybeOf<T extends Controller>(BuildContext context) {
    final ControllerProvider<T>? provider =
        context.dependOnInheritedWidgetOfExactType<ControllerProvider<T>>();

    if (T == Controller) {
      throw FlutterError('You should provide a type for the controller');
    }
    return provider?.notifier;
  }
}

/// An [InheritedNotifier] that provides an [Controller] to its descendants.
///
/// Widgets can access the controller using [ControllerProvider.of] or [ControllerProvider.maybeOf].
class ControllerProvider<T extends Controller> extends InheritedNotifier<T> {
  /// Creates an [ControllerProvider] that provides the [controller] to its descendants.
  ///
  /// The [controller] must not be null.
  const ControllerProvider({
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

class Provider<T> extends InheritedWidget {
  final T data;

  const Provider({
    super.key,
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant Provider<T> oldWidget) {
    return oldWidget.data != data;
  }

  static T of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<Provider<T>>();

    if (provider == null) {
      throw FlutterError('The provider in Provider<$T> is null');
    }
    return provider.data;
  }

  static T? maybeOf<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<Provider<T>>();

    return provider?.data;
  }
}
