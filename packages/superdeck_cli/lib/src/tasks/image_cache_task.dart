import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:superdeck_cli/src/generator_pipeline.dart';

class ImageCachingTask extends Task {
  const ImageCachingTask() : super('image_caching');

  @override
  Future<TaskController> run(controller) async {
    final slide = controller.slide;

    var content = slide.content;
    final slideData = slide.toMap();
    // Do not cache remot edata if cacheRemoteAssets is false

    // Get any url of images that are in the markdown
    // Save it the local path on the device
    // and replace the url with the local path
    final imageRegex = RegExp(r'!\[.*?\]\((.*?)\)');
    final urlRegex = RegExp(
      r'((http|https|ftp):\/\/)?(www\.)?([a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+)(\/[^\s]*)?',
      caseSensitive: false,
    );

    final matches = imageRegex.allMatches(content);

    Future<void> saveAsset(String url) async {
      if (isAssetFile(File(url))) return;
      // Look by hashcode to see if the asset is already cached
      final refName = buildReferenceName(url);

      final asset = controller.checkAssetExists(refName);

      // if (asset != null && await File(asset.path).exists()) {
      //   final file = File(asset.path);
      //   try {
      //     print('File already exists: ${file.path}');
      //     await controller.markFileAsNeeded(file, url);
      //     return;
      //   } catch (e) {
      //     log('Error saving asset: ${file.path} $e');
      //     await file.delete();
      //     saveAsset(url);
      //   }
      // }

      try {
        final checkFileType = await http.head(Uri.parse(url));
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
          return;
        }
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          // Get the extension from the Content-Type header
          final contentType = response.headers['content-type'];

          final extension = contentType?.split('/').last;

          // Create a file with the appropriate extension
          final file = buildAssetFile(
            buildReferenceName(url),
            extension ?? 'jpg',
          );

          // Write the image data to the file
          await file.writeAsBytes(response.bodyBytes);

          print('Image saved to: $url');

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

    if (slideData['background'] != null) {
      // Check if it matches
      if (urlRegex.hasMatch(slideData['background'])) {
        await saveAsset(slideData['background']);
      }
    }

    if (slideData['options'] != null) {
      if (slideData['options']['background'] != null) {
        if (urlRegex.hasMatch(slideData['options']['background'])) {
          await saveAsset(slideData['options']['background']);
        }
      }
    }

    return controller;
  }
}
