import 'package:superdeck_core/superdeck_core.dart';

import '../common/helpers/controller.dart';
import '../navigation/navigation_hooks.dart';
import '../slide/slide_configuration.dart';
import 'deck_controller.dart';

T _useSelectController<T>(T Function(DeckController) selector) {
  final controller = useController<DeckController>();
  return selector(controller);
}

List<SlideController> useSlides() {
  return _useSelectController((controller) => controller.slides);
}

SlideController useCurrentSlide() {
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
