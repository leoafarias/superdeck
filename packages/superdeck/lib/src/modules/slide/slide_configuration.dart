import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import 'slide_parts.dart';

class SlideData {
  final int slideIndex;
  final FixedSlidePart? header;
  final FixedSlidePart? footer;
  final SlidePart? background;
  final Style style;
  final Slide slide;

  SlideData({
    required this.slideIndex,
    this.header,
    this.footer,
    this.background,
    required this.style,
    required this.slide,
  });

  String get key => slide.key;

  List<SectionBlock> get sections => slide.sections;

  List<SlideNote> get notes => slide.notes;

  File get thumbnailFile => slide.thumbnailFile;

  SlideOptions? get options => slide.options;

  SlideAsset? getAssetByReference(String contents) {
    final reference = assetHash(contents);

    return slide.assets.firstWhereOrNull((asset) =>
        asset.path == contents ||
        asset.reference == contents ||
        asset.reference == reference);
  }

  Widget buildHeader() {
    return _PartBuilder(header);
  }

  Widget buildFooter() {
    return _PartBuilder(footer);
  }

  Widget buildBackground() {
    return background ?? const SizedBox.shrink();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SlideData &&
        other.slideIndex == slideIndex &&
        other.header == header &&
        other.footer == footer &&
        other.background == background &&
        other.style == style &&
        other.slide == slide;
  }

  @override
  int get hashCode {
    return slideIndex.hashCode ^
        header.hashCode ^
        footer.hashCode ^
        background.hashCode ^
        style.hashCode ^
        slide.hashCode;
  }
}

class _PartBuilder extends StatelessWidget {
  final SlidePart? part;

  const _PartBuilder(
    this.part,
  );

  @override
  Widget build(BuildContext context) {
    if (part == null) {
      return const SizedBox();
    }

    return part!;
  }
}
