import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:superdeck_cli/src/constants.dart';
import 'package:superdeck_cli/src/helpers/extensions.dart';
import 'package:superdeck_cli/src/helpers/raw_models.dart';
import 'package:superdeck_cli/src/helpers/slide_parser.dart';

import 'slides_pipeline.dart';

class SlidesLoader {
  SlidesLoader._();

  static final instance = SlidesLoader._();

  Future<void> generate() async {
    log('Generating slides...');
    await kMarkdownFile.ensureExists();
    await kGeneratedAssetsDir.ensureExists();
    final markdownRaw = kMarkdownFile.readAsStringSync();
    final files = await _loadGeneratedFiles();

    await kSlideRef.ensureExists();

    final reference = RawReference.loadFile(kSlideRef);
    final rawAssets = reference.assets;
    final config = RawConfig.loadFile(kProjectConfigFile);

    final parser = SlideParser();
    final slides = parser.run(markdownRaw);

    final pipeline = TaskPipeline([
      const MermaidConverterTask(),
      const SlideThumbnailTask(),
    ]);

    final result = await pipeline.run(slides, rawAssets);

    for (var file in files) {
      if (!result.neededAssets.any((element) => element.path == file.path)) {
        if (await file.exists()) {
          await file.delete();
        }
      }
    }

    await kSlideRef.writeAsString(jsonEncode({
      'config': config.toMap(),
      'slides': result.slides.map((e) => e.toMap()).toList(),
      'assets': result.neededAssets.map((e) => e.toMap()).toList(),
    }));
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
