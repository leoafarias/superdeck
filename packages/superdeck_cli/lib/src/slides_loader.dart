import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:superdeck_cli/src/constants.dart';
import 'package:superdeck_cli/src/helpers/extensions.dart';
import 'package:superdeck_cli/src/helpers/slide_parser.dart';
import 'package:superdeck_cli/src/helpers/types.dart';
import 'package:superdeck_cli/src/helpers/yaml_to_map.dart';

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

    final reference =
        jsonDecode(kSlideRef.readAsStringSync()) as Map<String, dynamic>;
    final rawAssets = ((reference['assets'] ?? []) as List<dynamic>)
        .map((e) => RawAsset.fromJson(e))
        .toList();

    final config = converYamlToMap(kProjectConfigFile.readAsStringSync());

    final parser = SlideParser(Map<String, dynamic>.from(config));
    final slides = parser.run(markdownRaw);

    final pipeline = SlidesPipeline(
      [
        // const ImageCachingTask(),
        MermaidConverterTask(),
        const SlideThumbnailTask(),
      ],
    );

    final result = await pipeline.run(slides, rawAssets);

    for (var file in files) {
      if (!result.neededAssets.any((element) => element.path == file.path)) {
        if (await file.exists()) {
          await file.delete();
        }
      }
    }
    print(result.neededAssets);

    await kSlideRef.writeAsString(jsonEncode({
      'config': config,
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