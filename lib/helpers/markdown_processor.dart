import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../models/asset_model.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../schema/schema.dart';
import 'config.dart';
import 'deep_merge.dart';
import 'utils.dart';

final _mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');

typedef DeckData = ({
  List<Slide> slides,
  List<SlideAsset> assets,
  Config config,
});

final emptyDeckData = (
  slides: <Slide>[],
  assets: <SlideAsset>[],
  config: const Config.empty(),
);

typedef MarkdownData = ({
  String content,
  Map<String, dynamic> options,
  Config config,
});

class Pipeline {
  final List<MarkdownProcessor> markdown;
  final List<PostMarkdownProcessor> postMarkdown;

  static List<SlideAsset> assetsLoaded = [];

  static Future<void> cleanAssets() async {
    //  Gothrough the assets directory and check if the asset is not in assetsSaved
    //  delete it
    final assetsDir = kConfig.assetsImageDir;

    if (!await assetsDir.exists()) return;

    await for (final entity in assetsDir.list()) {
      if (entity is File) {
        final asset = await SlideAsset.maybeLoad(entity);
        if (!assetsLoaded.contains(asset)) {
          await entity.delete();
        }
      }
    }
  }

  const Pipeline({
    required this.markdown,
    required this.postMarkdown,
  });

  static Future<SlideAsset?> getAsset(String fileName) async {
    final assetFile = SlideAsset.buildFile(fileName);

    return await SlideAsset.maybeLoad(assetFile);
  }

  static Future<SlideAsset> saveAsset(
    String fileName, {
    required List<int> data,
    required,
  }) async {
    final imageFile = SlideAsset.buildFile(fileName);

    await imageFile.writeAsBytes(data);
    final asset = await SlideAsset.load(imageFile);
    Pipeline.assetsLoaded.add(asset);

    return asset;
  }

  Future<DeckData> run(String contents) async {
    final slidesRaw = _splitSlides(contents.trim());

    final config = await _loadConfig();

    final slides = <Slide>[];

    for (final raw in slidesRaw) {
      slides.add(await runEach(raw, config));
    }

    final assets = await _loadAssets();

    final data = (
      slides: slides,
      assets: assets,
      config: config,
    );

    return await _runPostMarkdown(data);
  }

  Future<DeckData> _runPostMarkdown(DeckData data) async {
    var updatedData = data;

    for (final processor in postMarkdown) {
      updatedData = await processor.run(updatedData);
    }

    return updatedData;
  }

