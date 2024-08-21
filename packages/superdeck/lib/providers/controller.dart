import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../services/reference_service.dart';

final $superdeck = SuperDeckController.instance;

class SuperDeckController extends ChangeNotifier {
  SuperDeckController._();

  static final instance = SuperDeckController._();

  bool _initialized = false;

  static Future<void> initialize() async {
    if (instance._initialized) return;
    instance._initialized = true;
    await instance._loadData();
    ReferenceService.instance.listen(instance.refresh);
  }

  bool _loading = false;
  Object? _error;
  List<Slide> _slides = [];
  List<SlideAsset> _assets = [];
  bool _completed = false;
  bool _isRefreshing = false;

  bool get loading => _loading;
  Object? get error => _error;
  List<Slide> get slides => _slides;
  List<SlideAsset> get assets => _assets;
  bool get completed => _completed;
  bool get isRefreshing => _isRefreshing;

  Future<void> _loadData() async {
    _loading = _isRefreshing ? false : true;
    _error = null;
    _completed = false;
    notifyListeners();

    try {
      final data = await ReferenceService.instance.loadReference();

      _slides = data.slides;
      _assets = data.assets;
    } catch (e) {
      _error = e;
    } finally {
      _completed = true;
      _loading = false;
      _isRefreshing = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    _isRefreshing = true;
    await _loadData();
  }
}

T useSuperdeckSelector<T>(T Function(SuperDeckController) selector) {
  return useListenableSelector(
    $superdeck,
    () => selector($superdeck),
  );
}

List<Slide> useSlides() {
  return useListenableSelector(
    $superdeck,
    () => $superdeck.slides,
  );
}
