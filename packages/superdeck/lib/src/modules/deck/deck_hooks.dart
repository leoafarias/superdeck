import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/helpers/extensions.dart';
import '../navigation/navigation_hooks.dart';
import 'deck_controller.dart';
import 'deck_provider.dart';

DeckController _useController() {
  final context = useContext();

  return useListenable(context.watch<DeckProvider>().controller);
}

T _useSelectController<T>(T Function(DeckController) selector) {
  final controller = _useController();
  return selector(controller);
}

List<Slide> useSlides() {
  return _useSelectController((controller) => controller.slides);
}

Slide useGetSlide(int index) {
  return _useSelectController((controller) => controller.slides[index]);
}

int useGetSlideIndex(Slide slide) {
  return _useSelectController((controller) => controller.slides.indexOf(slide));
}

List<SlideAsset> useAssets() {
  return _useSelectController((controller) => controller.assets);
}

({SlidePart? header, SlidePart? footer}) useGetParts() {
  return _useSelectController(
    (controller) => (
      header: controller.header,
      footer: controller.footer,
    ),
  );
}

Style useGetSlideStyle(Slide slide) {
  return _useSelectController(
    (controller) => controller.getStyle(
      slide.options?.style,
    ),
  );
}

Slide useCurrentSlide() {
  final index = useCurrentSlideIndex();
  return useGetSlide(index);
}

Slide? useNextSlide() {
  final totalSlides = useSlides().length;
  final index = useCurrentSlideIndex();

  if (index + 1 >= totalSlides) {
    return null;
  }

  return useGetSlide(index + 1);
}

ExampleBuilder? useDeckExamples(String name) {
  return _useSelectController(
    (controller) => controller.getExampleWidget(name),
  );
}

double useTotalPartsHeight() {
  final builders = useGetParts();
  final headerHeight = builders.header?.height ?? 0;
  final footerHeight = builders.footer?.height ?? 0;

  return headerHeight + footerHeight;
}
