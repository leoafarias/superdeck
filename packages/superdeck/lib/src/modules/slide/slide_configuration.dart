import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/helpers/controller.dart';
import 'slide_parts.dart';

class SlideController extends Controller {
  final int slideIndex;
  final FixedSlidePart? header;
  final FixedSlidePart? footer;
  final SlidePart? background;
  final Style style;
  final Slide slide;

  SlideController({
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
