import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../models/asset_model.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../schema/schema.dart';
import 'config.dart';
import 'deep_merge.dart';
import 'utils.dart';

final _mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');

const _assetPrefix = 'sd_';

final kSupportedExtensions = ['png', 'jpg', 'jpeg', 'gif'];

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

  const Pipeline({
    required this.markdown,
    required this.postMarkdown,
  });

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
      bytes: AssetFileBytes.fromBytes(bytes),
      width: frame.image.width.toDouble(),
      height: frame.image.height.toDouble(),
    );
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

    await kConfig.assetsImageDir.list().forEach((f) async {
      if (f is File) {
        if (!assets.any((element) => element.path == f.path)) {
          // Only remove if starts with the asset prefix
          if (f.path.startsWith(_assetPrefix)) {
            await f.delete();
          }
        }
      }
    });
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

    //  Check also if image is on background: or src: in front mattef
    //  and replace the url with the local path

    final assetsJson = await kConfig.references.assets.readAsString();

    final assets = _parseAssets(assetsJson);

    final matches = imageRegex.allMatches(data.content);

    for (final Match match in matches) {
      final imageUrl = match.group(1);
      if (imageUrl == null) continue;

      if (!imageUrl.startsWith('http')) continue;

      // If its already in assets return file name in assetsjson
      final imageUrlHash = imageUrl.hashCode.toString();

      final asset =
          assets.firstWhereOrNull((e) => e.path.contains(imageUrlHash));

      File imageFile;
      if (asset != null) {
        imageFile = File(asset.path);
      } else {
        imageFile = await _downloadAndSave(imageUrl);
      }

      final relativePath =
          relative(imageFile.path, from: kConfig.assetsDir.parent.path);

      final imageMarkdown = '![Image]($relativePath)';

      content = content.replaceFirst(match.group(0)!, imageMarkdown);
    }

    // Check also if image is on background: or src: in front matter
    // and replace the url with the local path, frontmatter is now data.options Map<String, dynamic>
    final hasBackground = options.containsKey('background');

    if (hasBackground) {
      final background = options['background'];
      if (background is String) {
        if (background.startsWith('http')) {
          final imageUrl = background;
          if (!imageUrl.startsWith('http')) return data;
          // If its already in assets return file name in assetsjson
          final imageUrlHash = imageUrl.hashCode.toString();
          final asset = assets.firstWhereOrNull(
            (e) => e.path.contains(imageUrlHash),
          );
          File imageFile;
          if (asset != null) {
            imageFile = File(asset.path);
          } else {
            imageFile = await _downloadAndSave(imageUrl);
          }
          final relativePath =
              relative(imageFile.path, from: kConfig.assetsDir.parent.path);

          options['background'] = relativePath;
        }
      }
    }

    final hasImageSrc =
        (options['options'] as Map<String, dynamic>?)?.containsKey('src') ??
            false;

    if (hasImageSrc) {
      final src = options['options']?['src'];
      if (src is String) {
        if (src.startsWith('http')) {
          final imageUrl = src;
          if (!imageUrl.startsWith('http')) return data;
          // If its already in assets return file name in assetsjson
          final imageUrlHash = imageUrl.hashCode.toString();
          final asset = assets.firstWhereOrNull(
            (e) => e.path.contains(imageUrlHash),
          );
          File imageFile;
          if (asset != null) {
            imageFile = File(asset.path);
          } else {
            imageFile = await _downloadAndSave(imageUrl);
          }
          final relativePath =
              relative(imageFile.path, from: kConfig.assetsDir.parent.path);
          options['options']?['src'] = relativePath;
        }
      }
      return data;
    }

    return (
      content: content,
      options: options,
      config: data.config,
    );
  }

  Future<File> _downloadAndSave(String imageUrl) async {
    final imageUrlHash = imageUrl.hashCode.toString();

    final client = HttpClient();
    final request = await client.getUrl(Uri.parse(imageUrl));
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);

    final contentType = response.headers.contentType;
    // Default to .jpg if no extension is found
    final extension = contentType?.subType ?? 'jpg';

    if (!kSupportedExtensions.contains(extension)) {
      throw Exception(
        'Unsupported image extension: $extension. Supported extensions: ${kSupportedExtensions.join(', ')}',
      );
    }

    final imageFile = File(join(
      kConfig.assetsImageDir.path,
      'sd_$imageUrlHash.$extension',
    ));

    if (await imageFile.exists()) {
      return imageFile;
    }

    await imageFile.writeAsBytes(bytes);
    return imageFile;
  }
}

class MermaidProcessor extends MarkdownProcessor {
  const MermaidProcessor();

  @override
  Future<MarkdownData> run(MarkdownData data) async {
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
      final filePath = '${_assetPrefix}mermaid_${mermaidSyntax.hashCode}.png';
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

List<SlideAsset> _parseAssets(String assetsJson) {
  final assets = jsonDecode(assetsJson) as List;
  return assets.map((asset) => SlideAsset.fromMap(asset)).toList();
}
