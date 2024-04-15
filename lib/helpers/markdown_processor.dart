import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import '../models/asset_model.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../schema/schema.dart';
import 'config.dart';
import 'deep_merge.dart';

final _mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');

typedef DeckData = ({
  List<Slide> slides,
  List<SlideAsset> assets,
});

typedef ProcessData = ({
  String content,
  Map<String, dynamic> options,
  Config config,
});

class ProcessorRunner {
  final List<Processor> _processors;

  const ProcessorRunner(this._processors);

  Future<DeckData> run(String contents) async {
    final slidesRaw = _splitSlides(contents.trim());

    final config = await _loadConfig();

    final slides = <Slide>[];

    for (final raw in slidesRaw) {
      final slide = await runEach(raw, config);
      slides.add(slide);
    }

    final assets = await _loadAssets();

    return (
      slides: slides,
      assets: assets,
    );
  }

  Future<Slide> runEach(String slideContents, Config config) async {
    ProcessData result = (content: slideContents, options: {}, config: config);

    for (final processor in _processors) {
      result = await processor.run(result);
    }

    final (:content, :options, config: _) = result;

    return _parseSlideFromMap({
      ...options,
      'layout': options['layout'] ?? 'simple',
      'data': content,
    });
  }

  Future<Config> _loadConfig() async {
    final file = kConfig.projectConfigFile;

    if (!await file.exists()) {
      return const Config.empty();
    }

    final configContents = await file.readAsString();
    return Config.fromMap(_yamlToMap(configContents));
  }

  Future<Slide> _parseSlideFromMap(Map<String, dynamic> slideMap) async {
    final layout = slideMap['layout'] as String?;

    const config = 'config';
    try {
      switch (layout) {
        case LayoutType.simple:
        case null:
          SimpleSlide.schema.validateOrThrow(config, slideMap);
          return SimpleSlide.fromMap(slideMap);
        case LayoutType.image:
          ImageSlide.schema.validateOrThrow(config, slideMap);
          return ImageSlide.fromMap(slideMap);
        case LayoutType.widget:
          WidgetSlide.schema.validateOrThrow(config, slideMap);
          return WidgetSlide.fromMap(slideMap);
        case LayoutType.twoColumn:
          TwoColumnSlide.schema.validateOrThrow(config, slideMap);
          return TwoColumnSlide.fromMap(slideMap);
        case LayoutType.twoColumnHeader:
          TwoColumnHeaderSlide.schema.validateOrThrow(config, slideMap);
          return TwoColumnHeaderSlide.fromMap(slideMap);
        default:
          return InvalidSlide.invalidTemplate(layout);
      }
    } on SchemaValidationException catch (e) {
      return InvalidSlide.schemaError(e.result);
    } on Exception catch (e) {
      return InvalidSlide.exception(e);
    } catch (e) {
      return InvalidSlide.message('# Unknown Error \n $e');
    }
  }

  Future<List<SlideAsset>> _loadAssets() async {
    final assetsDir = kConfig.assetsImageDir;
    final assets = <SlideAsset>[];

    if (await assetsDir.exists()) {
      await for (final entity in assetsDir.list()) {
        if (entity is File) {
          final asset = await _getAssetFromPath(entity);
          assets.add(asset);
        }
      }
    }

    return assets;
  }

  List<String> _splitSlides(String content) {
    final lines = content.split('\n');
    final slides = <String>[];
    final buffer = StringBuffer();
    bool inSlide = false;

    var isCodeBlock = false;

    for (var line in lines) {
      if (line.trim().startsWith('```')) {
        isCodeBlock = !isCodeBlock;
      }
      if (line.trim() == '---' && !isCodeBlock) {
        if (buffer.isNotEmpty) {
          if (inSlide) {
            // Add the slide content to the list of slides
            slides.add(buffer.toString().trim());
            inSlide = false;
            buffer.clear();
          } else {
            inSlide = true;
          }
        }
        buffer.writeln(line);
      } else {
        buffer.writeln(line);
      }
    }

    // Capture any remaining content as a slide
    if (buffer.isNotEmpty) {
      slides.add(buffer.toString());
    }

    return slides;
  }

