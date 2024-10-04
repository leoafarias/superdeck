import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as md;
import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_core/superdeck_core.dart';

/// A task responsible for caching images referenced in markdown slides.
class ImageCachingTask extends Task {
  /// Constructs an [ImageCachingTask] with the name 'image_caching'.
  ImageCachingTask() : super('image_caching');

  /// A set to track assets currently being processed to prevent duplicate downloads.
  static final Set<String> _executingAssets = {};

  /// HTTP client used for downloading images.
  static final http.Client _httpClient = http.Client();

  @override
  Future<TaskContext> run(TaskContext context) async {
    final slide = context.slide;
    final content = slide.markdown;

    // Parse the markdown content to extract image URLs.
    final document = md.Document();
    final nodes = document.parseInline(content);
    final Set<String> assets = {};

    for (final node in nodes) {
      if (node is md.Element && node.tag == 'img') {
        final src = node.attributes['src'];
        if (src != null && src.startsWith('http')) {
          assets.add(src);
        }
      }
    }

    // Function to download and save a single asset.
    Future<void> saveAsset(String url) async {
      final String refName = assetHash(url);

      // Check if the asset is already cached.
      if (context.assetExists(refName)) {
        logger.fine('Asset already cached: $url');
        return;
      }

      try {
        logger.info('Downloading asset: $url');
        final response = await _httpClient.get(Uri.parse(url));

        // Verify successful response.
        if (response.statusCode != 200) {
          logger.warning(
            'Failed to download $url: Status ${response.statusCode}',
          );
          return;
        }

        final String? contentType = response.headers['content-type'];
        // Validate content type.
        if (contentType == null || !contentType.startsWith('image/')) {
          logger.warning('Invalid content type for $url: $contentType');
          return;
        }

        // Define supported image formats.
        const List<String> supportedFormats = ['jpeg', 'png', 'gif', 'webp'];
        final String extension = contentType.split('/').last.toLowerCase();

        // Check if the image format is supported.
        if (!supportedFormats.contains(extension)) {
          logger.warning('Unsupported image format for $url: $extension');
          return;
        }

        // Build the asset file and write the downloaded bytes.
        final file = buildAssetFile(refName, extension);
        await file.writeAsBytes(response.bodyBytes);

        // Save the asset in the context.
        await context.saveAsAsset(file, url);
      } catch (e, stackTrace) {
        logger.severe('Error downloading asset $url: $e', e, stackTrace);
      }
    }

    // Iterate over each asset and process if not already executing.
    for (final String asset in assets) {
      if (_executingAssets.contains(asset)) {
        continue; // Skip if the asset is already being processed.
      }
      _executingAssets.add(asset);
      await saveAsset(asset);
      // Optionally, remove the asset from _executingAssets after processing.
      // _executingAssets.remove(asset);
    }

    return context;
  }
}
