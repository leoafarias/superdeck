import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../schema/schema.dart';
import '../services/assets_service.dart';
import '../services/mermaid_service.dart';
import '../superdeck.dart';
import 'config.dart';
import 'deep_merge.dart';
import 'utils.dart';

final _mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');

typedef DeckReferenceDto = ({
  List<Slide> slides,
  ProjectConfig config,
  List<SlideAsset> assets,
});

final DeckReferenceDto emptyDeckData = (
  slides: [],
  assets: [],
  config: const ProjectConfig.empty(),
);

typedef TaskDto = ({
  Slide slide,
  List<SlideAsset> assets,
  ProjectConfig config,
});

class Pipeline {
  final List<Task> processors;
  final ProjectConfig config;
  final List<SlideAsset> assets;

  Pipeline({
    required this.processors,
    required this.assets,
    required this.config,
  });

  static Future<void> cleanAssets(List<SlideAsset> assetsUsed) async {
    //  Gothrough the assets directory and check if the asset is not in assetsSaved
    //  delete it
    final assetsDir = sdConfig.assetsImageDir;

    if (!await assetsDir.exists()) return;

    final assetPaths = assetsUsed.map((e) => e.localPath).toSet();

    await for (final entity in assetsDir.list()) {
      if (entity is File) {
        final fileName = p.basename(entity.path);
        if (fileName.startsWith(SlideAsset.cachedPrefix)) {
          if (!assetPaths.contains(entity.path)) {
            await entity.delete();
          }
        }
      }
    }
  }

  static Future<void> cleanThumbnails(List<Slide> slides) async {
    final assetsDir = sdConfig.assetsImageDir;

    if (!await assetsDir.exists()) return;

    final assets = <File>[];

    await for (final entity in assetsDir.list()) {
      if (entity is File) {
        final fileName = p.basename(entity.path);
        if (!fileName.startsWith(SlideAsset.thumbnailPrefix)) {
          continue;
        }

        assets.add(entity);
      }
    }

    for (final asset in assets) {
      final slide = slides.firstWhereOrNull((e) => asset.path.contains(e.hash));

      if (slide == null) {
        await asset.delete();
      }
    }
  }

  Future<void> onFinish(DeckReferenceDto data) async {
    await cleanAssets(data.assets);
    await cleanThumbnails(data.slides);
  }

  Future<void> onInit() async {
    final assetDir = sdConfig.assetsImageDir;
    if (!await assetDir.exists()) {
      await assetDir.create(recursive: true);
    }
  }

  Future<DeckReferenceDto> run(File markdownFile) async {
    await onInit();
    if (!await markdownFile.exists()) {
      throw Exception('File not found');
    }

    final presentationRaw = await markdownFile.readAsString();

    final parser = SlideParser(config);

    final slides = parser.run(presentationRaw);
    final results = <TaskDto>[];

    for (var slide in slides) {
      TaskDto result = (slide: slide, assets: assets, config: config);
      for (var task in processors) {
        result = await task.run(result);
      }
      results.add(result);
    }

    final slideResults = results.map((e) => e.slide).toList();
    final assetResults = results.expand((e) => e.assets).toList();

    final result = (
      slides: slideResults,
      assets: assetResults,
      config: config,
    );
    await onFinish(result);

    return result;
  }
}

abstract class Task {
  const Task();

  FutureOr<TaskDto> run(
    TaskDto data,
  );
}

class SlideParser {
  final ProjectConfig config;

  SlideParser(this.config);

  final _frontMatterRegex = RegExp(r'---([\s\S]*?)---');

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

  List<Slide> run(String contents) {
    final slidesRaw = _splitSlides(contents.trim());

    final slides = <Slide>[];

    for (final slideRaw in slidesRaw) {
      slides.add(_runEach(slideRaw));
    }

    return slides;
  }

