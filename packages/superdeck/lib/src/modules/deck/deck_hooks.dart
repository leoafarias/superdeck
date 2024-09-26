import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../navigation/navigation_hooks.dart';
import '../slide/slide_configuration.dart';
import 'deck_controller.dart';

DeckController _useController() {
  final context = useContext();

  final controller = DeckController.of(context);

  return useListenable(controller);
}

T _useSelectController<T>(T Function(DeckController) selector) {
  final controller = _useController();
  return selector(controller);
}

List<SlideConfiguration> useSlides() {
  return _useSelectController((controller) => controller.slides);
}

SlideConfiguration useCurrentSlide() {
  final index = useCurrentSlideIndex();
  return _useSelectController((controller) => controller.slides[index]);
}

List<SlideAsset> useAssets() {
  return _useSelectController((controller) => controller.assets);
}

// SlideConfiguration useCurrentSlide() {
//   final index = useCurrentSlideIndex();
//   return useSlideConfiguration(index);
// }

WidgetBuilderWithOptions? useDeckExamples(String name) {
  return _useSelectController(
    (controller) => controller.getWidget(name),
  );
}

double useTotalPartsHeight() {
  return _useSelectController((controller) => controller.totalPartsHeight);
}
