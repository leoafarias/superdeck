import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:puppeteer/puppeteer.dart';
import 'package:superdeck_cli/src/constants.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/helpers/extensions.dart';
import 'package:superdeck_cli/src/helpers/short_hash_id.dart';
import 'package:superdeck_cli/src/helpers/slide_parser.dart';
import 'package:superdeck_cli/src/parsers/section_parser/section_parsing.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:yaml_writer/yaml_writer.dart';

typedef MarkdownReplacement = ({
  Pattern pattern,
  String replacement,
});

typedef PipelineResult = ({
  List<Slide> slides,
  List<SlideAsset> neededAssets,
  List<MarkdownReplacement> markdownReplacements,
});

class TaskController {
  final Slide slide;
  final List<SlideAsset> _assets;
  final TaskPipeline pipeline;
  final List<MarkdownReplacement> markdownReplacements;

  Slide extractSlide() {
    final sections = parseSections(slide.content);

    final newSlide = Slide(
      index: slide.index,
      content: slide.content,
      key: slide.key,
      options: slide.options,
      sections: sections,
    );

    return newSlide;
  }

  TaskController._({
    required this.slide,
    required List<SlideAsset> assets,
    required this.pipeline,
    required this.markdownReplacements,
  }) : _assets = assets;

  TaskController({
    required this.slide,
    required this.pipeline,
    required List<SlideAsset> assets,
  })  : _assets = assets,
        markdownReplacements = [];

  List<SlideAsset> neededAssets = [];

  SlideAsset? checkAssetExists(String assetName) {
    return _assets
        .firstWhereOrNull((element) => element.path.contains(assetName));
  }

  TaskController copyWith({
    Slide? slide,
    List<SlideAsset>? assets,
    List<MarkdownReplacement>? markdownReplacements,
  }) {
    return TaskController._(
      slide: slide ?? this.slide,
      pipeline: pipeline,
      markdownReplacements: markdownReplacements ?? this.markdownReplacements,
      assets: assets ?? _assets,
    )..neededAssets = neededAssets;
  }

  Future<void> markFileAsNeeded(File file, [String? reference]) async {
    var asset = _assets.firstWhereOrNull((f) => f.path == file.path);

    if (asset == null) {
      final image = await img.decodeImageFile(file.path);

      if (image == null) {
        throw Exception('Image could not be decoded');
      }

      asset = SlideAsset(
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

  void markNeeded(SlideAsset asset) {
    neededAssets.add(asset);
  }
}

class TaskPipeline {
  final List<Task> builders;

  Browser? _browser;

  TaskPipeline(
    this.builders,
  );

  Future<Browser> getBrowser() async {
    _browser ??= await puppeteer.launch();
    return _browser!;
  }

  Future<TaskController> _runEachSlide(
    TaskController controller,
  ) async {
    for (var task in builders) {
      controller = await task.build(controller);
    }
    return controller;
  }

  Future<ReferenceDto> run() async {
    await kMarkdownFile.ensureExists();
    await kGeneratedAssetsDir.ensureExists();
    await kReferenceFile.ensureExists();
    final markdownRaw = kMarkdownFile.readAsStringSync();

    // final loadedReference = SuperDeckReference.loadYaml(kReferenceFileYaml);
    final loadedReference = ReferenceDto.loadFile(kReferenceFile);

    final slides = SlideParser.run(markdownRaw);

    final futures = <Future<TaskController>>[];

    for (var i = 0; i < slides.length; i++) {
      final controller = TaskController(
        slide: slides[i],
        assets: loadedReference.assets,
        pipeline: this,
      );
      futures.add(_runEachSlide(controller));
    }

    final controllers = await Future.wait(futures);

    final result = (
      slides: controllers.map((e) => e.extractSlide()).toList(),
      neededAssets: controllers.expand((e) => e.neededAssets).toList(),
      markdownReplacements:
          controllers.expand((e) => e.markdownReplacements).toList(),
    );
    await _applyMarkdownReplacements(result.markdownReplacements);

    await _cleanupGeneratedFiles(result.neededAssets);

    for (var builder in builders) {
      await builder.dispose();
    }

    _browser?.close();

    final reference = ReferenceDto(
      config: Config.loadFile(kProjectConfigFile),
      slides: result.slides,
      assets: result.neededAssets,
    );

    await kReferenceFile.writeAsString(prettyJson(reference.toMap()));
    await kReferenceFileYaml
        .writeAsString(YamlWriter().write(reference.toMap()));
    await kReferenceMarkdownCopy.writeAsString(reference.toMarkdown());

    return reference;
  }
}

Future<void> _cleanupGeneratedFiles(List<SlideAsset> assets) async {
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

  FutureOr<TaskController> build(TaskController controller) {
    try {
      return run(controller);
    } on Exception catch (e) {
      throw SDTaskException(taskName, controller, e);
    }
  }

  String buildReferenceName(String content) {
    return shortHashId(content);
  }

  Future<String> dartProcess(String code) async {
    final process = await Process.start('dart', ['format', '--fix'],
        mode: ProcessStartMode.inheritStdio);

    process.stdin.writeln(code);
    process.stdin.close();

    final output = await process.stdout.transform(utf8.decoder).join();
    final error = await process.stderr.transform(utf8.decoder).join();

    if (error.isNotEmpty) {
      throw Exception('Error formatting dart code: $error');
    }

    return output;
  }

  File buildAssetFile(String assetName, String extension) {
    if (p.extension(assetName).isNotEmpty) {
      throw Exception('Asset name should not have an extension');
    }

    if (!extension.startsWith('.')) {
      extension = '.$extension';
    }
    final updatedFileName = ('${taskName}_$assetName$extension');
    return File(p.join(kGeneratedAssetsDir.path, updatedFileName));
  }

  bool isAssetFile(File file) {
    // check if file name starts with sd_
    return file.path.contains(kGeneratedAssetsDir.path);
  }

  // Dispose or anything here
  FutureOr<void> dispose() {}
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

extension on Slide {
  String toMarkdown() {
    final buffer = StringBuffer();

    buffer.writeln('---');
    buffer.write(YamlWriter().write(options?.toMap()));
    buffer.writeln('---');

    buffer.writeln(content);

    // for (var section in sections) {
    //   buffer.writeln(section.toMarkdown());
    // }

    return buffer.toString();
  }
}

extension on ReferenceDto {
  String toMarkdown() {
    final buffer = StringBuffer();

    for (var slide in slides) {
      buffer.writeln(slide.toMarkdown());
    }

    return buffer.toString();
  }
}

extension on SectionBlockDto {
  String toMarkdown() {
    final options = this.options?.toMap() ?? {};

    final slideBuffer = StringBuffer();

    final optionsBuffer = _optionsToString(options);

    slideBuffer.writeln('{@section$optionsBuffer}');

    for (var section in subSections) {
      final options = section.options?.toMap() ?? {};
      final optionsBuffer = _optionsToString(options);

      final type = section.toMap()['type'];

      slideBuffer.writeln('{@$type$optionsBuffer}');
      if (section is ColumnBlockDto) {
        final contents = section.content.split('\n');
        for (var content in contents) {
          slideBuffer.writeln(content);
        }
      }
      slideBuffer.writeln('');
    }

    return slideBuffer.toString();
  }

  String _optionsToString(Map<String, dynamic> map) {
    final buffer = StringBuffer();
    final cleanMap = {...map}..remove('type');
    for (var key in cleanMap.keys) {
      final value = cleanMap[key];
      if (value != null) {
        buffer.write(' $key: $value');
      }
    }

    return buffer.toString();
  }
}