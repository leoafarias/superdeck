import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../helpers/dependency_injection.dart';
import '../services/reference_service.dart';

final superDeckController = getIt.get<SuperDeckController>();

class SuperDeckController {
  SuperDeckController() {
    ReferenceService.instance.listen(_getData.refresh);
  }

  late final _getData = futureSignal(_loadData, lazy: false);

  late final isLoading = _getData.select((s) => s.value.isLoading);
  late final isRefreshing = _getData.select((s) => s.value.isRefreshing);
  late final hasError = _getData.select((s) => s.value.hasError);
  late final isDone = _getData.select((s) => s.value.hasValue);

  final slides = signal<List<Slide>>([]);
  final assets = signal<List<SlideAsset>>([]);

  Future<void> _loadData() async {
    final data = await ReferenceService.instance.loadReference();

    batch(() {
      slides.assign(data.slides);
      assets.assign(data.assets);
    });
  }
}

extension on Signal<List> {
  void assign(List value) {
    if (listEquals(value, this.value)) {
      return;
    }
    this.value = value;
  }
}

T useSignal<T>(Signal<T> signal) {
  final context = useContext();

  return signal.watch(context);
}

final useSlides = () => useSignal(superDeckController.slides);

extension SignalX<T> on Signal<T> {
  Widget build(Widget Function(T) builder) {
    return Watch.builder(
      builder: (context) => builder(value),
    );
  }
}

// coverage:ignore-start
/// Logs all signals and computed changes to the console.
class LoggingSignalsObserver extends SignalsObserver {
  @override
  void onComputedCreated(Computed instance) {
    log('computed created: [${instance.globalId}|${instance.debugLabel}]');
  }

  @override
  void onComputedUpdated(Computed instance, value) {
    log('computed updated: [${instance.globalId}|${instance.debugLabel}] => $value');
  }

  @override
  void onSignalCreated(Signal instance) {
    log('signal created: [${instance.globalId}|${instance.debugLabel}] => ${instance.peek()}');
  }

  @override
  void onSignalUpdated(Signal instance, value) {
    log('signal updated: [${instance.globalId}|${instance.debugLabel}] => $value');
  }

  @override
  void onEffectCreated(Effect instance) {
    log('effect created: [${instance.globalId}|${instance.debugLabel}]');
  }

  @override
  void onEffectCalled(Effect instance) {
    log('effect called: [${instance.globalId}|${instance.debugLabel}]');
  }

  @override
  void onEffectRemoved(Effect instance) {
    log('effect removed: [${instance.globalId}|${instance.debugLabel}]');
  }

  /// Logs a message to the console.
  void log(String message) => log(message);
}
// coverage:ignore-end
