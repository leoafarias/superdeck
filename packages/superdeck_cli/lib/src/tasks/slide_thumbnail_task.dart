import 'dart:async';

import 'package:superdeck_cli/src/generator_pipeline.dart';

/// This task marks the thumbnail file as needed if it exists.
/// The goal is to ensure that any generated thumbnails are kept.
class SlideThumbnailTask extends Task {
  const SlideThumbnailTask() : super('thumbnail');

  @override
  FutureOr<TaskContext> run(controller) async {
    final file = controller.slide.thumbnailFile;

    if (await file.exists()) {
      await controller.saveAsAsset(file);
    }
    return controller;
  }
}
