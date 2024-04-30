import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

import '../services/mermaid_service.dart';
import '../services/project_service.dart';
import '../superdeck.dart';

final _mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');

class PipelineAsset {
  final File asset;
  final Uint8List data;

  PipelineAsset({
    required this.asset,
    required this.data,
  });
}

typedef PipelineResult = ({
  List<Slide> slides,
  List<File> neededAssets,
});

class TaskController {
  final Slide slide;
  final List<File> _assets;

  TaskController({
    required this.slide,
    required List<File> assets,
  }) : _assets = assets;

  List<File> neededAssets = [];

  TaskController copyWith({
    Slide? slide,
    List<File>? assets,
  }) {
    return TaskController(
      slide: slide ?? this.slide,
      assets: assets ?? _assets,
    )..neededAssets = neededAssets;
  }

  void markNeeded(File asset) {
    neededAssets.add(asset);
  }
}

class SlidesPipeline {
  final List<Task> processors;

  SlidesPipeline(this.processors);

  Future<PipelineResult> run(
    List<Slide> slides,
    List<File> assets,
  ) async {
    final futures = <Future<TaskController>>[];

    Future<TaskController> runEachSlide(Slide slide) async {
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
  const Task();

  FutureOr<TaskController> run(
    TaskController controller,
  );
}

class SlideThumbnailTask extends Task {
  const SlideThumbnailTask();

  @override
  FutureOr<TaskController> run(controller) async {
    final file = SlideAsset.thumbnail(controller.slide);

    if (await file.exists()) {
      controller.markNeeded(file);
    }

    return controller;
  }
}

class MermaidConverterTask extends Task {
  const MermaidConverterTask();

  @override
  FutureOr<TaskController> run(controller) async {
    final slide = controller.slide;

    final matches = _mermaidBlockRegex.allMatches(slide.data);

    if (matches.isEmpty) return controller;
    final replacements = <({int start, int end, String markdown})>[];

    for (final Match match in matches) {
      final mermaidSyntax = match.group(1);

      if (mermaidSyntax == null) continue;

      final mermaidFile = SlideAsset.mermaid(mermaidSyntax);

      if (!await mermaidFile.exists()) {
        // Process the mermaid syntax to generate an image file
        final imageData = await mermaidService.generateImage(mermaidSyntax);

        if (imageData != null) {
          await mermaidFile.writeAsBytes(imageData);
        }
      }

      // If file existeed or was create it then replace it
      if (await mermaidFile.exists()) {
        controller.markNeeded(mermaidFile);

        replacements.add((
          start: match.start,
          end: match.end,
          markdown: '![Mermaid Diagram](${mermaidFile.path})',
        ));
      }
    }

    var replacedData = slide.data;

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
      slide: slide.copyWith(data: replacedData),
    );
  }
}

class ImageCachingTask extends Task {
  const ImageCachingTask();

  @override
  Future<TaskController> run(controller) async {
    final slide = controller.slide;

    var content = slide.data;
    // Do not cache remot edata if cacheRemoteAssets is false

    // Get any url of images that are in the markdown
    // Save it the local path on the device
    // and replace the url with the local path
    final imageRegex = RegExp(r'!\[.*?\]\((.*?)\)');

    final matches = imageRegex.allMatches(content);

    Future<void> saveAsset(String url) async {
      if (ProjectService.instance.isAssetFile(File(url))) return;
      // Look by hashcode to see if the asset is already cached

      final file = SlideAsset.cached(url);

      if (await file.exists()) {
        controller.markNeeded(file);
        return;
      }

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();

      final contentType = response.headers.contentType;
      // Default to .jpg if no extension is found
      var assetData = await consolidateHttpClientResponseBytes(response);
      final extension = contentType?.subType ?? 'jpg';

      final fileType = AssetFileType.tryParse(extension);

      if (fileType == null) {
        log('Invalid file type: $extension');
        return;
      }

      final codec = await ui.instantiateImageCodec(assetData);

      if (codec.frameCount > 1) {
        // get half of the frame count
        final frameCount = codec.frameCount ~/ 2;

        for (var i = 0; i < frameCount; i++) {
          await codec.getNextFrame();
        }
        final frame = await codec.getNextFrame();

        final bytes =
            await frame.image.toByteData(format: ui.ImageByteFormat.png);
        assetData = bytes!.buffer.asUint8List();
      }

      await file.writeAsBytes(assetData);

      controller.markNeeded(file);
    }

    for (final Match match in matches) {
      final assetUri = match.group(1);
      if (assetUri == null) continue;

      await saveAsset(assetUri);
    }

    final background = slide.background;

    if (background != null) {
      await saveAsset(background);
    }

    if (slide is ImageSlide) {
      final imageSource = slide.options.src;
      await saveAsset(imageSource);
    }

    return controller;
  }
}
