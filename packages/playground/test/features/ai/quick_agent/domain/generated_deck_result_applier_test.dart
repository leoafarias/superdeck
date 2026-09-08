import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playground/core/data/data_sources/memory_asset_cache_store.dart';
import 'package:playground/core/data/data_sources/memory_deck_loader.dart';
import 'package:playground/core/domain/design/presentation_theme_catalog.dart';
import 'package:playground/core/domain/design/presentation_typography_catalog.dart';
import 'package:playground/core/domain/generated_image_asset.dart';
import 'package:playground/core/domain/stores/deck_customization_store.dart';
import 'package:playground/features/ai/quick_agent/core/engine/schemas/outline_schema.dart';
import 'package:playground/features/ai/quick_agent/core/engine/services/deck_generator_service.dart';
import 'package:playground/features/ai/quick_agent/domain/generated_deck_result_applier.dart';
import 'package:playground/features/editor/domain/stores/deck_document_store.dart';
import 'package:superdeck/superdeck.dart';
import 'package:superdeck_core/superdeck_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  test(
    'caches generated artwork before publishing the rendered deck',
    () async {
      const assetKey = 'wizard-test-slide-01-opening.png';
      final cache = MemoryAssetCacheStore();
      final loader = MemoryDeckLoader();
      final documentStore = DeckDocumentStore(markdown: '');
      final deckController = DeckController(
        deckLoader: loader,
        options: DeckOptions(),
        assetCacheStore: cache,
      );
      final customizationStore = DeckCustomizationStore(deckController);
      addTearDown(customizationStore.dispose);
      addTearDown(deckController.dispose);
      addTearDown(loader.dispose);
      addTearDown(documentStore.dispose);

      final published = loader.load().first.then(
        (_) => cache.resolve(assetKey),
      );
      final applier = GeneratedDeckResultApplier(
        documentStore: documentStore,
        deckLoader: loader,
        assetCacheStore: cache,
        customizationStore: customizationStore,
      );
      final application = await applier.apply(
        DeckGenerationResult.success(
          slides: [_generatedSlide(assetKey)],
          plan: _plan(assetKey),
          theme: _resolvedTheme(),
          generatedImages: [
            GeneratedImageAsset.success(assetKey: assetKey, bytes: [1, 2, 3]),
          ],
        ),
        isValid: _always,
      );

      expect(application.published, isTrue);
      expect(application.cleanupError, isNull);
      expect(await published, isNotNull);
      expect(documentStore.markdown, contains(assetKey));
    },
  );

  test('evicts artwork from the deck replaced by the current result', () async {
    const oldAssetKey = 'wizard-old-slide-01-opening.png';
    const nextAssetKey = 'wizard-next-slide-01-opening.png';
    final cache = MemoryAssetCacheStore();
    final loader = MemoryDeckLoader();
    final documentStore = DeckDocumentStore(markdown: '');
    final deckController = DeckController(
      deckLoader: loader,
      options: DeckOptions(),
      assetCacheStore: cache,
    );
    final customizationStore = DeckCustomizationStore(deckController);
    final applier = GeneratedDeckResultApplier(
      documentStore: documentStore,
      deckLoader: loader,
      assetCacheStore: cache,
      customizationStore: customizationStore,
    );
    addTearDown(customizationStore.dispose);
    addTearDown(deckController.dispose);
    addTearDown(loader.dispose);
    addTearDown(documentStore.dispose);

    await applier.apply(_result(oldAssetKey), isValid: _always);
    expect(await cache.resolve(oldAssetKey), isNotNull);

    await applier.apply(_result(nextAssetKey), isValid: _always);
    expect(await cache.resolve(oldAssetKey), isNull);
    expect(await cache.resolve(nextAssetKey), isNotNull);
  });

  test('removes artwork staged by an invalidated application', () async {
    const committedAssetKey = 'wizard-committed-slide-01-opening.png';
    const stagedAssetKey = 'wizard-staged-slide-01-opening.png';
    final cache = _BlockingAssetCacheStore();
    final host = _ApplierHost(cache);
    addTearDown(host.dispose);

    await host.applier.apply(_result(committedAssetKey), isValid: _always);
    expect(await cache.resolve(committedAssetKey), isNotNull);

    final publishedMarkdown = host.documentStore.markdown;
    var valid = true;
    cache.blockNextWrite = true;
    final application = host.applier.apply(
      _result(stagedAssetKey),
      isValid: () => valid,
    );
    await cache.writeStarted.future;
    // The document moves on while the artwork write is still in flight.
    valid = false;
    cache.releaseWrite();

    expect((await application).published, isFalse);
    expect(await cache.resolve(stagedAssetKey), isNull);
    expect(await cache.resolve(committedAssetKey), isNotNull);
    expect(host.documentStore.markdown, publishedMarkdown);
  });

  test('keeps the committed deck when its own artwork is reused', () async {
    const assetKey = 'wizard-reused-slide-01-opening.png';
    final cache = _BlockingAssetCacheStore();
    final host = _ApplierHost(cache);
    addTearDown(host.dispose);

    await host.applier.apply(_result(assetKey), isValid: _always);

    var valid = true;
    cache.blockNextWrite = true;
    final application = host.applier.apply(
      _result(assetKey),
      isValid: () => valid,
    );
    await cache.writeStarted.future;
    valid = false;
    cache.releaseWrite();

    expect((await application).published, isFalse);
    expect(await cache.resolve(assetKey), isNotNull);
  });

  test('reports obsolete-asset cleanup failures after publishing', () async {
    const oldAssetKey = 'wizard-old-slide-01-opening.png';
    const nextAssetKey = 'wizard-next-slide-01-opening.png';
    final cache = _BlockingAssetCacheStore();
    final host = _ApplierHost(cache);
    addTearDown(host.dispose);

    await host.applier.apply(_result(oldAssetKey), isValid: _always);

    cache.failDeleteFor = oldAssetKey;
    final application = await host.applier.apply(
      _result(nextAssetKey),
      isValid: _always,
    );

    expect(application.published, isTrue);
    expect(application.cleanupError, isNotNull);
    expect(host.documentStore.markdown, contains(nextAssetKey));
    expect(await cache.resolve(nextAssetKey), isNotNull);
  });

  test('applies queued results one at a time', () async {
    const firstAssetKey = 'wizard-first-slide-01-opening.png';
    const secondAssetKey = 'wizard-second-slide-01-opening.png';
    final cache = _BlockingAssetCacheStore();
    final host = _ApplierHost(cache);
    addTearDown(host.dispose);

    cache.blockNextWrite = true;
    final first = host.applier.apply(_result(firstAssetKey), isValid: _always);
    await cache.writeStarted.future;
    final second = host.applier.apply(
      _result(secondAssetKey),
      isValid: _always,
    );

    // The second application cannot start while the first one is writing.
    await Future<void>.delayed(Duration.zero);
    expect(cache.writes, [firstAssetKey]);

    cache.releaseWrite();
    expect((await first).published, isTrue);
    expect((await second).published, isTrue);
    expect(cache.writes, [firstAssetKey, secondAssetKey]);
    expect(host.documentStore.markdown, contains(secondAssetKey));
    expect(await cache.resolve(firstAssetKey), isNull);
  });
}

