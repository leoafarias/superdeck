import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../services/reference_service.dart';

final superDeckController = SuperDeckController.instance;

class SuperDeckController {
  SuperDeckController._();

  static final instance = SuperDeckController._();

  bool _initialized = false;

  static Future<void> initialize() async {
    if (instance._initialized) return;
    instance._initialized = true;
    await instance._loadData();
    ReferenceService.instance.listen(instance._getData.refresh);
  }

  late final _getData = futureSignal(_loadData);

  late final isLoading = computed(() => _getData.value.isLoading);
  late final isRefreshing = computed(() => _getData.value.isRefreshing);
  late final hasError = computed(() => _getData.value.hasError);
  late final isDone = computed(() => _getData.value.hasValue);

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
  final state = useState<T>(signal.value);
  final context = useContext();
  useEffect(() {
    signal.listen(context, () {
      state.value = signal.value;
    });
  }, [signal]);
  return state.value;
}

final useSlides = () => useSignal(superDeckController.slides);

extension SignalX<T> on Signal<T> {
  Widget build(Widget Function(T) builder) {
    return Watch.builder(
      builder: (context) => builder(value),
    );
  }
}
