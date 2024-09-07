import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/helpers/extensions.dart';
import 'deck_reference_controller.dart';
import 'deck_reference_provider.dart';

DeckReferenceController _useController() {
  final context = useContext();

  return useListenable(context.watch<DeckReferenceProvider>().controller);
}

T _useSelectController<T>(T Function(DeckReferenceController) selector) {
  final controller = _useController();
  return selector(controller);
}

List<Slide> useDeckSlides() {
  return _useSelectController((controller) => controller.slides);
}

List<SlideAsset> useAssets() {
  return _useSelectController((controller) => controller.assets);
}

Style useDeckStyle(Slide slide) {
  return _useSelectController(
    (controller) => controller.getStyle(
      slide.options?.style,
    ),
  );
}

ExampleBuilder? useDeckExamples(String name) {
  return _useSelectController(
    (controller) => controller.getExampleWidget(name),
  );
}