bool _always() => true;

/// Owns the stores one applier writes into.
final class _ApplierHost {
  _ApplierHost(AssetCacheStore cache)
    : documentStore = DeckDocumentStore(markdown: ''),
      _loader = MemoryDeckLoader(),
      _cache = cache {
    _deckController = DeckController(
      deckLoader: _loader,
      options: DeckOptions(),
      assetCacheStore: _cache,
    );
    _customizationStore = DeckCustomizationStore(_deckController);
    applier = GeneratedDeckResultApplier(
      documentStore: documentStore,
      deckLoader: _loader,
      assetCacheStore: _cache,
      customizationStore: _customizationStore,
    );
  }

  final DeckDocumentStore documentStore;
  final MemoryDeckLoader _loader;
  final AssetCacheStore _cache;
  late final DeckController _deckController;
  late final DeckCustomizationStore _customizationStore;
  late final GeneratedDeckResultApplier applier;

  void dispose() {
    _customizationStore.dispose();
    _deckController.dispose();
    unawaited(_loader.dispose());
    documentStore.dispose();
  }
}

/// Asset cache that can hold one write open and fail one delete.
final class _BlockingAssetCacheStore implements AssetCacheStore {
  final _store = MemoryAssetCacheStore();
  final writes = <String>[];

  var writeStarted = Completer<void>();
  Completer<void>? _writeGate;
  bool blockNextWrite = false;
  String? failDeleteFor;

