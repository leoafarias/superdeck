import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:superdeck_cli/src/constants.dart';
import 'package:superdeck_cli/src/helpers/short_hash_id.dart';
import 'package:superdeck_cli/src/helpers/types.dart';
import 'package:superdeck_cli/src/services/mermaid_service.dart';

final _mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');

typedef PipelineResult = ({
  List<RawSlide> slides,
  List<RawAsset> neededAssets,
});

class TaskController {
  final RawSlide slide;
  final List<RawAsset> _assets;

  TaskController({
    required this.slide,
    required List<RawAsset> assets,
  }) : _assets = assets;

  List<RawAsset> neededAssets = [];

  TaskController copyWith({
    RawSlide? slide,
    List<RawAsset>? assets,
  }) {
    return TaskController(
      slide: slide ?? this.slide,
      assets: assets ?? _assets,
    )..neededAssets = neededAssets;
  }

  void markFileAsNeeded(File file) {
    final asset = _assets.firstWhereOrNull((f) => f.path == file.path);

    if (asset != null) {
      markNeeded(asset);
    } else {
      img.decodePngFile(file.path).then((image) {
        final asset = RawAsset(
          path: file.path,
          width: image!.width,
          height: image.height,
        );

        markNeeded(asset);
      });
    }
  }

  void markNeeded(RawAsset asset) {
    neededAssets.add(asset);
  }
}

class SlidesPipeline {
  final List<Task> processors;

  SlidesPipeline(this.processors);

  Future<PipelineResult> run(
    List<RawSlide> slides,
    List<RawAsset> assets,
  ) async {
    final futures = <Future<TaskController>>[];

    Future<TaskController> runEachSlide(RawSlide slide) async {
      var controller = TaskController(slide: slide, assets: assets);
      for (var task in processors) {
        controller = await task.run(controller);
      }
      return controller;
    }

    for (var slide in slides) {
      futures.add(runEachSlide(slide));
    }

    final controllers = await Future.wait(futures);

    final result = (
      slides: controllers.map((e) => e.slide).toList(),
      neededAssets: controllers.expand((e) => e.neededAssets).toList(),
    );

    return result;
  }
}

abstract class Task {
  final String taskName;
  const Task(this.taskName);

  FutureOr<TaskController> run(
    TaskController controller,
  );

  String buildReferenceName(String content) {
    return shortHashId(content);
  }

  File buildAssetFile(String assetName) {
    if (p.extension(assetName).isEmpty) {
      assetName = '$assetName.png';
    }
    final updatedFileName = ('sd_${taskName}_$assetName');
    return File(p.join(kGeneratedAssetsDir.path, updatedFileName));
  }

  bool isAssetFile(File file) {
    // check if file name starts with sd_
    if (!file.path.startsWith(kGeneratedAssetsDir.path)) {
      return false;
    }

    final fileName = p.basename(file.path);
    return fileName.startsWith('sd_');
  }
}

class SlideThumbnailTask extends Task {
  const SlideThumbnailTask() : super('thumbnail');

  @override
  FutureOr<TaskController> run(controller) async {
    final file = buildAssetFile(controller.slide.key);

    if (await file.exists()) {
      controller.markFileAsNeeded(file);
    }

    return controller;
  }
}

class MermaidConverterTask extends Task {
  final _mermaidService = MermaidService();
  MermaidConverterTask() : super('mermaid');

  @override
  FutureOr<TaskController> run(controller) async {
    final slide = controller.slide;

    final matches = _mermaidBlockRegex.allMatches(slide.content);

    if (matches.isEmpty) return controller;
    final replacements = <({int start, int end, String markdown})>[];

    for (final Match match in matches) {
      final mermaidSyntax = match.group(1);

      if (mermaidSyntax == null) continue;

      final mermaidFile = buildAssetFile(buildReferenceName(mermaidSyntax));

      if (!await mermaidFile.exists()) {
        // Process the mermaid syntax to generate an image file
        final imageData = await _mermaidService.generateImage(mermaidSyntax);

        if (imageData != null) {
          await mermaidFile.writeAsBytes(imageData);
        }
      }

      // If file existeed or was create it then replace it
      if (await mermaidFile.exists()) {
        controller.markFileAsNeeded(mermaidFile);

        replacements.add((
          start: match.start,
          end: match.end,
          markdown: '![Mermaid Diagram](${mermaidFile.path})',
        ));
      }
    }

    var replacedData = slide.content;

    // Apply replacements in reverse order
    for (var replacement in replacements.reversed) {
      final (
        :start,
        :end,
        :markdown,
      ) = replacement;

      replacedData = replacedData.replaceRange(start, end, markdown);
    }

    return controller.copyWith(
      slide: slide.copyWith(content: replacedData),
    );
  }
}
