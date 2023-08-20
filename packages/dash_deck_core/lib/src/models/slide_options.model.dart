import 'package:freezed_annotation/freezed_annotation.dart';

part 'slide_options.model.freezed.dart';
part 'slide_options.model.g.dart';

enum SlideLayout { none, cover, contentLeft, contentRight }

enum ImageFit { cover, contain, fill, fitHeight, fitWidth, none, scaleDown }

enum VerticalAlignment { top, center, bottom }

enum ContentAlignment {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight
}

enum HorizontalAlignment { left, center, right }

@freezed
class SlideOptions with _$SlideOptions {
  const SlideOptions._();
  const factory SlideOptions({
    @Default(false) bool scrollable,
    @Default(SlideLayout.none) SlideLayout layout,
    String? image,
    @Default(ImageFit.cover) ImageFit imageFit,
    @Default(ContentAlignment.center) ContentAlignment contentAlignment,
    String? styles,
  }) = _SlideOptions;

  factory SlideOptions.fromJson(Map<String, dynamic> json) =>
      _$SlideOptionsFromJson(json);

  static List<String> get availableOptions => [
        'scrollable',
        'layout',
        'image',
        'imageFit',
        'contentAlignment',
        'styles',
      ];
}