  Future<Slide> runEach(String slideContents, Config config) async {
    MarkdownData result = (content: slideContents, options: {}, config: config);

    for (final processor in markdown) {
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
    return Config.fromYaml(configContents);
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
          final asset = await SlideAsset.load(entity);
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
}

abstract class PostMarkdownProcessor {
  const PostMarkdownProcessor();

  FutureOr<DeckData> run(DeckData data);
}

class StoreLocalReferencesProcessor extends PostMarkdownProcessor {
  const StoreLocalReferencesProcessor();

  @override
  Future<DeckData> run(DeckData data) async {
    final (:slides, :assets, :config) = data;

    await _saveAssetsJson(assets);
    await _saveSlideJson(slides);
    await _saveConfig(config);

    return data;
  }

  Future<void> _saveConfig(Config config) async {
    try {
      final configJson = kConfig.references.config;
      if (!await configJson.exists()) {
        await configJson.create(recursive: true);
      }

      await configJson.writeAsString(prettyJson(config.toMap()));
      print('Config saved');
    } catch (e) {
      print('Error while saving config: $e');
      rethrow;
    }
  }

  Future<void> _saveSlideJson(List<Slide> slides) async {
    try {
      final slidesJson = kConfig.references.slides;

      final map = slides.map((e) => e.toMap()).toList();

      if (!await slidesJson.exists()) {
        await slidesJson.create(recursive: true);
      }

      // Write a json file with a list of slide
      await slidesJson.writeAsString(prettyJson(map));
    } catch (e) {
      print('Error while saving slides json: $e');
      rethrow;
    }
  }

  Future<void> _saveAssetsJson(List<SlideAsset> assets) async {
    final assetsJson = kConfig.references.assets;

    if (!await assetsJson.exists()) {
      await assetsJson.create(recursive: true);
    }
    final map = assets.map((e) => e.toMap()).toList();
    // Write a json file with a list of assets
    await assetsJson.writeAsString(prettyJson(map));
  }
}

abstract class MarkdownProcessor {
  const MarkdownProcessor();

  FutureOr<MarkdownData> run(MarkdownData data);
}

final _frontMatterRegex = RegExp(r'---([\s\S]*?)---');

class FrontMatterProcessor extends MarkdownProcessor {
  const FrontMatterProcessor();

  @override
  MarkdownData run(MarkdownData data) {
    final frontMatter =
        _frontMatterRegex.firstMatch(data.content)?.group(1) ?? '';

    final options = converYamlToMap(frontMatter);

    final content = data.content
        .substring(_frontMatterRegex.matchAsPrefix(data.content)?.end ?? 0)
        .trim();

    // Set default layout
    options['layout'] = options['layout'] ?? 'simple';

    options['raw'] = frontMatter;

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

class ImageMarkdownProcessor extends MarkdownProcessor {
  const ImageMarkdownProcessor();

  @override
  Future<MarkdownData> run(MarkdownData data) async {
    // Get any url of images that are in the markdown
    // Save it the local path on the device
    // and replace the url with the local path
    final imageRegex = RegExp(r'!\[.*?\]\((.*?)\)');

    var content = data.content;
    var options = {...data.options};

    final matches = imageRegex.allMatches(data.content);

    for (final Match match in matches) {
      final imageUrl = match.group(1);
      if (imageUrl == null) continue;

      final asset = await _fetchAsset(imageUrl);

      if (asset != null) {
        final imageMarkdown = '![Image](${asset.relativePath})';
        content = content.replaceFirst(match.group(0)!, imageMarkdown);
      }
    }

    // Check also if image is on background: or src: in front matter
    // and replace the url with the local path, frontmatter is now data.options Map<String, dynamic>
    var background = options['background'];

    if (background != null && background is String) {
      final asset = await _fetchAsset(background);

      if (asset != null) {
        background = asset.relativePath;
        options['background'] = background;
      }
    }

    var imageSource = options['options']?['src'];

    if (imageSource != null && imageSource is String) {
      final asset = await _fetchAsset(imageSource);

      if (asset != null) {
        imageSource = asset.relativePath;
        options['options']['src'] = imageSource;
      }
    }

    return (
      content: content,
      options: options,
      config: data.config,
    );
  }

  Future<SlideAsset?> _fetchAsset(String url) async {
    if (!url.startsWith('http')) {
      return null;
    }

    var ext = p.extension(url).replaceFirst('.', '');

    // Check if url has extension and is an image
    if (!SlideAsset.allowedExtensions.contains(ext)) {
      return null;
    }

    final client = HttpClient();
    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();
    final data = await consolidateHttpClientResponseBytes(response);

    final contentType = response.headers.contentType;
    // Default to .jpg if no extension is found
    final extension = contentType?.subType ?? 'jpg';

    final fileName = '${url.hashCode}.$extension';

    return Pipeline.saveAsset(
      fileName,
      data: data,
    );
  }
}

typedef Replacement = ({int start, int end, String markdown});

class MermaidProcessor extends MarkdownProcessor {
  const MermaidProcessor();

  @override
  Future<MarkdownData> run(MarkdownData data) async {
    final replacements = <Replacement>[];

    var content = data.content;

    final matches = _mermaidBlockRegex.allMatches(content);

    for (final Match match in matches) {
      final mermaidSyntax = match.group(1);

      if (mermaidSyntax == null) continue;

      // Process the mermaid syntax to generate an image file
      final asset = await generateAndSaveMermaidImage(mermaidSyntax);

      if (asset == null) continue;

      final markdown = '![Mermaid Diagram](${asset.relativePath})';

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

  Future<SlideAsset?> generateAndSaveMermaidImage(String mermaidSyntax) async {
    final fileName = '${mermaidSyntax.hashCode}.png';

    final existingAsset = await Pipeline.getAsset(fileName);

    if (existingAsset != null) {
      return existingAsset;
    }

    const tempDirPath = '.tmp_superdeck';
    final tempFilePath = p.join(tempDirPath, '$fileName.mmd');
    final tempFile = File(tempFilePath);
    final tempOutputPath = p.join(tempDirPath, fileName);

    if (!await Directory(tempDirPath).exists()) {
      await Directory(tempDirPath).create(recursive: true);
    }

    try {
      mermaidSyntax = mermaidSyntax.trim().replaceAll(r'\n', '\n');

      await tempFile.writeAsString(mermaidSyntax);

      final imageSizeParams = '--scale 2'.split(' ');
      final params =
          '-t dark -b transparent -i $tempFilePath -o $tempOutputPath '
              .split(' ');

      // Check if can execute mmdc before executing command
      final mmdcResult = await Process.run('mmdc', ['--version']);

      if (mmdcResult.exitCode != 0) {
        print(
          '"mmdc" not found. You need mermaid cli installed to process mermaid syntax',
        );

        return null;
      }

      final result = await Process.run('mmdc', [...params, ...imageSizeParams]);

      if (result.exitCode != 0) {
        print('Error while processing mermaid syntax');
        print(result.stderr);
        return null;
      }

      final output = await File(tempOutputPath).readAsBytes();

      return Pipeline.saveAsset(
        fileName,
        data: output,
      );
    } catch (e) {
      throw Exception('Error while processing mermaid syntax $e');
    } finally {
      final tempDir = Directory(tempDirPath);
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    }
  }
}

List<SlideAsset> _parseAssets(String assetsJson) {
  final assets = jsonDecode(assetsJson) as List;
  return assets.map((asset) => SlideAsset.fromMap(asset)).toList();
}