  Future<SlideAsset> _getAssetFromPath(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();

    return SlideAsset(
      path: file.path,
      bytes: bytes,
      width: frame.image.width.toDouble(),
      height: frame.image.height.toDouble(),
    );
  }
}

abstract class Processor {
  const Processor();

  FutureOr<ProcessData> run(ProcessData data);
}

final _frontMatterRegex = RegExp(r'---([\s\S]*?)---');

class FrontMatterProcessor extends Processor {
  const FrontMatterProcessor();

  @override
  ProcessData run(ProcessData data) {
    final frontMatter =
        _frontMatterRegex.firstMatch(data.content)?.group(1) ?? '';

    final options = _yamlToMap(frontMatter);

    final content = data.content
        .substring(_frontMatterRegex.matchAsPrefix(data.content)?.end ?? 0)
        .trim();

    // Set default layout
    options['layout'] = options['layout'] ?? 'simple';

    final mergedOptions = deepMerge(
      data.config.toMap(),
      options,
    );

    return (
      content: content,
      options: mergedOptions,
      config: data.config,
    );
  }
}

class MermaidProcessor extends Processor {
  const MermaidProcessor();

  @override
  Future<ProcessData> run(ProcessData data) async {
    final replacements = <({int start, int end, String markdown})>[];

    var content = data.content;

    final matches = _mermaidBlockRegex.allMatches(content);

    for (final Match match in matches) {
      final mermaidSyntax = match.group(1);

      if (mermaidSyntax == null) continue;

      // Process the mermaid syntax to generate an image file
      final file = await generateAndSaveMermaidImage(mermaidSyntax);

      final relativePath = relative(
        file.path,
        from: kConfig.assetsDir.parent.path,
      );

      final markdown = '![Mermaid Diagram]($relativePath)';

      // Collect replacement information
      replacements.add((
        start: match.start,
        end: match.end,
        markdown: markdown,
      ));
    }

    // Apply replacements in reverse order
    for (var replacement in replacements.reversed) {
      final (:start, :end, :markdown) = replacement;

      content = content.replaceRange(start, end, markdown);
    }

    return (
      content: content,
      options: data.options,
      config: data.config,
    );
  }

  Future<File> generateAndSaveMermaidImage(String mermaidSyntax) async {
    const tempFilePath = 'temp.mmd';
    final tempFile = File(tempFilePath);

    try {
      mermaidSyntax = mermaidSyntax.trim().replaceAll(r'\n', '\n');

      // has the mermaidSyntax string
      final filePath = 'sd_mermaid_${mermaidSyntax.hashCode}.png';
      final mermaidAssetFile =
          File(join(kConfig.assetsImageDir.path, filePath));

      if (await mermaidAssetFile.exists()) {
        return mermaidAssetFile;
      }

      await tempFile.writeAsString(mermaidSyntax);

      final outputFile = File(join(kConfig.assetsImageDir.path, filePath));

      if (!await outputFile.parent.exists()) {
        await outputFile.parent.create(recursive: true);
      }

      final imageSizeParams = '--scale 2'.split(' ');
      final params =
          '-t dark -b transparent -i $tempFilePath -o ${outputFile.path} '
              .split(' ');

      final result = await Process.run('mmdc', [...params, ...imageSizeParams]);

      if (result.exitCode != 0) {
        print('Error while processing mermaid syntax');
        print(result.stderr);
      }

      return outputFile;
    } catch (e) {
      throw Exception('Error while processing mermaid syntax');
    } finally {
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }
}

Map<String, dynamic> _yamlToMap(String yamlString) {
  final yamlMap = loadYaml(yamlString) as YamlMap? ?? YamlMap();

  dynamic convertYamlToMap(dynamic yamlObject) {
    if (yamlObject is YamlMap) {
      Map<String, dynamic> dartMap = {};
      yamlObject.forEach((key, value) {
        dartMap[key.toString()] = convertYamlToMap(value);
      });
      return dartMap;
    } else {
      return yamlObject;
    }
  }

  return {
    ...convertYamlToMap(yamlMap),
    'raw': yamlString,
  };
}
