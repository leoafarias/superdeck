import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:superdeck_cli/src/generator_pipeline.dart';

class ImageCachingTask extends Task {
  const ImageCachingTask() : super('image_caching');

  @override
  Future<TaskController> run(controller) async {
    final slide = controller.slide;

    var content = slide.markdown;
    final slideData = slide.toMap();

    // Do not cache remot edata if cacheRemoteAssets is false

    // Get any url of images that are in the markdown
    // Save it the local path on the device
    // and replace the url with the local path
    final imageRegex = RegExp(r'!\[.*?\]\((.*?)\)');

    final matches = imageRegex.allMatches(content);

    Future<void> saveAsset(String url) async {
      if (isAssetFile(File(url))) return;

      try {
        final refName = buildReferenceName(url);
        final asset = controller.checkAssetExists(refName);

        if (asset != null) {
          controller.markNeeded(asset);
          return;
        }

        final checkFileType = await http.get(Uri.parse(url));
        final contentType = checkFileType.headers['content-type'];

        if (contentType == null) {
          return;
        }

        if (!contentType.startsWith('image/')) {
          return;
        }

        final commonRenderableFormats = ['jpeg', 'png', 'gif', 'webp'];
        final extension = contentType.split('/').last;
        if (!commonRenderableFormats.contains(extension)) {
          print('Not a renderable format: $url');
          return;
        }
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          // Get the extension from the Content-Type header
          final contentType = response.headers['content-type'];

          final extension = contentType?.split('/').last;

          // Create a file with the appropriate extension
          final file = buildAssetFile(
            refName,
            extension ?? 'jpg',
          );

          // Write the image data to the file
          await file.writeAsBytes(response.bodyBytes);

          await controller.markFileAsNeeded(file, url);
        } else {}
      } catch (e) {
        print('Error: $e');
      }
    }

    for (final Match match in matches) {
      final assetUri = match.group(1);
      if (assetUri == null) continue;

      await saveAsset(assetUri);
    }

    final slideOptions = slideData['options'];
    final backgroundOption =
        slideOptions != null ? slideOptions['background'] : null;

    if (backgroundOption != null) {
      await saveAsset(backgroundOption);
    }

    return controller;
  }
}
