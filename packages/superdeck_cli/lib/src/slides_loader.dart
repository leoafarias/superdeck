import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:superdeck_cli/src/constants.dart';
import 'package:superdeck_cli/src/helpers/extensions.dart';
import 'package:superdeck_cli/src/helpers/slide_parser.dart';
import 'package:yaml/yaml.dart';

import 'slides_pipeline.dart';

class SlidesLoader {
  SlidesLoader._();

  static final instance = SlidesLoader._();

  Future<void> _generate() async {
    log('Generating slides...');
    await kMarkdownFile.ensureExists();
    final markdownRaw = kMarkdownFile.readAsStringSync();
    final files = await _loadGeneratedFiles();
    await kSlideRef.ensureExists();

    final config = loadYaml(kProjectConfigFile.readAsStringSync())
            as Map<String, dynamic>? ??
        {};

    final parser = SlideParser(config);
    final slides = parser.run(markdownRaw);

    final pipeline = SlidesPipeline(
      [
        // const ImageCachingTask(),
        MermaidConverterTask(),
        const SlideThumbnailTask(),
      ],
    );

    final result = await pipeline.run(slides, files);

    for (var file in files) {
      if (!result.neededAssets.any((element) => element.path == file.path)) {
        if (await file.exists()) {
          await file.delete();
        }
      }
    }

    await kSlideRef.writeAsString(jsonEncode({
      'config': config,
      'slides': result.slides,
      'assets': result.neededAssets.map((e) => e.path).toList(),
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