  void releaseWrite() {
    _writeGate?.complete();
    _writeGate = null;
  }

  @override
  Future<Uri?> resolve(String assetKey) => _store.resolve(assetKey);

  @override
  Future<Uri?> write(String assetKey, List<int> bytes) async {
    writes.add(assetKey);
    if (blockNextWrite) {
      blockNextWrite = false;
      final gate = _writeGate = Completer<void>();
      if (!writeStarted.isCompleted) writeStarted.complete();
      await gate.future;
      writeStarted = Completer<void>();
    }

    return _store.write(assetKey, bytes);
  }

  @override
  Future<void> delete(String assetKey) async {
    if (assetKey == failDeleteFor) {
      throw StateError('Cannot delete $assetKey.');
    }

    return _store.delete(assetKey);
  }
}

DeckGenerationResult _result(String assetKey) => DeckGenerationResult.success(
  slides: [_generatedSlide(assetKey)],
  plan: _plan(assetKey),
  theme: _resolvedTheme(),
  generatedImages: [
    GeneratedImageAsset.success(assetKey: assetKey, bytes: [1, 2, 3]),
  ],
);

Slide _generatedSlide(String assetKey) => Slide.parse({
  'key': 'opening',
  'options': {'title': 'Opening', 'style': 'visual'},
  'sections': [
    {
      'type': 'section',
      'blocks': [
        {
          'type': 'widget',
          'name': 'image',
          'args': {'src': assetKey, 'fit': 'cover'},
        },
      ],
    },
  ],
});

DeckPlan _plan(String assetKey) => DeckPlan.parse({
  'topic': 'Generated artwork',
  'story': 'One image supports one clear point.',
  'theme': {'id': 'technical-paper', 'version': 1, 'density': 'balanced'},
  'sections': [
    {
      'key': 'main',
      'title': 'Main',
      'purpose': 'Introduce the idea.',
      'transition': 'Close clearly.',
      'slideKeys': ['opening'],
    },
  ],
  'slides': [
    {
      'key': 'opening',
      'title': 'Opening',
      'purpose': 'Introduce the idea.',
      'sectionKey': 'main',
      'assertion': 'The visual makes the idea tangible.',
      'contentUnits': ['One focused supporting statement.'],
      'narrativeRole': 'opening',
      'contentBrief': 'Open with one clear idea.',
      'continuity': 'Lead into the story.',
      'composition': 'imageFullBleed',
      'treatment': 'visual',
      'density': 'balanced',
      'elements': [
        {'type': 'image', 'purpose': 'Anchor the story.', 'source': assetKey},
      ],
    },
  ],
});

ResolvedPresentationTheme _resolvedTheme() =>
    PresentationThemeCatalog.withDefaults().resolve(
      id: 'technical-paper',
      version: 1,
      density: 'balanced',
      typographyCatalog: PresentationTypographyCatalog.withDefaults(),
    );