  Slide _runEach(String slideRaw) {
    final frontMatter = _frontMatterRegex.firstMatch(slideRaw)?.group(1) ?? '';

    final options = converYamlToMap(frontMatter);

    final content = slideRaw
        .substring(_frontMatterRegex.matchAsPrefix(slideRaw)?.end ?? 0)
        .trim();

    // Set default layout
    options['layout'] = options['layout'] ?? 'simple';

    // Raw front matter
    options['raw'] = slideRaw;

    // Slide contents
    options['data'] = content;

    final mergedOptions = deepMerge(
      config.toSlideMap(),
      options,
    );

    return _buildSlide(mergedOptions);
  }
}

class ImageCachingTask extends Task {
  const ImageCachingTask();

  @override
  Future<TaskDto> run(data) async {
    final slide = data.slide;
    final assets = <CachedAsset>[];
    var content = slide.data;
    // Do not cache remot edata if cacheRemoteAssets is false

    // Get any url of images that are in the markdown
    // Save it the local path on the device
    // and replace the url with the local path
    final imageRegex = RegExp(r'!\[.*?\]\((.*?)\)');

    final matches = imageRegex.allMatches(content);

    Future<void> saveAsset(String assetUri) async {
      final cachedAsset = await AssetService.instance.loadCachedAsset(assetUri);

      if (cachedAsset != null) {
        assets.add(cachedAsset);
        return;
      }

      assets.add(await AssetService.instance.saveCachedAsset(assetUri));
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

    return (slide: slide, assets: assets, config: data.config);
  }
}

class MermaidConverterTask extends Task {
  const MermaidConverterTask();

  @override
  FutureOr<TaskDto> run(data) async {
    final slide = data.slide;

    final matches = _mermaidBlockRegex.allMatches(slide.data);

    if (matches.isEmpty) return data;
    final replacements =
        <({int start, int end, String markdown, GeneratedAsset asset})>[];

    for (final Match match in matches) {
      final mermaidSyntax = match.group(1);

      if (mermaidSyntax == null) continue;

      final mermaidImageHash = mermaidSyntax.hashCode.toString();

      var asset = await assetService.loadGeneratedAsset(mermaidImageHash);
      // Check if image already exists

      if (asset == null) {
        // Process the mermaid syntax to generate an image file
        final imageData = await mermaidService.generateImage(mermaidSyntax);

        if (imageData != null) {
          asset = await assetService.saveGeneratedAsset(
            hash: mermaidImageHash,
            data: imageData,
          );
        }
      }

      if (asset == null) continue;

      replacements.add((
        start: match.start,
        end: match.end,
        markdown: '![Mermaid Diagram](${asset.relativePath})',
        asset: asset,
      ));
    }

    var replacedData = slide.data;
    final assets = <GeneratedAsset>[];

    // Apply replacements in reverse order
    for (var replacement in replacements.reversed) {
      final (:start, :end, :markdown, :asset) = replacement;

      replacedData = replacedData.replaceRange(start, end, markdown);
      assets.add(asset);
    }

    return (
      slide: slide.copyWith(data: replacedData),
      assets: assets,
      config: data.config
    );
  }
}

Slide _buildSlide(Map<String, dynamic> slide) {
  final layout = slide['layout'] as String?;

  const config = 'config';
  try {
    switch (layout) {
      case LayoutType.simple:
      case null:
        SimpleSlide.schema.validateOrThrow(config, slide);
        return SimpleSlide.fromMap(slide);
      case LayoutType.image:
        ImageSlide.schema.validateOrThrow(config, slide);
        return ImageSlide.fromMap(slide);
      case LayoutType.widget:
        WidgetSlide.schema.validateOrThrow(config, slide);
        return WidgetSlide.fromMap(slide);
      case LayoutType.twoColumn:
        TwoColumnSlide.schema.validateOrThrow(config, slide);
        return TwoColumnSlide.fromMap(slide);
      case LayoutType.twoColumnHeader:
        TwoColumnHeaderSlide.schema.validateOrThrow(config, slide);
        return TwoColumnHeaderSlide.fromMap(slide);
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
