import 'dart:async';
import 'dart:developer';

import 'package:watcher/watcher.dart';

import '../helpers/constants.dart';
import '../services/project_service.dart';
import 'slide_parser.dart';
import 'slides_pipeline.dart';

class SlidesLoader {
  SlidesLoader._();

  static final instance = SlidesLoader._();

  StreamSubscription<WatchEvent>? _listenerSub;
  final _projectService = ProjectService.instance;

  Future<void> _generate() async {
    log('Generating slides...');
    await _projectService.ensureExists();

    final presentationRaw = await _projectService.loadMarkdown();
    final deck = await _projectService.loadDeck();
    final files = await _projectService.loadGeneratedFiles();

    final slideParser = SlideParser(config: deck.config);

    final slides = slideParser.run(presentationRaw);

    final pipeline = SlidesPipeline(
      [
        // const ImageCachingTask(),
        const MermaidConverterTask(),
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

    await Future.wait([
      _projectService.saveConfigRef(deck.config),
      _projectService.saveSlidesRef(result.slides),
      _projectService.saveAssetsRef(result.neededAssets),
    ]);
  }

  void listen(
    FutureOr<void> Function() onChange,
  ) {
    // _listenerSub?.cancel();

    _listenerSub = _projectService.watcher.events.listen((_) => onChange());
  }

  Future<DeckReferences> loadDeck() async {
    if (kCanRunProcess) {
      await _generate();
    }

    return _projectService.loadDeck();
  }
}
