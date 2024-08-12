import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:superdeck_cli/src/constants.dart';
import 'package:superdeck_cli/src/helpers/extensions.dart';
import 'package:superdeck_cli/src/helpers/pretty_json.dart';
import 'package:superdeck_cli/src/helpers/raw_models.dart';
import 'package:superdeck_cli/src/helpers/short_hash_id.dart';
import 'package:superdeck_cli/src/helpers/slide_parser.dart';

typedef MarkdownReplacement = ({
  Pattern pattern,
  String replacement,
});

typedef PipelineResult = ({
  List<RawSlide> slides,
  List<RawAsset> neededAssets,
  List<MarkdownReplacement> markdownReplacements,
});

class TaskController {
  final RawSlide slide;
  final List<RawAsset> _assets;
  final List<MarkdownReplacement> markdownReplacements;

  TaskController._({
    required this.slide,
    required List<RawAsset> assets,
    required this.markdownReplacements,
  }) : _assets = assets;

  TaskController({
    required this.slide,
    required List<RawAsset> assets,
  })  : _assets = assets,
        markdownReplacements = [];

  List<RawAsset> neededAssets = [];

  RawAsset? checkAssetExists(String assetName) {
    return _assets
        .firstWhereOrNull((element) => element.path.contains(assetName));
  }

  TaskController copyWith({
    RawSlide? slide,
    List<RawAsset>? assets,
    List<MarkdownReplacement>? markdownReplacements,
  }) {
    return TaskController._(
      slide: slide ?? this.slide,
      markdownReplacements: markdownReplacements ?? this.markdownReplacements,
      assets: assets ?? _assets,
    )..neededAssets = neededAssets;
  }

  Future<void> markFileAsNeeded(File file, [String? reference]) async {
    var asset = _assets.firstWhereOrNull((f) => f.path == file.path);

    if (asset == null) {
      print(file.path);
      final image = await img.decodeImageFile(file.path);
      if (image == null) {
        throw Exception('Could not decode image');
      }

      asset = RawAsset(
        path: file.path,
        width: image.width,
        height: image.height,
        reference: reference,
      );
    } else {
      if (!await file.exists()) {
        throw Exception('File does not exist');
      }
    }
    markNeeded(asset);
  }

  void markNeeded(RawAsset asset) {
    neededAssets.add(asset);
  }
}

class TaskPipeline {
  final List<Task> builders;

  TaskPipeline(
    this.builders,
  );

  Future<TaskController> _runEachSlide(
    RawSlide slide,
    List<RawAsset> assets,
  ) async {
    var controller = TaskController(slide: slide, assets: assets);
    for (var task in builders) {
      controller = await task.run(controller);
    }
    return controller;
  }

  Future<PipelineResult> run() async {
    await kMarkdownFile.ensureExists();
    await kGeneratedAssetsDir.ensureExists();
    await kReferenceFile.ensureExists();
    final markdownRaw = kMarkdownFile.readAsStringSync();

    final reference = RawReference.loadFile(kReferenceFile);
    final rawAssets = reference.assets;

    final parser = SlideParser(markdownRaw);
    final slides = parser.run();

    final futures = <Future<TaskController>>[];

    for (var slide in slides) {
      futures.add(_runEachSlide(slide, rawAssets));
    }

    final controllers = await Future.wait(futures);

    final result = (
      slides: controllers.map((e) => e.slide).toList(),
      neededAssets: controllers.expand((e) => e.neededAssets).toList(),
      markdownReplacements:
          controllers.expand((e) => e.markdownReplacements).toList(),
    );

    await _applyResults(result);

    return result;
  }
}

Future<void> _applyResults(PipelineResult result) async {
  final config = RawConfig.loadFile(kProjectConfigFile);
  await _applyMarkdownReplacements(result.markdownReplacements);
  await _cleanupGeneratedFiles(result.neededAssets);
  await kReferenceFile.writeAsString(
    prettyJson(
      {
        'config': config.toMap(),
        'slides': result.slides.map((e) => e.toMap()).toList(),
        'assets': result.neededAssets.map((e) => e.toMap()).toList(),
      },
    ),
  );
}

Future<void> _cleanupGeneratedFiles(List<RawAsset> assets) async {
  final files = await _loadGeneratedFiles();

  for (var file in files) {
    if (!assets.any((element) => element.path == file.path)) {
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}

Future<void> _applyMarkdownReplacements(
  List<MarkdownReplacement> replacements,
) async {
  var markdownRaw = await kMarkdownFile.readAsString();

  for (final entry in replacements) {
    markdownRaw = markdownRaw.replaceAll(entry.pattern, entry.replacement);
  }

  await kMarkdownFile.writeAsString(markdownRaw);
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
    final updatedFileName = ('${taskName}_$assetName');
    return File(p.join(kGeneratedAssetsDir.path, updatedFileName));
  }

  bool isAssetFile(File file) {
    // check if file name starts with sd_
    return file.path.contains(kGeneratedAssetsDir.path);
  }
}

Future<List<File>> _loadGeneratedFiles() async {
  final files = <File>[];

  await for (var entity in kGeneratedAssetsDir.list()) {
    if (entity is File) {
      files.add(entity);
    }
  }

  return files;
}
