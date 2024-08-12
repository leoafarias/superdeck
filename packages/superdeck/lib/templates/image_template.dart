part of 'templates.dart';

class ImageTemplate extends SplitTemplateBuilder<ImageSlide> {
  const ImageTemplate(
    super.model, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final spec = SlideSpec.of(context);
    final src = config.options.src;
    final boxFit = config.options.fit?.toBoxFit() ?? spec.image.fit;

    // THis slide breaks in half and I want to calculate the size based on if its in top or bottom
    // or left or right. Also there is a property called flex which is how much of the slide it takes
    // so I can use that to calculate the size of the canvas
    final firstHalf = config.contentOptions?.flex ?? defaultFlex;
    final imageHalf = config.options.flex;

// available size const width = 1280.0;
//const height = 720.0;

    double width;
    double height;
    const availableSize = kResolution;
    if (config.options.position.isHorizontal()) {
      width = availableSize.width * firstHalf / (firstHalf + imageHalf);
      height = availableSize.height;
    } else {
      width = availableSize.width;
      height = availableSize.height * firstHalf / (firstHalf + imageHalf);
    }

    final side = Container(
      height: spec.image.height ?? height,
      width: spec.image.width ?? width,
      alignment: spec.image.alignment,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: getImageProvider(src),
          centerSlice: spec.image.centerSlice,
          repeat: spec.image.repeat ?? ImageRepeat.noRepeat,
          filterQuality: spec.image.filterQuality ?? FilterQuality.low,
          fit: boxFit,
        ),
      ),
    );

    return buildSplitSlide(side);
  }
}
