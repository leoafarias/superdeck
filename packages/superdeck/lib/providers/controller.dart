import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../components/atoms/conditional_widget.dart';
import '../components/atoms/loading_indicator.dart';
import '../helpers/async_value.dart';
import '../services/reference_service.dart';
import '../styles/style_util.dart';

class SuperDeckController extends ChangeNotifier {
  final _referenceService = ReferenceService();
  final Map<String, Style> _styles;
  final Map<String, ExampleBuilder> examples;
  late final Style _style;

  AsyncValue<ReferenceDto> _asyncData = const AsyncValue.loading();
  SuperDeckController({
    required Map<String, Style> styles,
    required Style baseStyle,
    required this.examples,
  }) : _styles = styles {
    _style = defaultStyle.merge(baseStyle);

    _loadReferences();
    _referenceService.listen(_loadReferences);
  }

  static SuperDeckController of(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<_SuperdeckControllerInherited>();
    if (inherited == null) {
      throw Exception('SuperDeckController not found in context');
    }
    return inherited.controller;
  }

  bool get isLoading => _asyncData.isLoading;

  bool get isRefreshing => _asyncData.isRefreshing;

  bool get hasError => _asyncData.hasError;

  bool get hasData => _asyncData.hasValue;

  List<Slide> get slides => _asyncData.requireData.slides;

  List<SlideAsset> get assets => _asyncData.requireData.assets;

  Style get style => _style;

  Style getStyle(String? name) {
    return _style.merge(_styles[name]);
  }

  ExampleBuilder? getExampleWidget(String name) {
    return examples[name];
  }

  SlideAsset? getImageAsset(
    Uri uri, {
    Size? targetSize,
  }) {
    return assets.firstWhereOrNull((f) => f.matches(uri.toString()));
  }

  Future<void> _loadReferences() async {
    try {
      _asyncData = _asyncData.copyWith(status: AsyncStatus.loading);
      notifyListeners();

      _asyncData = _asyncData.copyWith(
        status: AsyncStatus.sucess,
        data: await _referenceService.loadReference(),
      );
    } catch (error, stackTrace) {
      _asyncData = AsyncValue.error(error, stackTrace);
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();

    _referenceService.stop();
  }
}

typedef ExampleBuilder = Widget Function(
  BuildContext context,
  WidgetOptions options,
);

extension BuildContextSuperDeckControllerExtension on BuildContext {
  SuperDeckController get superdeck {
    return SuperDeckController.of(this);
  }
}

class _SuperdeckControllerInherited extends InheritedNotifier {
  const _SuperdeckControllerInherited({
    required this.controller,
    required super.child,
  });

  final SuperDeckController controller;
}

class SuperDeckProvider extends StatelessWidget {
  const SuperDeckProvider({
    super.key,
    required this.child,
    required this.controller,
  });

  static final _uniqueKey = UniqueKey();

  static SuperDeckProvider inherit({
    required BuildContext context,
    required Widget child,
  }) {
    final controller = SuperDeckController.of(context);
    return SuperDeckProvider(
      controller: controller,
      child: child,
    );
  }

  final Widget child;
  final SuperDeckController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          return _SuperdeckControllerInherited(
              controller: controller,
              child: Stack(
                key: _uniqueKey,
                children: [
                  ConditionalWidget(
                    condition: controller.hasData,
                    fallback: const SizedBox(),
                    child: child,
                  ),
                  LoadingOverlay(
                    isLoading: controller.isLoading || controller.isRefreshing,
                  ),
                ],
              ));
        });
  }
}

SuperDeckController _useController() {
  final context = useContext();

  return useListenable(SuperDeckController.of(context));
}

T _useSelectController<T>(T Function(SuperDeckController) selector) {
  final controller = _useController();
  return selector(controller);
}

List<Slide> useSlides() {
  return _useSelectController((controller) => controller.slides);
}

List<SlideAsset> useAssets() {
  return _useSelectController((controller) => controller.assets);
}

Style useStyle(Slide slide) {
  return _useSelectController(
    (controller) => controller.getStyle(
      slide.options?.style,
    ),
  );
}

ExampleBuilder? useExampleWidget(String name) {
  return _useSelectController(
    (controller) => controller.getExampleWidget(name),
  );
}
