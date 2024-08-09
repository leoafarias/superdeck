import 'dart:async';

import 'package:superdeck_cli/src/slides_pipeline.dart';

/// This task marks the thumbnail file as needed if it exists.
/// The goal is to ensure that any generated thumbnails are kept.
class SlideThumbnailTask extends Task {
  const SlideThumbnailTask() : super('thumbnail');

  @override
  FutureOr<TaskController> run(controller) async {
    final file = buildAssetFile(controller.slide.key);

    if (await file.exists()) {
      await controller.markFileAsNeeded(file);
    }

    return controller;
  }
}
